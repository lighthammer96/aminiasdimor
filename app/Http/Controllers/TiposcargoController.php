<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\TiposcargoModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class TiposcargoController extends Controller
{
    //
    private $base_model;
    private $tipos_cargo_model;

    public function __construct() {
        parent:: __construct();
        $this->tipos_cargo_model = new TiposcargoModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "tipos_cargo_model.index";
        $data["title"] = traducir("traductor.titulo_tipos_cargo_model");
        $data["subtitle"] = "";
        $data["tabla"] = $this->tipos_cargo_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nuevo-tipo-cargo"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-tipo-cargo"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-tipo-cargo"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["tipos_cargo_model.js"]);
        return parent::init($view, $data);



    }

    public function buscar_datos() {
        $json_data = $this->tipos_cargo_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_tipos_cargo_model(Request $request) {

        $_POST = $this->toUpper($_POST);
        if ($request->input("idtipocargo") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.tipocargo", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.tipocargo", $_POST));
        }


        // DB::table("public.tipocargo_idiomas")->where("idtipocargo", $result["id"])->delete();
        // if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {

        //     $_POST["idtipocargo"] = $result["id"];

        //     $this->base_model->insertar($this->preparar_datos("public.tipocargo_idiomas", $_POST, "D"), "D");
        // }
        echo json_encode($result);
    }

    public function eliminar_tipos_cargo_model() {


        try {
            $sql_cargos = "SELECT * FROM public.cargo WHERE idtipocargo=".$_REQUEST["id"];
            $cargos = DB::select($sql_cargos);

            if(count($cargos) > 0) {
                throw new Exception(traducir("traductor.eliminar_tipo_cargo_cargo"));
            }

            // $sql_permisos = "SELECT * FROM public.permisos WHERE idtipocargo=".$_REQUEST["id"];
            // $permisos = DB::select($sql_permisos);

            // if(count($permisos) > 0) {
            //     throw new Exception("NO SE PUEDE ELIMINAR, ESTE PERFIL YA TIENE ASIGNADO PERMISOS");
            // }

            $result = $this->base_model->eliminar(["public.tipocargo","idtipocargo"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_tipos_cargo_model(Request $request) {

        $sql = "SELECT * FROM public.tipocargo WHERE idtipocargo=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_tipos_cargo() {
        $result = $this->tipos_cargo_model->obtener_tipos_cargo();
        echo json_encode($result);
    }

    public function obtener_traducciones(Request $request) {
        $sql = "SELECT pi.idioma_id, pi.pi_descripcion AS descripcion, i.idioma_descripcion FROM public.tipocargo_idiomas AS pi
        INNER JOIN public.idiomas AS i ON(i.idioma_id=pi.idioma_id)
        WHERE pi.idtipocargo=".$request->input("idtipocargo")."
        ORDER BY pi.idioma_id ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }

}
