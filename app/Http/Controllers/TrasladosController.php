<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TrasladosController extends Controller
{
    //
    private $base_model;

    
    public function __construct() {
        parent:: __construct();
      
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "traslados.index";
        $data["title"] = traducir("traductor.titulo_traslados_iglesia");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->traslados_model->tabla()->HTML();

        // $botones = array();
        // $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-perfil">'.traducir("traductor.nuevo").' [F1]</button>';
        // $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">'.traducir("traductor.eliminar").' [F7]</button>';
        // $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["traslados.js"]);
        return parent::init($view, $data);

      
       
    }

    // public function buscar_datos() {
    //     $json_data = $this->traslados_model->tabla()->obtenerDatos();
    //     echo json_encode($json_data);
    // }


    public function guardar_traslados(Request $request) {
   
        $_POST = $this->toUpper($_POST);
        if ($request->input("perfil_id") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("seguridad.traslados", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("seguridad.traslados", $_POST));
        }

   
        DB::table("seguridad.traslados_idiomas")->where("perfil_id", $result["id"])->delete();
        if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {
     
            $_POST["perfil_id"] = $result["id"];
           
            $this->base_model->insertar($this->preparar_datos("seguridad.traslados_idiomas", $_POST, "D"), "D");
        }
        echo json_encode($result);
    }

    public function guardar_traslados_temp(Request $request) {
        // print_r($_REQUEST);
        $array_pais = explode("|", $_POST["pais_id"]);
        $_POST["pais_id"] = $array_pais[0];
        if($array_pais[1] == "N" && empty($request->input("idunion"))) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_POST["pais_id"]}";
            $res = DB::select($sql);
            $_POST["idunion"] = $res[0]->idunion;
     
        }

        $sql = "SELECT * FROM iglesias.vista_asociados_traslados 
        WHERE iddivision={$request->input('iddivision')} AND pais_id={$_POST["pais_id"]} AND idunion={$_POST["idunion"]} AND idmision={$request->input('idmision')} AND iddistritomisionero={$request->input('iddistritomisionero')} AND  idiglesia={$request->input('idiglesia')}";
        
        $asociados = DB::select($sql);

        foreach($asociados as $value) {
            $array = (array) $value;
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.temp_traslados", $array));
        }


        echo json_encode($result);
    
       
    }

    public function eliminar_traslados() {
       

        try {
            $sql_usuarios = "SELECT * FROM seguridad.usuarios WHERE perfil_id=".$_REQUEST["id"];
            $usuarios = DB::select($sql_usuarios);

            if(count($usuarios) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, ESTE PERFIL YA ESTA ASIGNADO A UN USUARIO");
            }

            $sql_permisos = "SELECT * FROM seguridad.permisos WHERE perfil_id=".$_REQUEST["id"];
            $permisos = DB::select($sql_permisos);

            if(count($permisos) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, ESTE PERFIL YA TIENE ASIGNADO PERMISOS");
            }

            $result = $this->base_model->eliminar(["seguridad.traslados","perfil_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM seguridad.traslados WHERE perfil_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_traslados() {
        $sql = "SELECT p.perfil_id AS id, 
        CASE WHEN pi.pi_descripcion IS NULL THEN 
        (SELECT pi_descripcion FROM seguridad.traslados_idiomas WHERE perfil_id=p.perfil_id AND idioma_id=".session("idioma_id_defecto").")
        ELSE pi.pi_descripcion END AS descripcion 
        FROM seguridad.traslados AS p 
        LEFT JOIN seguridad.traslados_idiomas AS pi ON(pi.perfil_id=p.perfil_id AND pi.idioma_id=".session("idioma_id").")
        WHERE p.estado='A'";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }


    
    public function obtener_traducciones(Request $request) {
        $sql = "SELECT pi.idioma_id, pi.pi_descripcion AS descripcion, i.idioma_descripcion FROM seguridad.traslados_idiomas AS pi
        INNER JOIN public.idiomas AS i ON(i.idioma_id=pi.idioma_id)
        WHERE pi.perfil_id=".$request->input("perfil_id")."
        ORDER BY pi.idioma_id ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }
    
}
