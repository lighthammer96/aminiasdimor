<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\TrasladosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TrasladosController extends Controller
{
    //
    private $base_model;

    
    public function __construct() {
        parent:: __construct();
      
        $this->base_model = new BaseModel();
        $this->traslados_model = new TrasladosModel();
    }

    public function index() {
        $view = "traslados.index";
        $data["title"] = traducir("traductor.titulo_traslados_iglesia");
        $data["subtitle"] = "";
        $data["tabla_traslados"] = $this->traslados_model->tabla()->HTML();
        $data["tabla_asociados_traslados"] = $this->traslados_model->tabla_asociados_traslados()->HTML();

        // $botones = array();
        // $botones[0] = '<button tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-perfil">'.traducir("traductor.nuevo").' [F1]</button>';
        // $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">'.traducir("traductor.eliminar").' [F7]</button>';
        // $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["traslados.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->traslados_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }

    public function buscar_datos_asociados_traslados() {
        $json_data = $this->traslados_model->tabla_asociados_traslados()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_traslados(Request $request) {
   
        $_POST = $this->toUpper($_POST);
        if ($request->input("perfil_id") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("seguridad.traslados", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("seguridad.traslados", $_POST));
        }

   
        // DB::table("seguridad.traslados_idiomas")->where("perfil_id", $result["id"])->delete();
        // if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {
     
        //     $_POST["perfil_id"] = $result["id"];
           
        //     $this->base_model->insertar($this->preparar_datos("seguridad.traslados_idiomas", $_POST, "D"), "D");
        // }
        $result = array();
        echo json_encode($result);
    }

    public function guardar_traslados_temp(Request $request) {
        // print_r($_REQUEST); exit;
        try {
        
            $array_pais = explode("|", $_POST["pais_id"]);
            $_POST["pais_id"] = $array_pais[0];
            if($array_pais[1] == "N" && empty($request->input("idunion"))) {
                $sql = "SELECT * FROM iglesias.union AS u 
                INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                WHERE up.pais_id={$_POST["pais_id"]}";
                $res = DB::select($sql);
                $_POST["idunion"] = $res[0]->idunion;
         
            }

            $array_pais_destino = explode("|", $_POST["pais_iddestino"]);
            $_POST["pais_iddestino"] = $array_pais_destino[0];
            if($array_pais_destino[1] == "N" && empty($request->input("iduniondestino"))) {
                $sql = "SELECT * FROM iglesias.union AS u 
                INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                WHERE up.pais_id={$_POST["pais_iddestino"]}";
                $res = DB::select($sql);
                $_POST["iduniondestino"] = $res[0]->idunion;
         
            }

            $sql_destino = "";
            $sql_destino .= $_POST["iddivisiondestino"]." AS iddivisiondestino, ";
            $sql_destino .= $_POST["pais_iddestino"]." AS pais_iddestino, ";
            $sql_destino .= $_POST["iduniondestino"]." AS iduniondestino, ";
            $sql_destino .= $_POST["idmisiondestino"]." AS idmisiondestino, ";
            $sql_destino .= $_POST["iddistritomisionerodestino"]." AS iddistritomisionerodestino, ";
            $sql_destino .= $_POST["idiglesiadestino"]." AS idiglesiadestino ";
            
            DB::table("iglesias.temp_traslados")->where(array("usuario_id" => session("usuario_id"), "tipo_traslado" => $_REQUEST["tipo_traslado"]))->delete();

            $sql = "SELECT vat.*, ".session("usuario_id")." AS usuario_id, ".$_REQUEST["tipo_traslado"]." AS tipo_traslado, ".$sql_destino."  FROM iglesias.vista_asociados_traslados AS vat
            WHERE iddivision={$request->input('iddivision')} AND pais_id={$_POST["pais_id"]} AND idunion={$_POST["idunion"]} AND idmision={$request->input('idmision')} AND iddistritomisionero={$request->input('iddistritomisionero')} AND  idiglesia={$request->input('idiglesia')}";
            
            $asociados = DB::select($sql);
            if(count($asociados) > 0) {
                foreach($asociados as $value) {
                    $array = (array) $value;
                    $result = $this->base_model->insertar($this->preparar_datos("iglesias.temp_traslados", $array));
                }
        
            } else {
                throw new Exception("No hay asociados en la iglesia origen!");
            }
            
            
            echo json_encode($_REQUEST);
        } catch(Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
       
    
       
    }

    public function eliminar_traslados_temp() {
        try {
            $result = $this->base_model->eliminar(["iglesias.temp_traslados","idtemptraslados"]);
            $result = array();
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get(Request $request) {

        $sql = "SELECT * FROM seguridad.traslados WHERE perfil_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    
    public function trasladar(Request $request) {
        $sql = "SELECT * FROM iglesias.temp_traslados WHERE tipo_traslado=".$request->input("tipo_traslado")." AND usuario_id=".session("usuario_id");

        $traslados = DB::select($sql);

        foreach($traslados as $key => $value) {
            $value->idiglesiaanterior = $value->idiglesia;
            $value->idiglesiaactual = $value->idiglesiadestino;
            $value->fecha = date("Y-m-d");
            $array = (array) $value;
            
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.historial_traslados", $array));


            $update = array();
            $update["idmiembro"] = $value->idmiembro;
            $update["iddivision"] = $value->iddivisiondestino;
            $update["pais_id"] = $value->pais_iddestino;
            $update["idunion"] = $value->iduniondestino;
            $update["idmision"] = $value->idmisiondestino;
            $update["idiglesia"] = $value->idiglesiadestino;
            

            $result = $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $update));

            

        }

        DB::table("iglesias.temp_traslados")->where(array("usuario_id" => session("usuario_id"), "tipo_traslado" => $request->input("tipo_traslado")))->delete();

        echo json_encode($result);
    }

    public function agregar_traslado(Request $request) {
        DB::table("iglesias.temp_traslados")->where(array("usuario_id" => session("usuario_id"), "tipo_traslado" => $_REQUEST["tipo_traslado"], "idmiembro" => $request->input('idmiembro')))->delete();

        $sql = "SELECT vat.*, ".session("usuario_id")." AS usuario_id, ".$_REQUEST["tipo_traslado"]." AS tipo_traslado  FROM iglesias.vista_asociados_traslados AS vat
        WHERE idmiembro={$request->input('idmiembro')}";
        $miembro = DB::select($sql);

        foreach($miembro as $value) {
            $array = (array) $value;
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.temp_traslados", $array));
        }

        echo json_encode($result);
    }


    
}
