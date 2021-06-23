<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\UnionesModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class UnionesController extends Controller
{
    //

    private $base_model;
    private $uniones_model;
    
    public function __construct() {
        parent:: __construct();
        $this->uniones_model = new UnionesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        App::setLocale(trim(session("idioma_codigo")));
        $view = "uniones.index";
        $data["title"] = trans('traductor.titulo_uniones');
        $data["subtitle"] = "";
        $data["tabla"] = $this->uniones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nueva-union">'.trans("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-union">'.trans("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-union">'.trans("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js", "uniones.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->uniones_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_uniones(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["descripcion"]);
        if ($request->input("idunion") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.union", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.union", $_POST));
        }

        DB::table("iglesias.union_paises")->where("idunion", $result["id"])->delete();
        if(isset($_REQUEST["pais_id"])) {
            $_POST["idunion"] = $result["id"];
            
            $this->base_model->insertar($this->preparar_datos("iglesias.union_paises", $_POST, "D"), "D");
        }

        echo json_encode($result);
    }

    public function eliminar_uniones() {
        $result = $this->base_model->eliminar(["iglesias.union","idunion"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM iglesias.union WHERE idunion=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_uniones(Request $request) {

        $sql = "";
		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {
	
			$sql = "SELECT idunion AS id, descripcion FROM iglesias.union WHERE estado='1' AND idunion=".$request->input("idunion");
		} else {
            $sql = "SELECT idunion AS id, descripcion FROM iglesias.union WHERE estado='1'";
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_paises(Request $request) {
        $sql = "SELECT * FROM iglesias.union_paises WHERE idunion=".$request->input("idunion");
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_uniones_paises(Request $request) {

        $sql = "";
		if(isset($_REQUEST["pais_id"]) && !empty($_REQUEST["pais_id"])) {
	
			$sql = "SELECT u.idunion AS id, u.descripcion FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' AND up.pais_id=".$request->input("pais_id")." ".session("where_union");
		} else {
            $sql = "SELECT u.idunion AS id, u.descripcion FROM iglesias.union AS u
            WHERE estado='1' ".session("where_union");
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }
}
