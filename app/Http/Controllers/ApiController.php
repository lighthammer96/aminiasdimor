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
        $pais = explode("|", $_REQUEST["pais_id"]);
        $tipodoc = explode("|", $_REQUEST["idtipodoc"]);

        $sql = "SELECT m.*, i.idioma_codigo FROM iglesias.miembro AS m 
        INNER JOIN iglesias.paises AS p ON(m.pais_id=p.pais_id)
        INNER JOIN public.idiomas AS i ON(i.idioma_id=p.idioma_id)
        WHERE m.nrodoc='{$request->input("user")}' AND m.nrodoc='{$request->input("pass")}' AND m.pais_id={$pais[0]} AND m.idtipodoc={$tipodoc[0]}";
        // die($sql);
        $response = DB::select($sql);
        echo json_encode($response);
        // print("hola");
    }

    public function marcar_asistencia(Request $request) {
        $_REQUEST["da_fecha"] = date("Y-m-d");
        $_REQUEST["da_hora"] = date("H:i:s");
        $result = $this->base_model->insertar($this->preparar_datos("asambleas.detalle_asistencia", $_REQUEST));
        // print_r($result);
        $result["datos"][0]["status"] = $result["status"];
        $result["datos"][0]["type"] = $result["type"];
        $result["datos"][0]["msg"] = $result["msg"];
        echo json_encode($result["datos"]);
    }

    public function guardar_votos(Request $request) {
        $miembro_votado = explode("|", $request->input("idmiembro_votado"));
        if($request->input("fv_id") == 6) {
            $_REQUEST["idmiembro_votado"] = "";
            $_REQUEST["dp_id"] = $miembro_votado[0];
        } else {
            $_REQUEST["idmiembro_votado"] = $miembro_votado[0];
            $_REQUEST["dp_id"] = "";
        }

      
        $_REQUEST["voto_fecha"] = date("Y-m-d");
        $_REQUEST["voto_hora"] = date("H:i:s");
        $result = $this->base_model->insertar($this->preparar_datos("asambleas.votos", $_REQUEST));
        // print_r($result);
        $result["datos"][0]["status"] = $result["status"];
        $result["datos"][0]["type"] = $result["type"];
        $result["datos"][0]["msg"] = $result["msg"];
        echo json_encode($result["datos"]);
    }

    public function obtener_paises() {
        $sql = "SELECT * FROM iglesias.paises WHERE estado='A' ORDER BY pais_descripcion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_tipos_documento() {
        $sql = "SELECT * FROM public.tipodoc ORDER BY descripcion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
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
