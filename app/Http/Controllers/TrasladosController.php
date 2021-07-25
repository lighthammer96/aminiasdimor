<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\TrasladosModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PDF;
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

    public function control() {
        $view = "traslados.control";
        $data["title"] = traducir("traductor.titulo_control_traslados");
        $data["subtitle"] = "";
        $data["tabla"] = $this->traslados_model->tabla_control()->HTML();
       
        $botones = array();
        $botones[0] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="finalizar-traslado">'.traducir("traductor.finalizar_traslado").' [F2]</button>';
        // $botones[1] = '<button tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["control.js"]);
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

    public function buscar_datos_control() {
        $json_data = $this->traslados_model->tabla_control()->obtenerDatos();
        echo json_encode($json_data);
    }

    // public function guardar_traslados(Request $request) {
   
    //     $_POST = $this->toUpper($_POST);
    //     if ($request->input("perfil_id") == '') {
    //         $result = $this->base_model->insertar($this->preparar_datos("iglesias.historial_traslados", $_POST));
    //     }else{
    //         $result = $this->base_model->modificar($this->preparar_datos("iglesias.historial_traslados", $_POST));
    //     }

    //     $result = array();
    //     echo json_encode($result);
    // }

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
                throw new Exception(traducir("traductor.asociados_iglesia_origen"));
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

        $sql = "SELECT * FROM iglesias.control_traslados WHERE idcontrol=".$request->input("id");
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
    
    public function guardar_traslados_mi(Request $request) {
        // print_r($_REQUEST);
        // print_r($_FILES);

        // exit;
        $array_pais_destino = explode("|", $_POST["pais_iddestino"]);
        $_POST["pais_iddestino"] = $array_pais_destino[0];
        if($array_pais_destino[1] == "N" && empty($request->input("iduniondestino"))) {
            $sql = "SELECT * FROM iglesias.union AS u 
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_POST["pais_iddestino"]}";
            $res = DB::select($sql);
            $_POST["iduniondestino"] = $res[0]->idunion;
        
        }
        $sql = "SELECT * FROM iglesias.temp_traslados WHERE tipo_traslado=".$request->input("tipo_traslado_mi")." AND usuario_id=".session("usuario_id");

        $traslados = DB::select($sql);

        foreach($traslados as $key => $value) {
            
            $value->idiglesiaanterior = $value->idiglesia;
            $value->idiglesiaactual = $request->input("idiglesiadestino");
            $value->fecha = date("Y-m-d");
            $array = (array) $value;

            if($request->input("tipo_traslado_mi") == "2") {
                
                $_POST["status"] = "t"; // traslado
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.historial_traslados", $array));

                $update = array();
                $update["idmiembro"] = $value->idmiembro;
                $update["iddivision"] = $request->input("iddivisiondestino");
                $update["pais_id"] = $_POST["pais_iddestino"];
                $update["idunion"] = $_POST["iduniondestino"];
                $update["idmision"] = $request->input("idmisiondestino");
                $update["iddistritomisionero"] = $request->input("iddistritomisionerodestino");
                $update["idiglesia"] = $request->input("idiglesiadestino");

                $result = $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $update));
            }

            if($request->input("tipo_traslado_mi") == "3") {

                $array["iddivisionactual"] = $request->input("iddivisiondestino");
                $array["pais_idactual"] = $_POST["pais_iddestino"];
                $array["idunionactual"] = $_POST["iduniondestino"];
                $array["idmisionactual"] = $request->input("idmisiondestino");
                $array["iddistritomisioneroactual"] = $request->input("iddistritomisionerodestino");

                $result = $this->base_model->insertar($this->preparar_datos("iglesias.control_traslados", $array));
                $_POST["status"] = "tp"; // traslado en proceso
                $_POST["idcontrol"] = $result["id"];
                // if (isset($_FILES["carta"]) && $_FILES["carta"]["error"] == "0") {
    
                //     $response = $this->SubirArchivo($_FILES["carta"], base_path("public/carta_traslados/"), "carta_traslado_" . $value->idmiembro."_". $_POST["idcontrol"]);
                //     if ($response["response"] == "ERROR") {
                //         throw new Exception('Error al subir carta de traslado!');
                //     }
                //     $_POST["carta_traslado"] = $response["NombreFile"];
                
                //     $result = $this->base_model->modificar($this->preparar_datos("iglesias.control_traslados", $_POST));
                // }
            }
            
        }

        DB::table("iglesias.temp_traslados")->where(array("usuario_id" => session("usuario_id"), "tipo_traslado" => $request->input("tipo_traslado_mi")))->delete();
        $result["tipo_acceso"] = $request->input("tipo_traslado_mi");
        echo json_encode($_POST);  
    }

    public function agregar_traslado(Request $request) {
        DB::table("iglesias.temp_traslados")->where(array("usuario_id" => session("usuario_id"), "tipo_traslado" => $_REQUEST["tipo_traslado"], "idmiembro" => $request->input('idmiembro')))->delete();

        $sql = "SELECT vat.*, ".session("usuario_id")." AS usuario_id, ".$_REQUEST["tipo_traslado"]." AS tipo_traslado FROM iglesias.vista_asociados_traslados AS vat
        WHERE idmiembro={$request->input('idmiembro')}";
        $miembro = DB::select($sql);

        foreach($miembro as $value) {
            $array = (array) $value;
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.temp_traslados", $array));
        }

        echo json_encode($result);
    }

    public function guardar_control(Request $request) {
        $update_control = array();
        $update_control["idcontrol"] = $request->input("idcontrol");
        // if (isset($_FILES["carta"]) && $_FILES["carta"]["error"] == "0") {

        //     $response = $this->SubirArchivo($_FILES["carta"], base_path("public/carta_traslados/"), "carta_aceptacion_" . $request->input("idmiembro")."_". $request->input("idcontrol"));
        //     if ($response["response"] == "ERROR") {
        //         throw new Exception('Error al subir carta de aceptacion!');
        //     }
        //     $update_control["carta_aceptacion"] = $response["NombreFile"];
        //     $update_control["estado"] = "0";
         
        //     $result = $this->base_model->modificar($this->preparar_datos("iglesias.control_traslados", $update_control));
        // }

        $update_control["estado"] = "0";
        $result = $this->base_model->modificar($this->preparar_datos("iglesias.control_traslados", $update_control));

        $_POST["fecha"] = date("Y-m-d");
        $_POST["idcontrol"] = $request->input("idcontrol");
        $result = $this->base_model->insertar($this->preparar_datos("iglesias.historial_traslados", $_POST));

        $update = array();
        $update["idmiembro"] = $request->input("idmiembro");
        $update["iddivision"] = $request->input("iddivisionactual");
        $update["pais_id"] = $request->input("pais_idactual");
        $update["idunion"] = $request->input("idunionactual");
        $update["idmision"] = $request->input("idmisionactual");
        $update["iddistritomisionero"] = $request->input("iddistritomisioneroactual");
        $update["idiglesia"] = $request->input("idiglesiaactual");

        $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $update));

        echo json_encode($result);
    }

    public function imprimir_carta_iglesia($idmiembro, $idcontrol) {
      

        $datos = array();
        $sql_miembro = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, i.descripcion AS iglesia, i.direccion AS direccion_iglesia, ec.descripcion AS estado_civil
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        LEFT JOIN public.estadocivil AS ec ON(ec.idestadocivil=m.idestadocivil)
        WHERE m.idmiembro={$idmiembro}";
        $miembro = DB::select($sql_miembro);

        $sql_estado_civil = "SELECT * FROM public.estadocivil";
        $estado_civil = DB::select($sql_estado_civil);
        
        $datos["miembro"] = $miembro;
        // $datos["estado_civil"] = $estado_civil;
        $datos["nivel_organizativo"] = session("nivel_organizativo");
        // print_r(session("nivel_organizativo")); exit;
        
        $sql_control = "SELECT
        ct.idiglesiaanterior,
        ct.idiglesiaactual,
        ".formato_fecha_idioma("ct.fecha")." AS fecha,
        /*(SELECT v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior) AS 
        iglesia_origen,*/
        (SELECT v.iglesia || ' / ' || v.distritomisionero  || ' / ' ||  v.mision || ' / ' || v.union  || ' / ' || v.pais || ' / ' || v.division  FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior) AS iglesia_origen,

        /*(SELECT v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) AS iglesia_destino,*/
        (SELECT v.iglesia || ' / ' || v.distritomisionero  || ' / ' ||  v.mision || ' / ' || v.union  || ' / ' || v.pais || ' / ' || v.division  FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) AS iglesia_destino,
        (SELECT direccion FROM iglesias.iglesia WHERE idiglesia=ct.idiglesiaanterior) AS direccion_origen
        FROM iglesias.control_traslados AS ct
        WHERE ct.idcontrol={$idcontrol}";
        $control = DB::select($sql_control);

        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=6 AND cm.vigente='1' AND  m.idiglesia=".$control[0]->idiglesiaanterior;
        $secretario = DB::select($sql_secretario);

        $sql_director = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=5 AND cm.vigente='1' AND  m.idiglesia=".$control[0]->idiglesiaanterior;

        $director = DB::select($sql_director);
        // $datos["fecha"] = $control[0]->fecha;

        // $datos["iglesia_origen"] = $control[0]->iglesia_origen;
        // $datos["iglesia_destino"] = $control[0]->iglesia_destino;
        
        $datos["control"] = $control;
        $datos["nombre_secretario"] = (isset($secretario[0]->nombres))  ? $secretario[0]->nombres : "";
        $datos["nombre_director"] = (isset($director[0]->nombres))  ? $director[0]->nombres : "";
       
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("traslados.carta_iglesia", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("carta_iglesia.pdf"); // ver
        
    }

    
    public function imprimir_respuesta_carta_iglesia($idmiembro, $idcontrol) {
      

        $datos = array();
        $sql_miembro = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, i.descripcion AS iglesia, i.direccion AS direccion_iglesia, ec.descripcion AS estado_civil
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        LEFT JOIN public.estadocivil AS ec ON(ec.idestadocivil=m.idestadocivil)
        WHERE m.idmiembro={$idmiembro}";
        $miembro = DB::select($sql_miembro);
        
        
        // $sql_estado_civil = "SELECT * FROM public.estadocivil";
        // $estado_civil = DB::select($sql_estado_civil);
        
        $datos["miembro"] = $miembro;
        // $datos["estado_civil"] = $estado_civil;

        $datos["nivel_organizativo"] = session("nivel_organizativo");
        // print_r(session("nivel_organizativo")); exit;
        
        $sql_control = "SELECT
        ct.idiglesiaanterior,
        ct.idiglesiaactual,
        ".formato_fecha_idioma("ct.fecha")." AS fecha,
        /*(SELECT v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior) AS iglesia_destino,*/
        (SELECT v.iglesia || ' / ' || v.distritomisionero  || ' / ' ||  v.mision || ' / ' || v.union  || ' / ' || v.pais || ' / ' || v.division  FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior) AS iglesia_destino,
        /*(SELECT v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) AS iglesia_origen,*/
        (SELECT v.iglesia || ' / ' || v.distritomisionero  || ' / ' ||  v.mision || ' / ' || v.union  || ' / ' || v.pais || ' / ' || v.division  FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) AS iglesia_origen,
        (SELECT direccion FROM iglesias.iglesia WHERE idiglesia=ct.idiglesiaactual) AS direccion_destino,
        ".formato_fecha_idioma("ht.fecha")." AS fecha_traslado
        FROM iglesias.control_traslados AS ct
        LEFT JOIN iglesias.historial_traslados AS ht ON(ht.idcontrol=ct.idcontrol)
        WHERE ct.idcontrol={$idcontrol}";
        $control = DB::select($sql_control);

        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=6 AND cm.vigente='1' AND  m.idiglesia=".$control[0]->idiglesiaactual;
        $secretario = DB::select($sql_secretario);

        $sql_director = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=5 AND cm.vigente='1' AND  m.idiglesia=".$control[0]->idiglesiaactual;

        $director = DB::select($sql_director);
        // $datos["fecha"] = $control[0]->fecha;

        // $datos["iglesia_origen"] = $control[0]->iglesia_origen;
        // $datos["iglesia_destino"] = $control[0]->iglesia_destino;

        $datos["control"] = $control;
        $datos["fecha"] = (empty($control[0]->fecha_traslado)) ? fecha_actual_idioma() : $control[0]->fecha_traslado;
        $datos["nombre_secretario"] = (isset($secretario[0]->nombres))  ? $secretario[0]->nombres : "";
        $datos["nombre_director"] = (isset($director[0]->nombres))  ? $director[0]->nombres : "";



        
       
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("traslados.respuesta_carta_iglesia", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("respuesta_carta_iglesia.pdf"); // ver
        
    }
    
}
