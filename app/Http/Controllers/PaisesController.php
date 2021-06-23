<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\PaisesModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
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
        App::setLocale(trim(session("idioma_codigo")));
        $view = "paises.index";
        $data["title"] = trans('traductor.titulo_paises');
        $data["subtitle"] = "";
        $data["tabla"] = $this->paises_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-pais">'.trans("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-pais">'.trans("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-pais">'.trans("traductor.eliminar").' [F7]</button>';
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
            $result = $this->base_model->insertar($this->preparar_datos("public.paises", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.paises", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_paises() {
        $result = $this->base_model->eliminar(["public.paises","pais_id"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM public.paises WHERE pais_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_paises(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id AS id, pais_descripcion AS descripcion FROM public.paises WHERE estado='A' AND iddivision=".$request->input("iddivision");
		} else {
            $sql = "SELECT pais_id AS id, pais_descripcion AS descripcion FROM public.paises WHERE estado='A'";
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_paises_asociados(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM public.paises WHERE estado='A' AND iddivision=".$request->input("iddivision")." ".session("where_pais");
		} else {
            $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM public.paises WHERE estado='A' ".session("where_pais");
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }

  
}
