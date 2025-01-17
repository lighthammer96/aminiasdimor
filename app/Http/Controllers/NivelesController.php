<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\NivelesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class NivelesController extends Controller
{
    //
    private $base_model;
    private $niveles_model;

    public function __construct() {
        parent:: __construct();
        $this->niveles_model = new NivelesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "niveles.index";
        $data["title"] = traducir("traductor.titulo_niveles");
        $data["subtitle"] = "";
        $data["tabla"] = $this->niveles_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nuevo-nivel"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-nivel"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-nivel"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["tipos_cargo.js", "niveles.js"]);
        return parent::init($view, $data);



    }

    public function buscar_datos() {
        $json_data = $this->niveles_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_niveles(Request $request) {

        $_POST = $this->toUpper($_POST);
        if ($request->input("idnivel") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.nivel", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.nivel", $_POST));
        }


        // DB::table("public.nivel_idiomas")->where("idnivel", $result["id"])->delete();
        // if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {

        //     $_POST["idnivel"] = $result["id"];

        //     $this->base_model->insertar($this->preparar_datos("public.nivel_idiomas", $_POST, "D"), "D");
        // }
        echo json_encode($result);
    }

    public function eliminar_niveles() {


        try {
            $sql_cargos = "SELECT * FROM public.cargo WHERE idnivel=".$_REQUEST["id"];
            $cargos = DB::select($sql_cargos);

            if(count($cargos) > 0) {
                throw new Exception(traducir("traductor.eliminar_nivel_cargo"));
            }



            $result = $this->base_model->eliminar(["public.nivel","idnivel"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_niveles(Request $request) {

        $sql = "SELECT * FROM public.nivel WHERE idnivel=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_niveles(Request $request) {

       $result = $this->niveles_model->obtener_niveles($request);

        // $result = DB::select($sql);
        echo json_encode($result);
    }



    public function obtener_traducciones(Request $request) {
        $sql = "SELECT pi.idioma_id, pi.pi_descripcion AS descripcion, i.idioma_descripcion FROM public.nivel_idiomas AS pi
        INNER JOIN public.idiomas AS i ON(i.idioma_id=pi.idioma_id)
        WHERE pi.idnivel=".$request->input("idnivel")."
        ORDER BY pi.idioma_id ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }

}
