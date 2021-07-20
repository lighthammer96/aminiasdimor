<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DistritosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DistritosController extends Controller
{
    //
    private $base_model;
    private $distritos_model;
    
    public function __construct() {
        parent:: __construct();
        $this->distritos_model = new DistritosModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "distritos.index";
        $data["title"] = traducir("traductor.titulo_distritos");
        $data["subtitle"] = "";
        $data["tabla"] = $this->distritos_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-distrito">'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-distrito">'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-distrito">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js", "departamentos.js", "provincias.js", "distritos.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->distritos_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_distritos(Request $request) {
   
        $_POST = $this->toUpper($_POST);
        if ($request->input("iddistrito") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.distrito", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.distrito", $_POST));
        }

   
        
        echo json_encode($result);
    }

    public function eliminar_distritos() {
       

        try {
            $sql_miembros = "SELECT * FROM iglesias.miembro WHERE iddistritodomicilio=".$_REQUEST["id"];
            $miembros = DB::select($sql_miembros);

            if(count($miembros) > 0) {
                throw new Exception(traducir("traductor.eliminar_distrito_asociado"));
            }

            $sql_iglesias = "SELECT * FROM iglesias.iglesia WHERE iddistrito=".$_REQUEST["id"];
            $iglesias = DB::select($sql_iglesias);

            if(count($iglesias) > 0) {
                throw new Exception(traducir("traductor.eliminar_distrito_iglesia"));
            }

         

            $result = $this->base_model->eliminar(["public.distrito","iddistrito"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM public.distrito WHERE iddistrito=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_distritos(Request $request) {
        $sql = "";
		if(isset($_REQUEST["idprovincia"]) && !empty($_REQUEST["idprovincia"])) {
            $sql = "SELECT iddistrito as id, descripcion FROM public.distrito WHERE idprovincia=".$request->input("idprovincia");
			$result = DB::select($sql);
		} else {
	
            $sql = "SELECT iddistrito as id, descripcion FROM public.distrito";
            $result = DB::select($sql);
		}

        echo json_encode($result);
	}


    
}
