<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
// use App\Models\ActividadmisioneraModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ActividadmisioneraController extends Controller
{
    //
    private $base_model;
    private $perfiles_model;
    
    public function __construct() {
        parent:: __construct();
        // $this->perfiles_model = new ActividadmisioneraModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "actividad_misionera.index";
        $data["title"] = traducir("traductor.titulo_actividad_misionera");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->perfiles_model->tabla()->HTML();

        // $botones = array();
        // $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-perfil">'.traducir("traductor.nuevo").' [F1]</button>';
        // $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">'.traducir("traductor.eliminar").' [F7]</button>';
        // $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["actividad_misionera.js"]);
        return parent::init($view, $data);

      
       
    }

    public function reporte() {
        $view = "actividad_misionera.reporte";
        $data["title"] = traducir("traductor.titulo_reporte_actividad_misionera");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->perfiles_model->tabla()->HTML();

        $data["scripts"] = $this->cargar_js(["reporte_actividad_misionera.js"]);
        return parent::init($view, $data);

      
       
    }

    // public function buscar_datos() {
    //     $json_data = $this->perfiles_model->tabla()->obtenerDatos();
    //     echo json_encode($json_data);
    // }


    public function guardar_actividad(Request $request) {
   
        // $_POST = $this->toUpper($_POST);
        // if ($request->input("perfil_id") == '') {
        //     $result = $this->base_model->insertar($this->preparar_datos("seguridad.perfiles", $_POST));
        // }else{
        //     $result = $this->base_model->modificar($this->preparar_datos("seguridad.perfiles", $_POST));
        // }
        
        $accion = $request->input("accion");
        $idactividadmisionera = $request->input("idactividadmisionera");
        $valor = $request->input("valor");
        $semana = $request->input("semana");
        $anio = $request->input("anio");
        $idtrimestre = $request->input("idtrimestre");
        $_POST["trimestre"] = $idtrimestre;
        $idiglesia = $request->input("idiglesia");

        $sql_validacion = "SELECT * FROM iglesias.controlactmisionera WHERE idactividadmisionera={$idactividadmisionera} AND anio='{$anio}' AND trimestre={$idtrimestre} AND idiglesia={$idiglesia} AND semana={$semana}";

        // die($sql_validacion);
        $validacion = DB::select($sql_validacion);

        if($accion == "valor") {
            DB::table("iglesias.controlactmisionera")->where(array("idactividadmisionera" => $idactividadmisionera, "anio" => $anio, "trimestre" => $idtrimestre, "semana" => $semana, "idiglesia" => $idiglesia))->delete();


            $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
        }
        

        if($accion == "cantidad") {
            
            if(count($validacion) > 0) {
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } else {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } 
        }

        if($accion == "asistentes") {
            $_POST["valor"] = "";
            $_POST["asistentes"] = $valor;
            if(count($validacion) > 0) {
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } else {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            }
          
        }

        if($accion == "interesados") {
            $_POST["valor"] = "";
            $_POST["interesados"] = $valor;
            if(count($validacion) > 0) {
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } else {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            }
          
        }
    
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM seguridad.perfiles WHERE perfil_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

 

    public function obtener_anios() {
        $result = array();
        $array = array();
        for($i=date("Y"); $i>=2021; $i-- ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        echo json_encode($array);
    }


    public function obtener_trimestres() {
        $sql = "SELECT idtrimestre AS id, descripcion FROM public.trimestre
        ORDER BY idtrimestre ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_actividades(Request $request) {
        $anio = $request->input("anio");
        $idtrimestre = $request->input("idtrimestre");
        $idiglesia = $request->input("idiglesia");

        $where = "";
        if($idtrimestre != "0") {
            $where .= ' AND c.trimestre='.$idtrimestre;
        }

        if($idiglesia != "0") {
            $where .= ' AND c.idiglesia='.$idiglesia;
        }

        $sql = "SELECT am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, c.idiglesia, c.semana, SUM(c.valor) AS valor, SUM(c.asistentes) AS asistententes, SUM(c.interesados) AS interesados FROM iglesias.actividadmisionera AS am
        LEFT JOIN iglesias.controlactmisionera AS c ON(am.idactividadmisionera=c.idactividadmisionera AND c.anio='{$anio}' ".$where.")
        GROUP BY am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, c.idiglesia, c.semana
        ORDER BY am.idactividadmisionera ASC";
        // die($sql);
        $result = DB::select($sql);

        echo json_encode($result);
    }
    

    public function obtener_trimestres_todos() {
        
        $array = array("id" => 0, "descripcion" => "Todos");
        $array = (object) $array;

    //  print_r($array);
        $sql = "SELECT idtrimestre AS id, descripcion FROM public.trimestre
        ORDER BY idtrimestre ASC";
        $result = DB::select($sql);
        array_push($result, $array);
        echo json_encode($result);
    }
}
