<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DepartamentosModel;
use App\Models\PaisesModel;
use App\Models\ProvinciasModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class ProvinciasController extends Controller
{
    //
    private $base_model;
    private $provincias_model;
    private $departamentos_model;
    private $paises_model;

    public function __construct() {
        parent:: __construct();
        $this->provincias_model = new ProvinciasModel();
        $this->base_model = new BaseModel();
        $this->departamentos_model = new DepartamentosModel();
        $this->paises_model = new PaisesModel();
    }

    public function index() {
        $view = "provincias.index";
        $data["title"] = traducir("traductor.titulo_provincias");
        $data["subtitle"] = "";
        $data["tabla"] = $this->provincias_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-provincia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-provincia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-provincia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["provincias.js"]);
        return parent::init($view, $data);


    }

    public function buscar_datos() {
        $json_data = $this->provincias_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_provincias(Request $request) {

        $_POST = $this->toUpper($_POST);
        if ($request->input("idprovincia") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.provincia", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.provincia", $_POST));
        }



        echo json_encode($result);
    }

    public function eliminar_provincias() {


        try {
            $sql_miembros = "SELECT * FROM iglesias.miembro WHERE idprovinciadomicilio=".$_REQUEST["id"];
            $miembros = DB::select($sql_miembros);

            if(count($miembros) > 0) {
                throw new Exception(traducir("traductor.eliminar_provincia_asociado"));
            }

            $sql_iglesias = "SELECT * FROM iglesias.iglesia WHERE idprovincia=".$_REQUEST["id"];
            $iglesias = DB::select($sql_iglesias);

            if(count($iglesias) > 0) {
                throw new Exception(traducir("traductor.eliminar_provincia_iglesia"));
            }

            $sql_distritos = "SELECT * FROM public.distrito WHERE idprovincia=".$_REQUEST["id"];
            $distritos = DB::select($sql_distritos);

            if(count($distritos) > 0) {
                throw new Exception(traducir("traductor.eliminar_provincia_distrito"));
            }


            $result = $this->base_model->eliminar(["public.provincia","idprovincia"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_provincias(Request $request) {

        $sql = "SELECT p.*, d.pais_id
        FROM public.provincia AS p
        LEFT JOIN public.departamento AS d ON(p.iddepartamento=d.iddepartamento)
        WHERE p.idprovincia=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_provincias(Request $request) {
        $result = $this->provincias_model->obtener_provincias($request);
        echo json_encode($result);
    }


    public function select_init(Request $request) {
        $data["pais_id"] = $this->paises_model->obtener_paises($request);
        $data["iddepartamento"] = $this->departamentos_model->obtener_departamentos();
        echo json_encode($data);
    }



}
