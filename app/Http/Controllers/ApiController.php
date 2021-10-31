<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DistritosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiController extends Controller
{
    //
    private $base_model;
    private $distritos_model;
    
    public function __construct() {
        parent:: __construct();
        $this->distritos_model = new DistritosModel();
        $this->base_model = new BaseModel();
    }

    public function login(Request $request) {

        $sql = "SELECT * FROM iglesias.miembro WHERE nrodoc='{$request->input("user")}' AND nrodoc='{$request->input("pass")}'";
        // die($sql);
        $response = DB::select($sql);
        echo json_encode($response);
        // print("hola");
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


    public function get_distritos(Request $request) {

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
            // $result = array();
		}

        echo json_encode($result);
	}


    
}
