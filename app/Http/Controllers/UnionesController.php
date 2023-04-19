<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\UnionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

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
        $view = "uniones.index";
        $data["title"] = traducir('traductor.titulo_uniones');
        $data["subtitle"] = "";
        $data["tabla"] = $this->uniones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-union"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-union"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-union"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["uniones.js"]);
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


        try {
            $sql_misiones = "SELECT * FROM iglesias.mision WHERE idunion=".$_REQUEST["id"];
            $misiones = DB::select($sql_misiones);

            if(count($misiones) > 0) {
                throw new Exception(traducir("traductor.eliminar_union_mision"));
            }
            $this->base_model->eliminar(["iglesias.union_paises","idunion"]);
            $result = $this->base_model->eliminar(["iglesias.union","idunion"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_uniones(Request $request) {

        $sql = "SELECT * FROM iglesias.union WHERE idunion=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_uniones(Request $request) {

        $result = $this->uniones_model->obtener_uniones($request);
        echo json_encode($result);
    }

    public function obtener_paises(Request $request) {
        $sql = "SELECT * FROM iglesias.union_paises WHERE idunion=".$request->input("idunion");
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_uniones_paises(Request $request) {

        $result = $this->uniones_model->obtener_uniones_paises($request);
        echo json_encode($result);
    }


    public function obtener_uniones_paises_propuestas(Request $request) {

        $result = $this->uniones_model->obtener_uniones_paises_propuestas($request);

        echo json_encode($result);
    }

    public function obtener_uniones_paises_all(Request $request) {
        $result = $this->uniones_model->obtener_uniones_paises_all($request);
        echo json_encode($result);
    }

    public function obtener_uniones_paises_todos(Request $request) {

        $result = $this->uniones_model->obtener_uniones_paises_todos($request);
        echo json_encode($result);
    }


}
