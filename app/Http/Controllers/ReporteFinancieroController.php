<?php

namespace App\Http\Controllers;

use App\Http\Requests\ReporteFinancieroStoreRequest;
use App\Http\Requests\ReporteFinancieroUpdateRequest;
use App\Models\ReporteFinanciero;
use App\Services\ReporteFinancieroService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response as InertiaResponse;
use PhpOffice\PhpSpreadsheet\IOFactory;

class ReporteFinancieroController extends Controller
{
    public function __construct(private ReporteFinancieroService $reporteFinancieroService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): InertiaResponse
    {
        return Inertia::render("Admin/ReporteFinancieros/Index");
    }

    /**
     * Listado de reporte_financieros
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "reporte_financieros" => $this->reporteFinancieroService->listado()
        ]);
    }

    /**
     * Listado de reporte_financieros para portal
     *
     * @return JsonResponse
     */
    public function listadoPortal(): JsonResponse
    {
        return response()->JSON([
            "reporte_financieros" => $this->reporteFinancieroService->listado()
        ]);
    }

    /**
     * Endpoint para obtener la lista de reporte_financieros paginado para datatable
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function api(Request $request): JsonResponse
    {

        $length = (int)$request->input('length', 10); // Valor de `length` enviado por DataTable
        $start = (int)$request->input('start', 0); // Índice de inicio enviado por DataTable
        $page = (int)(($start / $length) + 1); // Cálculo de la página actual
        $search = (string)$request->input('search', '');

        $usuarios = $this->reporteFinancieroService->listadoDataTable($length, $start, $page, $search);

        return response()->JSON([
            'data' => $usuarios->items(),
            'recordsTotal' => $usuarios->total(),
            'recordsFiltered' => $usuarios->total(),
            'draw' => intval($request->input('draw')),
        ]);
    }

    /**
     * Registrar un nuevo reporte_financiero
     *
     * @param ReporteFinancieroStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(ReporteFinancieroStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el ReporteFinanciero
            $this->reporteFinancieroService->crear($request->validated());
            DB::commit();
            return redirect()->route("reporte_financieros.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un reporte_financiero
     *
     * @param ReporteFinanciero $reporte_financiero
     * @return JsonResponse
     */
    public function show(ReporteFinanciero $reporte_financiero): JsonResponse
    {
        return response()->JSON($reporte_financiero);
    }

    public function update(ReporteFinanciero $reporte_financiero, ReporteFinancieroUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar reporte_financiero
            $this->reporteFinancieroService->actualizar($request->validated(), $reporte_financiero);
            DB::commit();
            return redirect()->route("reporte_financieros.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar reporte_financiero
     *
     * @param ReporteFinanciero $reporte_financiero
     * @return JsonResponse|Response
     */
    public function destroy(ReporteFinanciero $reporte_financiero): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->reporteFinancieroService->eliminar($reporte_financiero);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function archivos(Request $request)
    {
        $archivo1 = $request->file('archivo1');
        $spreadsheet = IOFactory::load($archivo1->getPathname());
        $hoja = $spreadsheet->getActiveSheet();
        $datos = $hoja->toArray();

        foreach ($datos as $fila) {
            // Procesa cada fila
        }

        $archivo2 = $request->file('archivo2');
        $spreadsheet = IOFactory::load($archivo2->getPathname());
        $hoja = $spreadsheet->getActiveSheet();
        $datos = $hoja->toArray();

        foreach ($datos as $fila) {
            // Procesa cada fila
        }

        return response()->json(['data' => $datos]);
    }
}
