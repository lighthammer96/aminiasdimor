<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
// use App\Models\ActividadmisioneraModel;
// use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PDF;
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
        $mes = $request->input("mes");

        $_POST["fecha_inicial"] = $this->FormatoFecha($_REQUEST["fecha_inicial"], "server");
        $_POST["fecha_final"] = $this->FormatoFecha($_REQUEST["fecha_final"], "server");
        // $idtrimestre = $request->input("idtrimestre");
        // $_POST["trimestre"] = $idtrimestre;
        $idiglesia = $request->input("idiglesia");

        
        $sql_validacion = "SELECT * FROM iglesias.controlactmisionera WHERE idactividadmisionera={$idactividadmisionera} AND anio='{$anio}' AND mes={$mes} AND idiglesia={$idiglesia} AND semana={$semana}";

        // die($sql_validacion);
        $validacion = DB::select($sql_validacion);

        if($accion == "valor") {
            DB::table("iglesias.controlactmisionera")->where(array("idactividadmisionera" => $idactividadmisionera, "anio" => $anio, "mes" => $mes, "semana" => $semana, "idiglesia" => $idiglesia))->delete();


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
        // $idtrimestre = $request->input("idtrimestre");
        $mes = $request->input("mes");
        $semana = $request->input("semana");
        $idiglesia = $request->input("idiglesia");

        $where = "";
        // if($idtrimestre != "0") {
        //     $where .= ' AND c.trimestre='.$idtrimestre;
        // }

        if($anio != "0") {
            $where .= " AND c.anio='".$anio."'";
        }

        if(!isset($_REQUEST["idtrimestre"])) {
            if($mes != "0") {
                $where .= ' AND c.mes='.$mes;
            }
    
    
            if($semana != "0") {
                $where .= ' AND c.semana='.$semana;
            }
        } else {
            switch ($_REQUEST["idtrimestre"]) {
                case 1:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-01-01' AND '".$anio."-03-31'";
                    break;
                case 2:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-04-01' AND '".$anio."-06-30'";
                    break;
                case 3:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-07-01' AND '".$anio."-09-30'";
                    break;
                case 4:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-10-01' AND '".$anio."-12-31'";
                    break;
            }
        }
       

        if($idiglesia != "0") {
            $where .= ' AND c.idiglesia='.$idiglesia;
        }

        $sql = "SELECT am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, c.semana, SUM(c.valor) AS valor, SUM(c.asistentes) AS asistententes, SUM(c.interesados) AS interesados,
        array_to_string(array_agg(c.planes), '\n') AS planes, array_to_string(array_agg(c.informe_espiritual), '\n') AS informe_espiritual
        FROM iglesias.actividadmisionera AS am
        LEFT JOIN iglesias.controlactmisionera AS c ON(am.idactividadmisionera=c.idactividadmisionera ".$where.")
        GROUP BY am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, c.semana
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


    public function imprimir_actividades_misioneras(Request $request) {
        // print_r($_GET);
        $datos = array();
        $anio = $request->input("anio");
        // $idtrimestre = $request->input("idtrimestre");
        // $mes = $request->input("mes");
        // $semana = $request->input("semana");
        $idiglesia = $request->input("idiglesia");

        $where = "";
        $where .= " AND c.anio='".$anio."'";

        switch ($_REQUEST["idtrimestre"]) {
            case 1:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-01-01' AND '".$anio."-03-31'";
                break;
            case 2:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-04-01' AND '".$anio."-06-30'";
                break;
            case 3:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-07-01' AND '".$anio."-09-30'";
                break;
            case 4:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-10-01' AND '".$anio."-12-31'";
                break;
        }

        $where .= ' AND c.idiglesia='.$idiglesia;


        $sql = "SELECT
        ".formato_fecha_idioma("c.fecha_final")." AS fecha_final,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=1 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS estudios_biblicos,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=2 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS visitas_misioneras,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=19 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS conferencias_publicas,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=20 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS seminarios,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=22 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS congresos,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=28 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS libros,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=29 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS revistas,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=30 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS volantes,
        
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=31 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS lecciones,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=32 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS guard,
        
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=33 AND 
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS ancla_juvenil
        
        
        FROM iglesias.controlactmisionera AS c  
        WHERE 1=1 ".$where." 
            
        GROUP BY c.fecha_final, c.anio, c.idiglesia, c.semana 
        ORDER BY c.fecha_final ASC";
        // die($sql);
        $actividades = DB::select($sql);

        $sql_textos = " SELECT ".formato_fecha_idioma("c.fecha_final")." AS fecha_final, array_to_string(array_agg(c.planes), '\n') AS planes, array_to_string(array_agg(c.informe_espiritual), '\n') AS informe_espiritual
        FROM iglesias.controlactmisionera AS c  
        WHERE 1=1 ".$where." 
            
        GROUP BY c.fecha_final
        ORDER BY c.fecha_final ASC
        ";
        // die($sql_textos);
        $textos = DB::select($sql_textos); 


        $sql_director = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=5 AND cm.vigente='1' AND  m.idiglesia=".$idiglesia;

        $director = DB::select($sql_director);


        $sql_director_obra = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=20 AND cm.vigente='1' AND  m.idiglesia=".$idiglesia;

        $director_obra = DB::select($sql_director_obra);


        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["anio"] = $_REQUEST["anio"];
        $datos["actividades"] = $actividades;
        $datos["director"] = (isset($director[0]->nombres))  ? $director[0]->nombres : "";
        $datos["director_obra"] = (isset($director_obra[0]->nombres))  ? $director_obra[0]->nombres : "";
        $datos["planes"] = (isset($textos[0]->planes)) ? $textos[0]->planes : "";
        $datos["informe_espiritual"] = (isset($textos[0]->informe_espiritual)) ? $textos[0]->informe_espiritual : "";
        
        $datos["trimestre"] = traducir("traductor.trimestre_".$_REQUEST["idtrimestre"]);

        $pdf = PDF::loadView("actividad_misionera.imprimir", $datos)->setPaper('A4', "portrait");


        
        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("actividades_misioneras.pdf"); // ver
    }
}
