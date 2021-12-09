<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\ComentariosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class ComentariosController extends Controller
{
    //
    private $base_model;
    private $comentarios_model;
    
    public function __construct() {
        parent:: __construct();
        $this->comentarios_model = new ComentariosModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "comentarios.index";
        $data["title"] = traducir("asambleas.titulo_comentarios");
        $data["subtitle"] = "";
        $data["tabla"] = $this->comentarios_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nuevo-comentario"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-comentario"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-comentario"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["comentarios.js"]);
        return parent::init($view, $data);
        
    }

    public function buscar_datos() {
        $json_data = $this->comentarios_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_comentarios(Request $request) {
       
        $_POST = $this->toUpper($_POST);
        if ($request->input("comentario_id") == '') {
            $_POST["idmiembro"] = session("idmiembro");
            $_POST["comentario_fecha"] = date("Y-m-d");
            $_POST["comentario_hora"] = date("H:i:s");
            $result = $this->base_model->insertar($this->preparar_datos("asambleas.comentarios", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("asambleas.comentarios", $_POST));
        }

   
    
        // $sql_asamblea = "SELECT * FROM asambleas.asambleas WHERE asamblea_id={$asamblea[1]}";
        // $asamblea = DB::select($sql_asamblea);
        // $result["datos"][0]["asamblea"] = $asamblea[0]->asamblea_descripcion;
        echo json_encode($result);
    }

    public function eliminar_comentarios() {
       

        try {
       

            // $sql_detalle = "SELECT * FROM asambleas.detalle_comentarios WHERE comentario_id=".$_REQUEST["id"];
            // $detalle = DB::select($sql_detalle);

            // if(count($detalle) > 0) {
            //     throw new Exception(traducir("traductor.eliminar_comentarios_detalle"));
            // }

            $result = $this->base_model->eliminar(["asambleas.comentarios","comentario_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_comentarios(Request $request) {

        $sql = "SELECT * FROM asambleas.comentarios  AS c
        
        WHERE c.comentario_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_comentarios() {
        $sql = "SELECT p.comentario_id AS id, 
        CASE WHEN pi.pi_descripcion IS NULL THEN 
        (SELECT pi_descripcion FROM asambleas.comentario_idiomas WHERE comentario_id=p.comentario_id AND idioma_id=".session("idioma_id_defecto").")
        ELSE pi.pi_descripcion END AS descripcion 
        FROM asambleas.comentarios AS p 
        LEFT JOIN asambleas.comentario_idiomas AS pi ON(pi.comentario_id=p.comentario_id AND pi.idioma_id=".session("idioma_id").")
        WHERE p.estado='A'";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }


    

    
}
