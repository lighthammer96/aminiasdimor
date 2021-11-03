<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\PaisesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PaisesController extends Controller
{
    //
    private $base_model;
    private $paises_model;
    
    public function __construct() {
        parent:: __construct();
        $this->paises_model = new PaisesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "paises.index";
        $data["title"] = traducir('traductor.titulo_paises');
        $data["subtitle"] = "";
        $data["tabla"] = $this->paises_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-pais">'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-pais">'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-pais">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->paises_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_paises(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["pais_descripcion", "direccion"]);
        if ($request->input("pais_id") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.paises", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.paises", $_POST));
        }


        DB::table("iglesias.paises_jerarquia")->where("pais_id", $result["id"])->delete();
        if(isset($_REQUEST["pj_item"]) && isset($_REQUEST["pj_descripcion"])) {
     
            $_POST["pais_id"] = $result["id"];
           
            $this->base_model->insertar($this->preparar_datos("iglesias.paises_jerarquia", $_POST, "D"), "D");
        }

        echo json_encode($result);
    }

    public function eliminar_paises() {
        
        try {
            $sql_uniones = "SELECT * FROM iglesias.union_paises WHERE pais_id=".$_REQUEST["id"];
            $uniones = DB::select($sql_uniones);

            if(count($uniones) > 0) {
                throw new Exception(traducir("traductor.eliminar_pais_union"));
            }

            $result = $this->base_model->eliminar(["iglesias.paises","pais_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_paises(Request $request) {

        $sql = "SELECT * FROM iglesias.paises WHERE pais_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_paises(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id  AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision").
            " ORDER BY pais_descripcion ASC";;
		} else {
            $sql = "SELECT pais_id AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A'
            ORDER BY pais_descripcion ASC";
		}

        $result = DB::select($sql);

        echo json_encode($result);
    }


    public function obtener_paises_propuestas(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision").
            " ORDER BY pais_descripcion ASC";;
		} else {
            $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A'
            ORDER BY pais_descripcion ASC";
		}

        $result = DB::select($sql);

        echo json_encode($result);
    }

    public function obtener_paises_asociados(Request $request) {
       
        $sql = "";
        $all = false;
        $result = array();
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision")." ".session("where_pais").
            " ORDER BY pais_descripcion ASC";
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion
            FROM iglesias.paises 
            WHERE estado='A' ".session("where_pais").session("where_division_padre").
            " ORDER BY pais_descripcion ASC";
            $all = true;
		}
        // die($sql);
        if($sql != "") {
            $result = DB::select($sql);
        }
        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2 && $all) {
            // print_r($result);
            $result[0]->defecto = "S";
        }
        echo json_encode($result);
    }

    public function obtener_paises_asociados_all(Request $request) {
        $array = array("id" => 0, "descripcion" => "Todos");
        $array = (object) $array;
        $result = array();
        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision")." ".session("where_pais").
            " ORDER BY pais_descripcion ASC";;
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            // $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' ".session("where_pais").
            // " ORDER BY pais_descripcion ASC";;
		}
        // die($sql);
        if($sql != "") {
            $result = DB::select($sql);
        }
        array_push($result, $array);

        echo json_encode($result);
    }

    public function obtener_todos_paises(Request $request) {

      
        $sql = "SELECT idpais AS id, descripcion FROM public.pais
        ORDER BY descripcion ASC";
		

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_paises_asociados_todos(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision").
            " ORDER BY pais_descripcion ASC";
		} else {
            $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A'
            ORDER BY pais_descripcion ASC";
		}
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }


    public function obtener_jerarquia(Request $request) {
        if(!empty($_REQUEST["pais_id"])) {
            $sql = "SELECT pj.pj_item AS item, pj.pj_descripcion AS descripcion, pj.pais_id, p.posee_union
            FROM iglesias.paises_jerarquia AS pj
            INNER JOIN iglesias.paises AS p ON(p.pais_id=pj.pais_id)

            WHERE pj.pais_id=".$request->input("pais_id")."
            ORDER BY pj_item ASC";  
        } else {
            $sql = "SELECT pj.pj_item AS item, pj.pj_descripcion AS descripcion, pj.pais_id, p.posee_union
            FROM iglesias.paises_jerarquia AS pj
            INNER JOIN iglesias.paises AS p ON(p.pais_id=pj.pais_id)

            WHERE pj.pais_id=".session("pais_id")."
            ORDER BY pj_item ASC";  
        }
        
        $result = DB::select($sql);
        echo json_encode($result);
       //print_r($_REQUEST);
    }


    
}
