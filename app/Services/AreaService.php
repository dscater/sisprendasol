<?php

namespace App\Services;

use App\Models\IngresoProducto;
use App\Models\Manzano;
use App\Services\HistorialAccionService;
use App\Models\Area;
use App\Models\Tarea;
use App\Models\Terreno;
use App\Models\Urbanizacion;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class AreaService
{
    private $modulo = "ÁREAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $areas = Area::select("areas.*")->get();
        return $areas;
    }

    public function listadoDataTable(int $length, int $start, int $page, string $search): LengthAwarePaginator
    {
        $areas = Area::select("areas.*");
        if ($search && trim($search) != '') {
            $areas->where("nombre", "LIKE", "%$search%");
        }
        $areas = $areas->paginate($length, ['*'], 'page', $page);
        return $areas;
    }

    /**
     * Crear area
     *
     * @param array $datos
     * @return Area
     */
    public function crear(array $datos): Area
    {

        $area = Area::create([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
            "fecha_registro" => date("Y-m-d")
        ]);
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN ÁREA DE PRODUCCIÓN", $area);

        return $area;
    }

    /**
     * Actualizar area
     *
     * @param array $datos
     * @param Area $area
     * @return Area
     */
    public function actualizar(array $datos, Area $area): Area
    {
        $old_area = Area::find($area->id);
        $area->update([
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => mb_strtoupper($datos["descripcion"]),
        ]);
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN ÁREA DE PRODUCCIÓN", $old_area, $area);

        return $area;
    }

    /**
     * Eliminar area
     *
     * @param Area $area
     * @return boolean
     */
    public function eliminar(Area $area): bool
    {
        // verificar usos
        $usos = Tarea::where("area_id", $area->id)->get();
        if (count($usos) > 0) {
            throw ValidationException::withMessages([
                'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
            ]);
        }
        // no eliminar areas predeterminados para el funcionamiento del sistema
        $old_area = Area::find($area->id);
        $area->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN ÁREA DE PRODUCCIÓN", $old_area);

        return true;
    }
}
