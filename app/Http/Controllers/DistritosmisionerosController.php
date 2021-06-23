<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DistritosmisionerosModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class DistritosmisionerosController extends Controller
{
    //
    private $base_model;
    private $distritos_misioneros_model;
    
    public function __construct() {
        parent:: __construct();
        $this->distritos_misioneros_model = new DistritosmisionerosModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        App::setLocale(trim(session("idioma_codigo")));
        $view = "distritos_misioneros.index";
        $data["title"] = trans('traductor.titulo_distritos_misioneros');
        $data["subtitle"] = "";
        $data["tabla"] = $this->distritos_misioneros_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-distrito-misionero">'.trans("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-distrito-misionero">'.trans("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-distrito-misionero">'.trans("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js", "uniones.js", "misiones.js", "distritos_misioneros.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->distritos_misioneros_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_distritos_misioneros(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["descripcion"]);
        if ($request->input("iddistritomisionero") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.distritomisionero", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.distritomisionero", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_distritos_misioneros() {
        $result = $this->base_model->eliminar(["iglesias.distritomisionero","iddistritomisionero"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM iglesias.distritomisionero WHERE iddistritomisionero=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_distritos_misioneros(Request $request) {

        $sql = "";
		if(isset($_REQUEST["idmision"]) && !empty($_REQUEST["idmision"])) {
	
			$sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' AND idmision=".$request->input("idmision")." ".session("where_distrito_misionero");
		} else {
            $sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' ".session("where_distrito_misionero");
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }
}
