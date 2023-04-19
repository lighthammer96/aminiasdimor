<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\IdiomasModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

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
        $data["title"] = traducir("traductor.titulo_idiomas");
        $data["subtitle"] = "";
        $data["tabla"] = $this->idiomas_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nuevo-idioma"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir('traductor.nuevo').' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-idioma"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir('traductor.modificar').' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-idioma"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir('traductor.eliminar').' [F7]</button>';
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
            if($request->input("por_defecto") == "S") {

                session(['idioma_id_defecto' => $request->input("idioma_id")]);
                session(['idioma_defecto' => trim($request->input("idioma_codigo"))]);
               ;


            }

            $result = $this->base_model->modificar($this->preparar_datos("public.idiomas", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_idiomas() {
        try {


            $sql_divisiones = "SELECT * FROM iglesias.division_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $divisiones = DB::select($sql_divisiones);

            if(count($divisiones) > 0) {
                throw new Exception(traducir("traductor.eliminar_idioma_division"));
            }

            $sql_paises = "SELECT * FROM iglesias.paises_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $paises = DB::select($sql_paises);

            if(count($paises) > 0) {
                throw new Exception(traducir("traductor.eliminar_idioma_pais"));
            }

            $sql_modulos = "SELECT * FROM seguridad.modulos_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $modulos = DB::select($sql_modulos);

            if(count($modulos) > 0) {
                throw new Exception(traducir("traductor.eliminar_idioma_modulo"));
            }

            $sql_perfiles = "SELECT * FROM seguridad.perfiles_idiomas WHERE idioma_id=".$_REQUEST["id"];
            $perfiles = DB::select($sql_perfiles);

            if(count($perfiles) > 0) {
                throw new Exception(traducir("traductor.eliminar_idioma_perfil"));
            }


            $result = $this->base_model->eliminar(["public.idiomas","idioma_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
		}


    }


    public function get_idiomas(Request $request) {

        $sql = "SELECT * FROM public.idiomas WHERE idioma_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_idiomas() {
        $result = $this->idiomas_model->obtener_idiomas();
        echo json_encode($result);
    }
}
