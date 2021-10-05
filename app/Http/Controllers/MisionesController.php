<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\MisionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MisionesController extends Controller
{
    //
    private $base_model;
    private $misiones_model;
    
    public function __construct() {
        parent:: __construct();
        $this->misiones_model = new MisionesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "misiones.index";
        $data["title"] = traducir('traductor.titulo_misiones');
        $data["subtitle"] = "";
        $data["tabla"] = $this->misiones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nueva-mision">'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-mision">'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-mision">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js", "uniones.js", "misiones.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->misiones_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_misiones(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["descripcion", "email"]);
        if ($request->input("idmision") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.mision", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.mision", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_misiones() {
        try {
            $sql_distritos = "SELECT * FROM iglesias.distritomisionero WHERE idmision=".$_REQUEST["id"];
            $distritos = DB::select($sql_distritos);

            if(count($distritos) > 0) {
                throw new Exception(traducir("traductor.eliminar_mision_distrito_misionero"));
            }

            $result = $this->base_model->eliminar(["iglesias.mision","idmision"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
       
    }


    public function get_misiones(Request $request) {

        $sql = "SELECT * FROM iglesias.mision WHERE idmision=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_misiones(Request $request) {

        $sql = "";
        $all = false;
        $result = array();
        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {
	
			$sql = "SELECT idmision AS id, descripcion, email AS atributo1 FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"]. " ".session("where_mision").
            " ORDER BY descripcion ASC";		
        } elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            $sql = "SELECT idmision AS id, descripcion, email AS atributo1
            FROM iglesias.mision WHERE estado='1' ".session("where_mision").session("where_union_padre").
            " ORDER BY descripcion ASC";
            $all = true;
		}

        if($sql != "") {
            $result = DB::select($sql);
        }
        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2 && $all) {
            
            // print_r($result);
            $result[0]->defecto = "S";
        }
        echo json_encode($result);
    }


    public function obtener_misiones_all(Request $request) {
        $array = array("id" => 0, "descripcion" => "Todos");
        $array = (object) $array;
        $sql = "";
        $result = array();
        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {
	
			$sql = "SELECT idmision AS id, descripcion FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"]. " ".session("where_mision").
            " ORDER BY descripcion ASC";		
        } elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            // $sql = "SELECT idmision AS id, descripcion FROM iglesias.mision WHERE estado='1' ".session("where_mision").
            // " ORDER BY descripcion ASC";
		}

        if($sql != "") {
            $result = DB::select($sql);
        }
        array_push($result, $array);
        echo json_encode($result);
    }


    public function obtener_misiones_todos(Request $request) {

        $sql = "";
       
        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {
	
			$sql = "SELECT idmision AS id, descripcion FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"].
            " ORDER BY descripcion ASC";	
        } else {
            $sql = "SELECT idmision AS id, descripcion
            FROM iglesias.mision WHERE estado='1' ".
            " ORDER BY descripcion ASC";
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }

    


}