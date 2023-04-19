<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DivisionesModel;
use App\Models\IdiomasModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class DivisionesController extends Controller
{
    //

    private $base_model;
    private $divisiones_model;
    private $idiomas_model;

    public function __construct() {
        parent:: __construct();
        $this->divisiones_model = new DivisionesModel();
        $this->base_model = new BaseModel();
        $this->idiomas_model = new IdiomasModel();
    }

    public function index() {
        $view = "divisiones.index";
        $data["title"] = traducir('traductor.titulo_divisiones');
        $data["subtitle"] = "";
        $data["tabla"] = $this->divisiones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-division"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-division"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-division"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["idiomas.js", "divisiones.js"]);
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

        DB::table("iglesias.division_idiomas")->where("iddivision", $result["id"])->delete();
        if(isset($_REQUEST["iddivision"]) && isset($_REQUEST["di_descripcion"])) {

            $_POST["iddivision"] = $result["id"];

            $this->base_model->insertar($this->preparar_datos("iglesias.division_idiomas", $_POST, "D"), "D");
        }

        echo json_encode($result);
    }

    public function eliminar_divisiones() {
        try {
            $sql_paises = "SELECT * FROM iglesias.paises WHERE iddivision=".$_REQUEST["id"];
            $paises = DB::select($sql_paises);

            if(count($paises) > 0) {
                throw new Exception(traducir("traductor.eliminar_division_pais"));
            }

            $result = $this->base_model->eliminar(["iglesias.division","iddivision"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }

    }


    public function get_divisiones(Request $request) {

        $sql = "SELECT * FROM iglesias.division WHERE iddivision=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_divisiones(Request $request) {

        $result = $this->divisiones_model->obtener_divisiones($request);


        echo json_encode($result);
    }


    public function obtener_traducciones(Request $request) {
        $sql = "SELECT di.iddivision, di.di_descripcion AS descripcion, i.idioma_descripcion, di.idioma_id FROM iglesias.division_idiomas AS di
        INNER JOIN public.idiomas AS i ON(i.idioma_id=di.idioma_id)
        WHERE di.iddivision=".$request->input("iddivision")."
        ORDER BY di.iddivision ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }


    public function obtener_divisiones_todos(Request $request) {

        $result = $this->divisiones_model->obtener_divisiones_todos($request);
        echo json_encode($result);
    }


    public function obtener_divisiones_all(Request $request) {
        $result = $this->divisiones_model->obtener_divisiones_all($request);
        echo json_encode($result);
    }

    public function select_init() {
        $data["idioma"] = $this->idiomas_model->obtener_idiomas();
        echo json_encode($data);
    }

}
