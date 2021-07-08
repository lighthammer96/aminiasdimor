<?php

namespace App\Http\Controllers;

use App\Models\AsociadosModel;
use App\Models\BaseModel;
use Exception;
use Illuminate\Http\Request;
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
        $view = "asociados.index";
        $data["title"] = traducir('traductor.titulo_asociados');
        $data["subtitle"] = "";
        $data["tabla"] = $this->asociados_model->tabla()->HTML();
        $data["tabla_responsables"] = $this->asociados_model->tabla_responsables()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-asociado">'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-asociado">'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F4" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ver-asociado">'.traducir("traductor.ver").' [F4]</button>';
        // $botones[3] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-asociado">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["asociados.js"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->asociados_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }

    public function buscar_datos_responsables() {
        $json_data = $this->asociados_model->tabla_responsables()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_asociados(Request $request) {
        // $r = $this->preparar_datos("iglesias.cargo_miembro", $_POST, "D");
        // print_r($r);
        //  exit;
        $response = array();

        try {
            DB::beginTransaction();

            $sql_validacion = "SELECT * FROM iglesias.miembro WHERE idtipodoc={$request->input("idtipodoc")} AND nrodoc='{$request->input("nrodoc")}' AND pais_id_nacimiento={$request->input("pais_id_nacimiento")}";
            // die($sql_validacion);
            $validacion = DB::select($sql_validacion);

            if($request->input("idmiembro") == '' && count($validacion) > 0) {
                $response["validacion"] = "ED"; //EXISTE DOCUMENTO
                throw new Exception("Ya existe un asociado con el mismo número de documento!");
            }

            $array_pais = explode("|", $_POST["pais_id"]);
            $_POST["pais_id"] = $array_pais[0];
            if($array_pais[1] == "N" && empty($request->input("idunion"))) {
                $sql = "SELECT * FROM iglesias.union AS u 
                INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                WHERE up.pais_id={$_POST["pais_id"]}";
                $res = DB::select($sql);
                $_POST["idunion"] = $res[0]->idunion;
            }

            // $array_tipo_cargo = explode("|", $_POST["idtipocargo"]);
            // $_POST["idtipocargo"] = $array_tipo_cargo[0];

            $_POST["fecharegistro"]            = $this->FormatoFecha($_REQUEST["fecharegistro"], "server");
            $_POST["fechanacimiento"] = $this->FormatoFecha($_REQUEST["fechanacimiento"], "server")." ".date("H:i:s");
            $_POST["fechabautizo"] = $this->FormatoFecha($_REQUEST["fechabautizo"], "server");

            $_POST = $this->toUpper($_POST, ["tipolugarnac", "direccion", "email", "emailalternativo", "tabla_encargado_bautizo"]);
            if ($request->input("idmiembro") == '') {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.miembro", $_POST));
            }else{ 
                // print_r($this->preparar_datos("iglesias.miembro", $_POST)); exit;
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
                // print_r($result);
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
            
            
        //    var_dump(isset($_REQUEST["idcargo"]));
        //    var_dump(!empty($_REQUEST["idcargo"]));
        //    exit;
            $_REQUEST["idcargo"] = (array) $_REQUEST["idcargo"];
            if(isset($_REQUEST["idcargo"]) && count($_REQUEST["idcargo"]) > 0) {
                DB::table("iglesias.cargo_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
                // print_r($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D")); exit;
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D"), "D");
               
            }

            $_REQUEST["capacitacion"] = (array) $_REQUEST["capacitacion"];

            if(isset($_REQUEST["capacitacion"]) && count($_REQUEST["capacitacion"]) > 0) {
                DB::table("iglesias.capacitacion_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
                // print_r($this->preparar_datos("iglesias.capacitacion_miembro", $_POST, "D")); exit;
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.capacitacion_miembro", $_POST, "D"), "D");
               
            }

            DB::commit();
            echo json_encode($result);
        } catch (Exception $e) {
            DB::rollBack();
            $response["status"] = "ei"; 
            $response["msg"] = $e->getMessage(); 
            echo json_encode($response);
        }
    }

    public function guardar_bajas() {
        try {
            DB::beginTransaction();
            $_POST = $this->toUpper($_POST, ["tabla"]);
            $_POST["usuario"] = session("usuario_user");
            $_POST["idmiembro"] = $_POST["idmiembro_baja"];
            $_POST["responsable"] = $_POST["idresponsable"];
            $_POST["alta"] = "0";
            $_POST["rebautizo"] = "0";
            $_POST["fecha"] = $this->FormatoFecha($_REQUEST["fecha"], "server");
            
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.historial_altasybajas", $_POST));
            // print_r($result); exit; 
            $_POST["estado"] = "0";
            $_POST["idcondicioneclesiastica"] = 0;

            $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
           
            DB::commit();
            echo json_encode($result);
        } catch (Exception $e) {
            DB::rollBack();
            echo json_encode(array("status" => "ei", "msg" => $e->getMessage()));
        }
    }

    
    public function guardar_altas() {
        // print_r($_POST); exit;
        try {
            DB::beginTransaction();
            
            $_POST = $this->toUpper($_POST, ["tabla"]);
            $_POST["usuario"] = session("usuario_user");
            $_POST["idmiembro"] = $_POST["idmiembro_alta"];
            $_POST["responsable"] = $_POST["idresponsable"];
            $_POST["alta"] = "1";
            $_POST["rebautizo"] = "0";
            $_POST["fecha"] = $this->FormatoFecha($_REQUEST["fecha"], "server");
            if(isset($_POST["rebautizo"]) && $_POST["rebautizo"] == "on") {
                $_POST["rebautizo"] = "1";
            } 
      
            
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.historial_altasybajas", $_POST));
            // print_r($result); exit; 
            $_POST["estado"] = "1";
            $_POST["idcondicioneclesiastica"] = 1;

            $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
           
            DB::commit();
            echo json_encode($result);
        } catch (Exception $e) {
            DB::rollBack();
            echo json_encode(array("status" => "ei", "msg" => $e->getMessage()));
        }
    }

    public function eliminar_asociados() {
        $result = $this->base_model->eliminar(["iglesias.miembro","idmiembro"]);
        echo json_encode($result);
    }


    public function get(Request $request) {

        $sql = "SELECT m.*, (m.pais_id || '|' || p.posee_union) AS pais_id, p.posee_union,  vr.nombres AS responsable
        FROM iglesias.miembro AS m 
        LEFT JOIN iglesias.paises AS p ON(p.pais_id=m.pais_id)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
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

    public function obtener_periodos_ini() {
        $result = array();
        $array = array();
        for($i=date("Y"); $i>=1900; $i-- ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        echo json_encode($array);
    }

    public function obtener_periodos_fin() {
        $result = array();
        $array = array();
        for($i=date("Y")+4; $i>=1900; $i-- ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        echo json_encode($array);
    }


    public function obtener_cargos_miembro(Request $request) {
        $sql = "SELECT cm.*, c.descripcion AS cargo, tc.idtipocargo, tc.descripcion AS tipo_cargo /*, i.descripcion AS institucion*/ FROM iglesias.cargo_miembro AS cm
        INNER JOIN iglesias.miembro AS m ON(m.idmiembro=cm.idmiembro)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        INNER JOIN public.tipocargo AS tc ON(c.idtipocargo=tc.idtipocargo)
        /*INNER JOIN iglesias.institucion AS i ON(i.idinstitucion=cm.idinstitucion)*/
        WHERE cm.idmiembro=".$request->input("idmiembro")."
        ORDER BY cm.idcargomiembro DESC";
        $result = DB::select($sql);
        echo json_encode($result);
       //print_r($_REQUEST);
    }

    public function obtener_capacitacion_miembro(Request $request) {
        $sql = "SELECT cm.* FROM iglesias.capacitacion_miembro AS cm
        INNER JOIN iglesias.miembro AS m ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idmiembro=".$request->input("idmiembro")."
        ORDER BY cm.idcapacitacion DESC";
        $result = DB::select($sql);
        echo json_encode($result);
       //print_r($_REQUEST);
    }

    public function obtener_historial_altas_bajas(Request $request) {
        $sql = "SELECT h.*, CASE WHEN h.alta = '1' THEN 'ALTA' ELSE 'BAJA' END tipo, vr.nombres AS responsable, mb.descripcion AS motivo_baja, to_char(h.fecha, 'DD/MM/YYYY') AS fecha
        FROM iglesias.historial_altasybajas AS h
        INNER JOIN iglesias.motivobaja  AS mb ON(mb.idmotivobaja=h.idmotivobaja)
        LEFT JOIN iglesias.vista_responsables AS vr ON(vr.id=h.responsable AND vr.tabla=h.tabla)
        WHERE h.idmiembro=".$request->input("idmiembro");
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_traslados(Request $request) {
        $sql = "SELECT 
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ht.idiglesiaanterior) AS iglesia_anterior,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ht.idiglesiaactual) AS iglesia_traslado,
        to_char(ht.fecha, 'DD/MM/YYYY') AS fecha
        FROM iglesias.historial_traslados AS ht
        WHERE ht.idmiembro = ".$request->input("idmiembro");

        $result = DB::select($sql);

        echo json_encode($result);
    }

    
    public function obtener_anios() {
        $result = array();
        $array = array();
        for($i=date("Y"); $i>=2014; $i-- ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        echo json_encode($array);
    }
   
}
