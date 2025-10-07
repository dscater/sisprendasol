<?php

namespace App\Http\Controllers;

use App\Models\Area;
use App\Models\Cliente;
use App\Models\Configuracion;
use App\Models\HistorialOferta;
use App\Models\Publicacion;
use App\Models\PublicacionDetalle;
use App\Models\ReporteFinanciero;
use App\Models\SubastaCliente;
use App\Models\Tarea;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;
use Carbon\Carbon;

class ReporteController extends Controller
{
    public function usuarios()
    {
        return Inertia::render("Admin/Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        $tipo =  $request->tipo;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($tipo != 'todos') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios->where('tipo', $tipo);
        }

        $usuarios = $usuarios->orderBy("paterno", "ASC")->get();

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('usuarios.pdf');
    }


    public function clientes()
    {
        return Inertia::render("Admin/Reportes/Clientes");
    }

    public function r_clientes(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $clientes = Cliente::select("clientes.*");

        if ($fecha_ini && $fecha_fin) {
            $clientes->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
        }

        $clientes = $clientes->get();

        $pdf = PDF::loadView('reportes.clientes', compact('clientes'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('clientes.pdf');
    }

    public function reporte_financieros()
    {
        return Inertia::render("Admin/Reportes/ReporteFinancieros");
    }

    public function r_reporte_financieros(Request $request)
    {
        $tipo =  $request->tipo;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $reporte_financieros = ReporteFinanciero::select("reporte_financieros.*");

        if ($tipo != 'todos') {
            $reporte_financieros->where("tipo", $tipo);
        }

        if ($fecha_ini && $fecha_fin) {
            $reporte_financieros->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
        }

        $reporte_financieros = $reporte_financieros->get();

        $pdf = PDF::loadView('reportes.reporte_financieros', compact('reporte_financieros'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('reporte_financieros.pdf');
    }


    public function rg_tareas(Request $request)
    {
        $estado = $request->estado;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $areas = Area::all();
        $categories = Area::pluck("nombre")->toArray();
        $estados = ["PENDIENTE", "INICIADO", "FINALIZADO"];
        if ($estado != 'todos') {
            $estados = [$estado];
        }

        $data = [];
        foreach ($estados as $key => $estado) {
            $data[] = [
                "name" => $estado,
                "data" => []
            ];
            foreach ($areas as $area) {
                if (Auth::user()->tipo == 'OPERARIOS') {
                    $tareas = Tarea::select("tareas.*")
                        ->join("tarea_operarios", "tarea_operarios.tarea_id", "=", "tareas.id");
                    $tareas->where("tarea_operarios.user_id", Auth::user()->id);
                    $tareas->where("tareas.area_id", $area->id);
                    $tareas->where("tareas.estado", $estado);
                    if ($fecha_ini && $fecha_fin) {
                        $tareas->whereBetween("tareas.fecha_registro", [$fecha_ini, $fecha_fin]);
                    }
                    $tareas->distinct("tareas.id");
                    $tareas->groupBy("tareas.id");
                    $tareas = $tareas->count();
                } else {
                    $tareas = Tarea::select("tareas.*");
                    $tareas->where("estado", $estado);
                    $tareas->where("area_id", $area->id);
                    if ($fecha_ini && $fecha_fin) {
                        $tareas->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
                    }
                    $tareas = $tareas->count();
                }

                $data[$key]["data"][] = $tareas;
            }
        }

        return response()->JSON([
            "categories" => $categories,
            "data" => $data,
        ]);
    }
}
