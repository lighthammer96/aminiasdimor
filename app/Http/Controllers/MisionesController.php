<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\MisionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

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
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-mision"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-mision"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-mision"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["misiones.js"]);
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

        $result = $this->misiones_model->obtener_misiones($request);

        echo json_encode($result);
    }

    public function obtener_misiones_propuestas(Request $request) {

        $result = $this->misiones_model->obtener_misiones_propuestas($request);
        echo json_encode($result);
    }


    public function obtener_misiones_all(Request $request) {
        $result = $this->misiones_model->obtener_misiones_all($request);
        echo json_encode($result);
    }


    public function obtener_misiones_todos(Request $request) {

        $result = $this->misiones_model->obtener_misiones_todos($request);
        echo json_encode($result);
    }




}
