<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DivisionesModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DivisionesController extends Controller
{
    //

    private $base_model;
    private $divisiones_model;
    
    public function __construct() {
        parent:: __construct();
        $this->divisiones_model = new DivisionesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        App::setLocale(trim(session("idioma_codigo")));
        $view = "divisiones.index";
        $data["title"] = trans('traductor.titulo_divisiones');
        $data["subtitle"] = "";
        $data["tabla"] = $this->divisiones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nueva-division">'.trans("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-division">'.trans("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-division">'.trans("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->divisiones_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_divisiones(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["descripcion"]);
        if ($request->input("iddivision") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.division", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.division", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_divisiones() {
        $result = $this->base_model->eliminar(["iglesias.division","iddivision"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM iglesias.division WHERE iddivision=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_divisiones(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {
	
			$sql = "SELECT iddivision AS id, descripcion FROM iglesias.division WHERE estado='1' AND iddivision=".$request->input("iddivision")." ".session("where_division");
		} else {
            $sql = "SELECT iddivision AS id, descripcion FROM iglesias.division WHERE estado='1' ".session("where_division");
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }
}
