<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\TipoDocumento;
use App\Models\TipoDocumentoMaterial;
use App\Models\TipoDocumentoOperario;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class TipoDocumentoService
{
    private $modulo = "TAREAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $tipo_documentos = TipoDocumento::select("tipo_documentos.*")
            ->join("tipo_documento_operarios", "tipo_documento_operarios.tipo_documento_id", "=", "tipo_documentos.id");

        if (Auth::user()->tipo == 'OPERARIOS') {
            $tipo_documentos->where("tipo_documento_operarios.user_id", Auth::user()->id);
        }
        $tipo_documentos->distinct("tipo_documentos.id");
        $tipo_documentos->groupBy("tipo_documentos.id");
        $tipo_documentos = $tipo_documentos->get();
        return $tipo_documentos;
    }

    public function listadoDataTable(int $length, int $start, int $page, string $search): LengthAwarePaginator
    {
        $tipo_documentos = TipoDocumento::with(["area", "producto", "supervisor", "tipo_documento_materials", "tipo_documento_operarios"])->select("tipo_documentos.*")
            ->join("tipo_documento_operarios", "tipo_documento_operarios.tipo_documento_id", "=", "tipo_documentos.id");
        if ($search && trim($search) != '') {
            $tipo_documentos->where("nombre", "LIKE", "%$search%");
        }
        if (Auth::user()->tipo == 'OPERARIOS') {
            $tipo_documentos->where("tipo_documento_operarios.user_id", Auth::user()->id);
        }
        $tipo_documentos->distinct("tipo_documentos.id");
        $tipo_documentos->groupBy("tipo_documentos.id");
        $tipo_documentos = $tipo_documentos->paginate($length, ['*'], 'page', $page);
        return $tipo_documentos;
    }

    /**
     * Crear tipo_documento
     *
     * @param array $datos
     * @return TipoDocumento
     */
    public function crear(array $datos): TipoDocumento
    {
        $user = Auth::user();
        $tipo = $user->tipo;
        $acodigo = $this->generarCodigoTipoDocumento();
        $tipo_documento = TipoDocumento::create([
            "codigo" => $acodigo[1],
            "nro_cod" => $acodigo[0],
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "area_id" => $datos["area_id"],
            "producto_id" => $datos["producto_id"],
            "user_id" => $datos["user_id"],
            "estado" => $tipo == 'SUPERVISOR' ? $datos["estado"] : 'PENDIENTE',
            "fecha_registro" => date("Y-m-d")
        ]);

        foreach ($datos["tipo_documento_materials"] as $item) {
            $tipo_documento->tipo_documento_materials()->create([
                "material_id" => $item["material_id"]
            ]);
        }

        foreach ($datos["tipo_documento_operarios"] as $item) {
            $tipo_documento->tipo_documento_operarios()->create([
                "user_id" => $item["user_id"]
            ]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA TAREA", $tipo_documento, null, ["tipo_documento_materials", "tipo_documento_operarios"]);

        return $tipo_documento;
    }

    /**
     * Actualizar tipo_documento
     *
     * @param array $datos
     * @param TipoDocumento $tipo_documento
     * @return TipoDocumento
     */
    public function actualizar(array $datos, TipoDocumento $tipo_documento): TipoDocumento
    {
        $old_area = clone $tipo_documento;
        $old_area->loadMissing(["tipo_documento_materials", "tipo_documento_operarios"]);

        $user = Auth::user();
        $tipo = $user->tipo;

        $tipo_documento->update([
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "area_id" => $datos["area_id"],
            "producto_id" => $datos["producto_id"],
            "user_id" => $datos["user_id"],
        ]);
        if ($tipo == 'SUPERVISOR') {
            $tipo_documento->estado = $datos["estado"];
            $tipo_documento->save();
        }

        if (isset($datos["eliminados_materials"]) && $datos["eliminados_materials"]) {
            foreach ($datos["eliminados_materials"] as $id) {
                $tipo_documento_material = TipoDocumentoMaterial::findOrFail($id);
                $tipo_documento_material->delete();
            }
        }


        if (isset($datos["eliminados_operarios"]) && $datos["eliminados_operarios"]) {
            foreach ($datos["eliminados_operarios"] as $id) {
                $tipo_documento_operario = TipoDocumentoOperario::findOrFail($id);
                $tipo_documento_operario->delete();
            }
        }

        foreach ($datos["tipo_documento_materials"] as $item) {
            if ($item["id"] != 0) {
                $tipo_documento_material = TipoDocumentoMaterial::findOrFail($item["id"]);
                $tipo_documento_material->update(["material_id" => $item["material_id"]]);
            } else {
                $tipo_documento->tipo_documento_materials()->create([
                    "material_id" => $item["material_id"]
                ]);
            }
        }

        foreach ($datos["tipo_documento_operarios"] as $item) {
            if ($item["id"] != 0) {
                $tipo_documento_operario = TipoDocumentoOperario::findOrFail($item["id"]);
                $tipo_documento_operario->update(["user_id" => $item["user_id"]]);
            } else {
                $tipo_documento->tipo_documento_operarios()->create([
                    "user_id" => $item["user_id"]
                ]);
            }
        }



        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA TAREA", $old_area, $tipo_documento, ["tipo_documento_materials", "tipo_documento_operarios"]);

        return $tipo_documento;
    }

    /**
     * Eliminar tipo_documento
     *
     * @param TipoDocumento $tipo_documento
     * @return boolean
     */
    public function eliminar(TipoDocumento $tipo_documento): bool
    {
        // verificar usos
        $usos = TipoDocumento::where("area_id", $tipo_documento->id)->get();
        if (count($usos) > 0) {
            throw ValidationException::withMessages([
                'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
            ]);
        }
        $old_area = clone $tipo_documento;
        $old_area->loadMissing(["tipo_documento_materials", "tipo_documento_operarios"]);
        $tipo_documento->tipo_documento_materials()->delete();
        $tipo_documento->tipo_documento_operarios()->delete();
        $tipo_documento->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA TAREA", $old_area);

        return true;
    }

    private function generarCodigoTipoDocumento()
    {
        $ultimo = TipoDocumento::get()->last();
        $nro = 1;
        $codigo = "";
        if ($ultimo) {
            $nro = (int)$ultimo->nro_cod + 1;
        }

        $codigo = "T." . $nro;
        return [$nro, $codigo];
    }
}
