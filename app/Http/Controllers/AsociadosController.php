<?php

namespace App\Http\Controllers;

use App\Models\AsociadosModel;
use App\Models\BaseModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class AsociadosController extends Controller
{
    //

    private $base_model;
    private $asociados_model;
    
    public function __construct() {
        parent:: __construct();
        $this->asociados_model = new AsociadosModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        App::setLocale(trim(session("idioma_codigo")));
        $view = "asociados.index";
        $data["title"] = trans('traductor.titulo_asociados');
        $data["subtitle"] = "";
        $data["tabla"] = $this->asociados_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-asociado">'.trans("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-asociado">'.trans("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button tecla_rapida="F4" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ver-asociado">'.trans("traductor.ver").' [F4]</button>';
        // $botones[3] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-asociado">'.trans("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["asociados.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->asociados_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_asociados(Request $request) {
        // print_r($_REQUEST); exit;
        $array_pais = explode("|", $_POST["pais_id"]);
        $_POST["pais_id"] = $array_pais[0];
        if($array_pais[1] == "N" && empty($request->input("idunion"))) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_POST["pais_id"]}";
            $res = DB::select($sql);
            $_POST["idunion"] = $res[0]->idunion;
        }

        $_POST["fecharegistro"]            = $this->FormatoFecha($_REQUEST["fecharegistro"], "server");
        $_POST["fechanacimiento"] = $this->FormatoFecha($_REQUEST["fechanacimiento"], "server");

        $_POST = $this->toUpper($_POST, ["tipolugarnac", "direccion", "email", "emailalternativo"]);
        if ($request->input("idmiembro") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.miembro", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
        }
        // print_r($result); exit;
        $_POST["idmiembro"] = $result["id"];
        if (isset($_FILES["foto"]) && $_FILES["foto"]["error"] == "0") {

            $response = $this->SubirArchivo($_FILES["foto"], base_path("public/fotos_asociados/"), "miembro_" . $_POST["idmiembro"]);
            if ($response["response"] == "ERROR") {
                throw new Exception('Error al subir foto del Usuario!');
            }
            $_POST["foto"] = $response["NombreFile"];
           
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
        }

   
        echo json_encode($result);
    }

    public function eliminar_asociados() {
        $result = $this->base_model->eliminar(["iglesias.miembro","idmiembro"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT m.*, (m.pais_id || '|' || p.posee_union) AS pais_id, p.posee_union FROM iglesias.miembro AS m 
        LEFT JOIN public.paises AS p ON(p.pais_id=m.pais_id)
        WHERE m.idmiembro=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_asociados() {
        $sql = "SELECT idmiembro AS id, asociado_descripcion AS descripcion FROM iglesias.miembro WHERE estado='A'";
        $result = DB::select($sql);
        echo json_encode($result);
    }


    
    public function obtener_traducciones(Request $request) {
        $sql = "SELECT pi.idioma_id, pi.pi_descripcion AS descripcion, i.idioma_descripcion FROM iglesias.miembro_idiomas AS pi
        INNER JOIN public.idiomas AS i ON(i.idioma_id=pi.idioma_id)
        WHERE pi.idmiembro=".$request->input("idmiembro")."
        ORDER BY pi.idioma_id ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }

    public function obtener_estado_civil() {
        $sql = "SELECT idestadocivil as id, descripcion FROM public.estadocivil";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_nivel_educativo() {
        $sql = "SELECT idgradoinstruccion as id, descripcion FROM public.gradoinstruccion";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_profesiones() {
        $sql = "SELECT idocupacion as id, descripcion FROM public.ocupacion";
        $result = DB::select($sql);
        echo json_encode($result);
    }

   
}
