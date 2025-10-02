<?php

namespace App\Services;

use App\Models\ReporteFinanciero;
use App\Services\HistorialAccionService;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class ReporteFinancieroService
{
    private $modulo = "REPORTE FINANCIERO";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $reporte_financieros = ReporteFinanciero::select("reporte_financieros.*");
        $reporte_financieros = $reporte_financieros->get();
        return $reporte_financieros;
    }

    public function listadoDataTable(int $length, int $start, int $page, string $search): LengthAwarePaginator
    {
        $reporte_financieros = ReporteFinanciero::with(["tipo_documento", "cliente"])
            ->select("reporte_financieros.*");
        if ($search && trim($search) != '') {
            $reporte_financieros->where("nombre", "LIKE", "%$search%");
        }
        $reporte_financieros = $reporte_financieros->paginate($length, ['*'], 'page', $page);
        return $reporte_financieros;
    }

    /**
     * Crear reporte_financiero
     *
     * @param array $datos
     * @return ReporteFinanciero
     */
    public function crear(array $datos): ReporteFinanciero
    {
        $reporte_financiero = ReporteFinanciero::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d")
        ]);
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN REPORTE FINANCIERO", $reporte_financiero, null);

        return $reporte_financiero;
    }

    /**
     * Actualizar reporte_financiero
     *
     * @param array $datos
     * @param ReporteFinanciero $reporte_financiero
     * @return ReporteFinanciero
     */
    public function actualizar(array $datos, ReporteFinanciero $reporte_financiero): ReporteFinanciero
    {
        $old_reporte_financiero = clone $reporte_financiero;
        $reporte_financiero->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN REPORTE FINANCIERO", $old_reporte_financiero, $reporte_financiero);

        return $reporte_financiero;
    }

    /**
     * Eliminar reporte_financiero
     *
     * @param ReporteFinanciero $reporte_financiero
     * @return boolean
     */
    public function eliminar(ReporteFinanciero $reporte_financiero): bool
    {
        // verificar usos
        $usos = ReporteFinanciero::where("reporte_financiero_id", $reporte_financiero->id)->get();
        if (count($usos) > 0) {
            throw ValidationException::withMessages([
                'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
            ]);
        }
        $old_reporte_financiero = clone $reporte_financiero;
        $reporte_financiero->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN REPORTE FINANCIERO", $old_reporte_financiero);

        return true;
    }
}
