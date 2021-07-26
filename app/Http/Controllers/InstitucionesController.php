<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\InstitucionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class InstitucionesController extends Controller
{
    //
    private $base_model;
    private $instituciones_model;
    
    public function __construct() {
        parent:: __construct();
        $this->instituciones_model = new InstitucionesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "instituciones.index";
        $data["title"] = traducir("traductor.titulo_instituciones");
        $data["subtitle"] = "";
        $data["tabla"] = $this->instituciones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-institucion">'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-institucion">'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-institucion">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["instituciones.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->instituciones_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_intituciones(Request $request) {
   
        $_POST = $this->toUpper($_POST);
        if ($request->input("idinstitucion") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("seguridad.instituciones", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("seguridad.instituciones", $_POST));
        }

   
        DB::table("seguridad.perfiles_idiomas")->where("idinstitucion", $result["id"])->delete();
        if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {
     
            $_POST["idinstitucion"] = $result["id"];
           
            $this->base_model->insertar($this->preparar_datos("seguridad.perfiles_idiomas", $_POST, "D"), "D");
        }
        echo json_encode($result);
    }

    public function eliminar_intituciones() {
       

        try {
            $sql_usuarios = "SELECT * FROM seguridad.usuarios WHERE idinstitucion=".$_REQUEST["id"];
            $usuarios = DB::select($sql_usuarios);

            if(count($usuarios) > 0) {
                throw new Exception(traducir("traductor.eliminar_perfil_usuario"));
            }

            $sql_permisos = "SELECT * FROM seguridad.permisos WHERE idinstitucion=".$_REQUEST["id"];
            $permisos = DB::select($sql_permisos);

            if(count($permisos) > 0) {
                throw new Exception(traducir("traductor.eliminar_perfil_permisos"));
            }

            $result = $this->base_model->eliminar(["seguridad.instituciones","idinstitucion"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM seguridad.instituciones WHERE idinstitucion=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_intituciones() {
        $sql = "SELECT p.idinstitucion AS id, 
        CASE WHEN pi.pi_descripcion IS NULL THEN 
        (SELECT pi_descripcion FROM seguridad.perfiles_idiomas WHERE idinstitucion=p.idinstitucion AND idioma_id=".session("idioma_id_defecto").")
        ELSE pi.pi_descripcion END AS descripcion 
        FROM seguridad.instituciones AS p 
        LEFT JOIN seguridad.perfiles_idiomas AS pi ON(pi.idinstitucion=p.idinstitucion AND pi.idioma_id=".session("idioma_id").")
        WHERE p.estado='A'";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }


    
    public function obtener_traducciones(Request $request) {
        $sql = "SELECT pi.idioma_id, pi.pi_descripcion AS descripcion, i.idioma_descripcion FROM seguridad.perfiles_idiomas AS pi
        INNER JOIN public.idiomas AS i ON(i.idioma_id=pi.idioma_id)
        WHERE pi.idinstitucion=".$request->input("idinstitucion")."
        ORDER BY pi.idioma_id ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }
    
}
