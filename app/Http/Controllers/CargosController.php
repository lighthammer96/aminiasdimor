<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\CargosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CargosController extends Controller
{
    //
    private $base_model;
    private $cargos_model;
    
    public function __construct() {
        parent:: __construct();
        $this->cargos_model = new CargosModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "cargos.index";
        $data["title"] = traducir("traductor.titulo_cargos");
        $data["subtitle"] = "";
        $data["tabla"] = $this->cargos_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-cargo">'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-cargo">'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-cargo">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["cargos.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->cargos_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_cargos(Request $request) {
        
        $_POST = $this->toUpper($_POST);
       
        $array_tipo_cargo = explode("|", $_POST["idtipocargo"]);
        $_POST["idtipocargo"] = $array_tipo_cargo[0];
        if ($request->input("idcargo") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("public.cargo", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("public.cargo", $_POST));
        }


        if(empty($_REQUEST["idnivel"])) {
            $estado = DB::table("public.cargo")
            ->where("idcargo", $result["id"])
            ->update(array("idnivel" => null));
        }
   
        // DB::table("public.cargo_idiomas")->where("idcargo", $result["id"])->delete();
        // if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {
     
        //     $_POST["idcargo"] = $result["id"];
           
        //     $this->base_model->insertar($this->preparar_datos("public.cargo_idiomas", $_POST, "D"), "D");
        // }
        echo json_encode($result);
    }

    public function eliminar_cargos() {
       

        try {
            $sql_cargos_miembro = "SELECT * FROM iglesias.cargo_miembro WHERE idcargo=".$_REQUEST["id"];
            $cargos_miembro = DB::select($sql_cargos_miembro);

            if(count($cargos_miembro) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, ESTE CARGO YA ESTA ASIGNADO A UN MIEMBRO");
            }


            $sql_pastores = "SELECT * FROM iglesias.otrospastores WHERE idcargo=".$_REQUEST["id"];
            $pastores = DB::select($sql_pastores);

            if(count($pastores) > 0) {
                throw new Exception("NO SE PUEDE ELIMINAR, ESTE CARGO YA ESTA ASIGNADO A UN PASTOR");
            }

           

            $result = $this->base_model->eliminar(["public.cargo","idcargo"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get(Request $request) {

        $sql = "SELECT *, (tc.idtipocargo || '|' || tc.posee_nivel) AS idtipocargo, tc.posee_nivel FROM public.cargo AS c
        LEFT JOIN public.tipocargo AS tc ON(c.idtipocargo=tc.idtipocargo)
        WHERE c.idcargo=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }



    public function obtener_cargos(Request $request) {
        $sql = "";
		if(isset($_REQUEST["idtipocargo"]) && !empty($_REQUEST["idtipocargo"])) {
            $sql = "SELECT idcargo as id, descripcion FROM public.cargo 
            WHERE estado='1' AND idtipocargo=".$request->input("idtipocargo")." 
            ORDER BY idcargo ASC";
		
        } elseif(isset($_REQUEST["idnivel"]) && !empty($_REQUEST["idnivel"])) {
            
            $sql = "SELECT idcargo as id, descripcion FROM public.cargo 
            WHERE estado='1' AND idnivel=".$request->input("idnivel")." 
            ORDER BY idcargo ASC";
		
        } else {
            $sql = "SELECT idcargo as id, descripcion FROM public.cargo 
            WHERE estado='1'
            ORDER BY idcargo ASC";
        }

        
        $result = DB::select($sql);
        echo json_encode($result);
    }


    
    public function obtener_traducciones(Request $request) {
        $sql = "SELECT pi.idioma_id, pi.pi_descripcion AS descripcion, i.idioma_descripcion FROM public.cargo_idiomas AS pi
        INNER JOIN public.idiomas AS i ON(i.idioma_id=pi.idioma_id)
        WHERE pi.idcargo=".$request->input("idcargo")."
        ORDER BY pi.idioma_id ASC";
       $result = DB::select($sql);
       echo json_encode($result);
       //print_r($_REQUEST);
    }
    
}
