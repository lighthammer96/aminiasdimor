<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\IglesiasModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class IglesiasController extends Controller
{
    //

    private $base_model;
    private $iglesias_model;
    
    public function __construct() {
        parent:: __construct();
        $this->iglesias_model = new IglesiasModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        App::setLocale(trim(session("idioma_codigo")));
        $view = "iglesias.index";
        $data["title"] = trans('traductor.titulo_iglesias');
        $data["subtitle"] = "";
        $data["tabla"] = $this->iglesias_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nueva-iglesia">'.trans("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-iglesia">'.trans("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-iglesia">'.trans("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js", "uniones.js", "misiones.js", "distritos_misioneros.js", "iglesias.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->iglesias_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_iglesias(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["descripcion"]);
        if ($request->input("idiglesia") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.iglesia", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.iglesia", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_iglesias() {
        $result = $this->base_model->eliminar(["iglesias.iglesia","idiglesia"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM iglesias.iglesia WHERE idiglesia=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_iglesias(Request $request) {

        $sql = "";
		if(isset($_REQUEST["iddistritomisionero"]) && !empty($_REQUEST["iddistritomisionero"])) {
	
			$sql = "SELECT idiglesia AS id, descripcion FROM iglesias.iglesia WHERE estado='1' AND iddistritomisionero=".$request->input("iddistritomisionero");
		} else {
            $sql = "SELECT idiglesia AS id, descripcion FROM iglesias.iglesia WHERE estado='1'";
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }
}
