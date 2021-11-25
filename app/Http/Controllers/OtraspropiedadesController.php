<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\OtraspropiedadesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class OtraspropiedadesController extends Controller
{
    //
    private $base_model;
    private $otras_propiedades_model;
    
    public function __construct() {
        parent:: __construct();
        $this->otras_propiedades_model = new OtraspropiedadesModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "otras_propiedades.index";
        $data["title"] = traducir("traductor.titulo_otras_propiedades");
        $data["subtitle"] = "";
        $data["tabla"] = $this->otras_propiedades_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-otras_propiedades"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-otras_propiedades"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-otras_propiedades"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["otras_propiedades.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->otras_propiedades_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_otras_propiedades(Request $request) {
   
        $_POST = $this->toUpper($_POST, ["tipo"]);
        $array_pais = explode("|", $_POST["pais_id"]);
        $_POST["pais_id"] = $array_pais[0];
        if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($request->input("idunion"))) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_POST["pais_id"]}";
            $res = DB::select($sql);
            $_POST["idunion"] = $res[0]->idunion;
        }

        if ($request->input("idotrapropiedad") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.otras_propiedades", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.otras_propiedades", $_POST));
        }

   
        echo json_encode($result);
    }

    public function eliminar_otras_propiedades() {
       

        try {
            // $sql_usuarios = "SELECT * FROM seguridad.usuarios WHERE idotrapropiedad=".$_REQUEST["id"];
            // $usuarios = DB::select($sql_usuarios);

            // if(count($usuarios) > 0) {
            //     throw new Exception(traducir("traductor.eliminar_perfil_usuario"));
            // }

            // $sql_permisos = "SELECT * FROM seguridad.permisos WHERE idotrapropiedad=".$_REQUEST["id"];
            // $permisos = DB::select($sql_permisos);

            // if(count($permisos) > 0) {
            //     throw new Exception(traducir("traductor.eliminar_perfil_permisos"));
            // }

            $result = $this->base_model->eliminar(["iglesias.otras_propiedades","idotrapropiedad"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_otras_propiedades(Request $request) {

        $sql = "SELECT ot.*, (ot.pais_id || '|' || p.posee_union) AS pais_id, p.posee_union
        FROM iglesias.otras_propiedades AS ot
        LEFT JOIN iglesias.paises AS p ON(p.pais_id=ot.pais_id)
        WHERE ot.idotrapropiedad=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }


}
