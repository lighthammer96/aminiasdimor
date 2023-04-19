<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DepartamentosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class DepartamentosController extends Controller
{
    //
    private $base_model;
    private $departamentos_model;

    public function __construct() {
        parent:: __construct();
        $this->departamentos_model = new DepartamentosModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "departamentos.index";
        $data["title"] = traducir("traductor.titulo_departamentos");
        $data["subtitle"] = "";
        $data["tabla"] = $this->departamentos_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nuevo-departamento"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-departamento"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-departamento"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["departamentos.js"]);
        return parent::init($view, $data);



    }

    public function buscar_datos() {
        $json_data = $this->departamentos_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_departamentos(Request $request) {

        $_POST = $this->toUpper($_POST);
        if ($request->input("iddepartamento") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.departamento", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.departamento", $_POST));
        }
        echo json_encode($result);
    }

    public function eliminar_departamentos() {


        try {
            $sql_miembros = "SELECT * FROM iglesias.miembro WHERE iddepartamentodomicilio=".$_REQUEST["id"];
            $miembros = DB::select($sql_miembros);

            if(count($miembros) > 0) {
                throw new Exception(traducir("traductor.eliminar_departamento_asociado"));
            }

            $sql_iglesias = "SELECT * FROM iglesias.iglesia WHERE iddepartamento=".$_REQUEST["id"];
            $iglesias = DB::select($sql_iglesias);

            if(count($iglesias) > 0) {
                throw new Exception(traducir("traductor.eliminar_departamento_iglesia"));
            }


            $sql_provincias = "SELECT * FROM public.provincia WHERE iddepartamento=".$_REQUEST["id"];
            $provincias = DB::select($sql_provincias);

            if(count($provincias) > 0) {
                throw new Exception(traducir("traductor.eliminar_departamento_provincia"));
            }

            $result = $this->base_model->eliminar(["public.departamento","iddepartamento"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_departamentos(Request $request) {

        $sql = "SELECT * FROM public.departamento WHERE iddepartamento=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_departamentos() {
        $result = $this->departamentos_model->obtener_departamentos();
        echo json_encode($result);
    }

}
