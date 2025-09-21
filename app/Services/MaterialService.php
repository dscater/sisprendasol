<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Material;
use App\Models\TareaMaterial;
use App\Models\Tmaterial;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class MaterialService
{
    private $modulo = "MATERIALES";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $materials = Material::select("materials.*")->get();
        return $materials;
    }

    public function listadoDataTable(int $length, int $start, int $page, string $search): LengthAwarePaginator
    {
        $materials = Material::select("materials.*");
        if ($search && trim($search) != '') {
            $materials->where("nombre", "LIKE", "%$search%");
        }
        $materials = $materials->paginate($length, ['*'], 'page', $page);
        return $materials;
    }

    /**
     * Crear material
     *
     * @param array $datos
     * @return Material
     */
    public function crear(array $datos): Material
    {

        $material = Material::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d")
        ]);
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN MATERIAL", $material);

        return $material;
    }

    /**
     * Actualizar material
     *
     * @param array $datos
     * @param Material $material
     * @return Material
     */
    public function actualizar(array $datos, Material $material): Material
    {
        $old_material = Material::find($material->id);
        $material->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN MATERIAL", $old_material, $material);

        return $material;
    }

    /**
     * Eliminar material
     *
     * @param Material $material
     * @return boolean
     */
    public function eliminar(Material $material): bool
    {
        // verificar usos
        $usos = TareaMaterial::where("material_id", $material->id)->get();
        if (count($usos) > 0) {
            throw ValidationException::withMessages([
                'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
            ]);
        }
        // no eliminar materials predeterminados para el funcionamiento del sistema
        $old_material = Material::find($material->id);
        $material->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN MATERIAL", $old_material);

        return true;
    }
}
