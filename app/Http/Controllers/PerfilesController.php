<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\PerfilesModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PerfilesController extends Controller
{
    //
    private $base_model;
    private $perfiles_model;
    
    public function __construct() {
        parent:: __construct();
        $this->perfiles_model = new PerfilesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {

        $view = "perfiles.index";
        $data["title"] = "Administración de Perfiles";
        $data["subtitle"] = "";
        $data["tabla"] = $this->perfiles_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-perfil">Nuevo [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">Modificar [F2]</button>';
        $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">Eliminar [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["perfiles.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->perfiles_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_perfiles(Request $request) {
   
        $_POST = $this->toUpper($_POST);
        if ($request->input("perfil_id") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("seguridad.perfiles", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("seguridad.perfiles", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_perfiles() {
        $result = $this->base_model->eliminar(["seguridad.perfiles","perfil_id"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM seguridad.perfiles WHERE perfil_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_perfiles() {
        $sql = "SELECT perfil_id AS id, perfil_descripcion AS descripcion FROM seguridad.perfiles WHERE estado='A'";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    
}
