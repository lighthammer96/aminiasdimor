<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\IdiomasModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

class IdiomasController extends Controller
{
    //

    private $base_model;
    private $idiomas_model;
    
    public function __construct() {
        parent:: __construct();
        $this->idiomas_model = new IdiomasModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "idiomas.index";
        $data["title"] = "Administración de Idiomas";
        $data["subtitle"] = "";
        $data["tabla"] = $this->idiomas_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-idioma">'.traducir('traductor.nuevo').' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-idioma">'.traducir('traductor.modificar').' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-idioma">'.traducir('traductor.eliminar').' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["idiomas.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->idiomas_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_idiomas(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["idioma_codigo", "idioma_descripcion"]);
        if ($request->input("idioma_id") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.idiomas", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.idiomas", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_idiomas() {
        try {
           

            $sql_divisiones = "SELECT * FROM iglesias.division_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $divisiones = DB::select($sql_divisiones);

            if(count($divisiones) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, YA EXISTE UN REGISTRO EN DETALLE DE DIVISIONES");
            }

            $sql_paises = "SELECT * FROM iglesias.paises_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $paises = DB::select($sql_paises);

            if(count($paises) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, YA EXISTE UN REGISTRO EN DETALLE DE PAISES");
            }

            $sql_modulos = "SELECT * FROM seguridad.modulos_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $modulos = DB::select($sql_modulos);

            if(count($modulos) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, YA EXISTE UN REGISTRO EN DETALLE DE MODULOS");
            }

            $sql_perfiles = "SELECT * FROM seguridad.perfiles_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $perfiles = DB::select($sql_perfiles);

            if(count($perfiles) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, YA EXISTE UN REGISTRO EN DETALLE DE PERFILES");
            }


            $result = $this->base_model->eliminar(["public.idiomas","idioma_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
		}
		

    }


    public function get(Request $request) {

        $sql = "SELECT * FROM public.idiomas WHERE idioma_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_idiomas() {
        $sql = "SELECT idioma_id AS id, idioma_descripcion AS descripcion FROM public.idiomas WHERE estado='A'";
        $result = DB::select($sql);
        echo json_encode($result);
    }
}
