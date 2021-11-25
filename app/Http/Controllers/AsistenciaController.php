<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\AsistenciaModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class AsistenciaController extends Controller
{
    //
    private $base_model;
    private $asistencia_model;
    
    public function __construct() {
        parent:: __construct();
        $this->asistencia_model = new AsistenciaModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "asistencia.index";
        $data["title"] = traducir("asambleas.titulo_asistencia");
        $data["subtitle"] = "";
        $data["tabla"] = $this->asistencia_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-asistencia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-asistencia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-asistencia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["asistencia.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->asistencia_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_asistencia(Request $request) {
        $asamblea = explode("|", $_POST["asamblea_id"]);
        $_POST["asamblea_id"] = $asamblea[1];
        $_POST = $this->toUpper($_POST);
        if ($request->input("asistencia_id") == '') {
            $_POST["asistencia_fecha"] = date("Y-m-d");
            $_POST["asistencia_hora"] = date("H:i:s");
            $result = $this->base_model->insertar($this->preparar_datos("asambleas.asistencia", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("asambleas.asistencia", $_POST));
        }

   
        // DB::table("asambleas.asistencia_idiomas")->where("asistencia_id", $result["id"])->delete();
        // if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {
     
        //     $_POST["asistencia_id"] = $result["id"];
           
        //     $this->base_model->insertar($this->preparar_datos("asambleas.asistencia_idiomas", $_POST, "D"), "D");
        // }
        $sql_asamblea = "SELECT * FROM asambleas.asambleas WHERE asamblea_id={$asamblea[1]}";
        $asamblea = DB::select($sql_asamblea);
        $result["datos"][0]["asamblea"] = $asamblea[0]->asamblea_descripcion;
        echo json_encode($result);
    }

    public function eliminar_asistencia() {
       

        try {
            // $sql_usuarios = "SELECT * FROM asambleas.usuarios WHERE asistencia_id=".$_REQUEST["id"];
            // $usuarios = DB::select($sql_usuarios);

            // if(count($usuarios) > 0) {
            //     throw new Exception(traducir("traductor.eliminar_perfil_usuario"));
            // }

            $sql_detalle = "SELECT * FROM asambleas.detalle_asistencia WHERE asistencia_id=".$_REQUEST["id"];
            $detalle = DB::select($sql_detalle);

            if(count($detalle) > 0) {
                throw new Exception(traducir("traductor.eliminar_asistencia_detalle"));
            }

            $result = $this->base_model->eliminar(["asambleas.asistencia","asistencia_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_asistencia(Request $request) {

        $sql = "SELECT a.*, (tc.tipconv_id  || '|'  || a.asamblea_id) AS asamblea_id FROM asambleas.asistencia  AS a
        INNER JOIN asambleas.asambleas AS aa ON(aa.asamblea_id=a.asamblea_id)
        INNER JOIN asambleas.tipo_convocatoria AS tc ON(tc.tipconv_id=aa.tipconv_id)
        WHERE a.asistencia_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_asistencia() {
        $sql = "SELECT p.asistencia_id AS id, 
        CASE WHEN pi.pi_descripcion IS NULL THEN 
        (SELECT pi_descripcion FROM asambleas.asistencia_idiomas WHERE asistencia_id=p.asistencia_id AND idioma_id=".session("idioma_id_defecto").")
        ELSE pi.pi_descripcion END AS descripcion 
        FROM asambleas.asistencia AS p 
        LEFT JOIN asambleas.asistencia_idiomas AS pi ON(pi.asistencia_id=p.asistencia_id AND pi.idioma_id=".session("idioma_id").")
        WHERE p.estado='A'";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }


    

    
}
