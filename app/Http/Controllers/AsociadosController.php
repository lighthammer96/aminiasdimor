<?php

namespace App\Http\Controllers;

use App\Models\AsociadosModel;
use App\Models\BaseModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PDF;

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


    public function curriculum() {
        $view = "asociados.curriculum";
        $data["title"] = traducir('traductor.titulo_curriculum');
        $data["subtitle"] = "";
        $data["tabla"] = $this->asociados_model->tabla("1")->HTML();
 

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="ingresar-datos">'.traducir("traductor.ingresar_datos").' [F1]</button>';
        // $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-asociado">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button disabled="disabled" tecla_rapida="F4" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ver-asociado">'.traducir("traductor.ver").' [F4]</button>';
        // $botones[3] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-asociado">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["curriculum.js"]);
        return parent::init($view, $data);
    }



    public function buscar_datos() {
        // var_dump($_REQUEST["curriculum"]); 
        // $_REQUEST["pdf"] = $_REQUEST["pdf"];
        $curriculum = "";
        if(isset($_REQUEST["curriculum"])) {
            $curriculum = $_REQUEST["curriculum"];
        }
        $json_data = $this->asociados_model->tabla($curriculum)->obtenerDatos();
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

        $_POST["fecharegistro"] = date("Y-m-d H:i:s");
        $response = array();

        try {
            DB::beginTransaction();

            $sql_validacion = "SELECT * FROM iglesias.miembro WHERE idtipodoc={$request->input("idtipodoc")} AND nrodoc='{$request->input("nrodoc")}' AND pais_id_nacimiento={$request->input("pais_id_nacimiento")}";
            // die($sql_validacion);
            $validacion = DB::select($sql_validacion);

            if($request->input("idmiembro") == '' && count($validacion) > 0) {
                $response["validacion"] = "ED"; //EXISTE DOCUMENTO
                throw new Exception(traducir("traductor.existe_asociado"));
            }

            if(isset($_POST["pais_id"])) {

                $array_pais = explode("|", $_POST["pais_id"]);
                $_POST["pais_id"] = $array_pais[0];
                if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($request->input("idunion"))) {
                    $sql = "SELECT * FROM iglesias.union AS u 
                    INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                    WHERE up.pais_id={$_POST["pais_id"]}";
                    $res = DB::select($sql);
                    $_POST["idunion"] = $res[0]->idunion;
                }
            }

         

           
            
           

            // $array_tipo_cargo = explode("|", $_POST["idtipocargo"]);
            // $_POST["idtipocargo"] = $array_tipo_cargo[0];

            $_POST["fechaingresoiglesia"]            = $this->FormatoFecha($_REQUEST["fechaingresoiglesia"], "server");
            $_POST["fechanacimiento"] = $this->FormatoFecha($_REQUEST["fechanacimiento"], "server")." ".date("H:i:s");
            $_POST["fechabautizo"] = $this->FormatoFecha($_REQUEST["fechabautizo"], "server");

            $_POST = $this->toUpper($_POST, ["tipolugarnac", "direccion", "email", "emailalternativo", "tabla_encargado_bautizo", "texto_bautismal"]);
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
                    throw new Exception(traducir("traductor.error_foto"));
                }
                $_POST["foto"] = $response["NombreFile"];
            
                $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
              
            }
            
            
        //    var_dump(isset($_REQUEST["idcargo"]));
        //    var_dump(!empty($_REQUEST["idcargo"]));
        //    exit;
            //$_REQUEST["idcargo"] = (array) $_REQUEST["idcargo"];
            // echo gettype($_REQUEST["idcargo"]); exit;
            if(isset($_REQUEST["idcargo"]) && gettype($_REQUEST["idcargo"]) == "array" && count($_REQUEST["idcargo"]) > 0) {
                DB::table("iglesias.cargo_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
                //print_r($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D")); exit;
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D"), "D");
               
            }

            //$_REQUEST["capacitacion"] = (array) $_REQUEST["capacitacion"];

            if(isset($_REQUEST["capacitacion"]) && gettype($_REQUEST["capacitacion"]) == "array" && count($_REQUEST["capacitacion"]) > 0) {
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

        $sql = "SELECT m.*, (m.pais_id || '|' || p.posee_union) AS pais_id, p.posee_union,  vr.nombres AS responsable,
        CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
        ELSE di.di_descripcion END AS division,
        (SELECT v.pais FROM iglesias.vista_jerarquia AS v WHERE v.pais_id=m.pais_id LIMIT 1) AS pais,
        (SELECT v.union FROM iglesias.vista_jerarquia AS v WHERE v.idunion=m.idunion LIMIT 1) AS union,
        (SELECT v.mision FROM iglesias.vista_jerarquia AS v WHERE v.idmision=m.idmision LIMIT 1) AS asociacion,
        (SELECT v.distritomisionero FROM iglesias.vista_jerarquia AS v WHERE v.iddistritomisionero=m.iddistritomisionero LIMIT 1) AS distrito_misionero,
        (SELECT v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=m.idiglesia LIMIT 1) AS iglesia
        FROM iglesias.miembro AS m 
        LEFT JOIN iglesias.paises AS p ON(p.pais_id=m.pais_id)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.division AS d ON(d.iddivision=m.iddivision)
        LEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
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
        $sql = "SELECT idestadocivil as id, descripcion FROM public.estadocivil ORDER BY descripcion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_nivel_educativo() {
        $sql = "SELECT idgradoinstruccion as id, descripcion FROM public.gradoinstruccion ORDER BY descripcion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_profesiones() {
        $sql = "SELECT idocupacion as id, descripcion FROM public.ocupacion ORDER BY descripcion ASC";
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
        $sql = "SELECT cm.*, c.descripcion AS cargo, tc.idtipocargo, tc.descripcion AS tipo_cargo /*, i.descripcion AS institucion*/, n.descripcion AS nivel FROM iglesias.cargo_miembro AS cm
        INNER JOIN iglesias.miembro AS m ON(m.idmiembro=cm.idmiembro)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        INNER JOIN public.nivel AS n ON(n.idnivel=c.idnivel)
        INNER JOIN public.tipocargo AS tc ON(n.idtipocargo=tc.idtipocargo)
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
        $sql = "SELECT h.*, CASE WHEN h.alta = '1' THEN 'ALTA' ELSE 'BAJA' END tipo, vr.nombres AS responsable, CASE WHEN mb.descripcion IS NULL THEN '' ELSE mb.descripcion END AS motivo_baja, ".formato_fecha_idioma("h.fecha")." AS fecha
        FROM iglesias.historial_altasybajas AS h
        LEFT JOIN iglesias.motivobaja  AS mb ON(mb.idmotivobaja=h.idmotivobaja)
        LEFT JOIN iglesias.vista_responsables AS vr ON(vr.id=h.responsable AND vr.tabla=h.tabla)
        WHERE h.idmiembro=".$request->input("idmiembro");
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_traslados(Request $request) {

        $funcion_1 = ", iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || ht.idiglesiaanterior, ".session("idioma_id").", ".session("idioma_id_defecto").") AS iglesia_anterior";


        $funcion_2 = ", iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || ht.idiglesiaactual, ".session("idioma_id").", ".session("idioma_id_defecto").") AS iglesia_traslado";

        $sql = "SELECT 
        ct.* /*,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.distritomisionero  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ht.idiglesiaanterior) AS iglesia_anterior,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.distritomisionero  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ht.idiglesiaactual) AS iglesia_traslado,*/
        ".$funcion_1.$funcion_2.",
        ".formato_fecha_idioma("ht.fecha")." AS fecha
        
        FROM iglesias.historial_traslados AS ht
        LEFT JOIN iglesias.control_traslados AS ct ON(ct.idcontrol=ht.idcontrol)
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


    public function imprimir_ficha_asociado($idmiembro) {

        $datos = array();
        $sql_miembro = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, ec.descripcion AS estado_civil, CASE WHEN m.sexo='M' THEN '".traducir("traductor.hombre")."' ELSE '".traducir("traductor.mujer")."' END AS sexo, CASE WHEN estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN public.estadocivil AS ec ON(ec.idestadocivil=m.idestadocivil)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        WHERE m.idmiembro={$idmiembro}";
        $miembro = DB::select($sql_miembro);

        $sql_estado_civil = "SELECT * FROM public.estadocivil";
        $estado_civil = DB::select($sql_estado_civil);

        $sql_baja = "SELECT h.*, ".formato_fecha_idioma("h.fecha")." AS fecha, mb.descripcion AS motivo_baja
        FROM iglesias.historial_altasybajas AS h
        INNER JOIN iglesias.motivobaja AS mb ON(mb.idmotivobaja=h.idmotivobaja)
        WHERE h.idmiembro=".$idmiembro."
        ORDER BY h.fecha DESC";
        $baja = DB::select($sql_baja);

        // $sql_motivos_baja = "SELECT * FROM iglesias.motivobaja";
        // $motivos_baja = DB::select($sql_motivos_baja);

        $sql_cargos = "SELECT c.descripcion AS cargo, cm.periodoini, cm.periodofin, cm.lugar FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(cm.idmiembro=m.idmiembro)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        WHERE m.idmiembro=".$idmiembro;
        $cargos = DB::select($sql_cargos);
        

        $sql_control = "SELECT ".formato_fecha_idioma("ct.fecha")." AS fecha_aceptacion, ".formato_fecha_idioma("ht.fecha")." AS fecha_aceptacion_local FROM iglesias.control_traslados AS ct
        INNER JOIN iglesias.historial_traslados AS ht ON(ct.idcontrol=ht.idcontrol)
        WHERE estado='0' AND ht.idmiembro=".$idmiembro." 
        ORDER BY ct.idcontrol DESC";
        $control = DB::select($sql_control);
        $datos["fecha_aceptacion"] = (isset($control[0]->fecha_aceptacion)) ? $control[0]->fecha_aceptacion : "";
        $datos["fecha_aceptacion_local"] = (isset($control[0]->fecha_aceptacion_local)) ? $control[0]->fecha_aceptacion_local : "";

        $datos["miembro"] = $miembro;
        $datos["estado_civil"] = $estado_civil;
        $datos["baja"] = $baja;
        // $datos["motivos_baja"] = $motivos_baja; 
        $datos["cargos"] = $cargos; 
        $datos["nivel_organizativo"] = session("nivel_organizativo"); 
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("asociados.ficha", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("ficha_asociado.pdf"); // ver
    }

    public function imprimir_ficha_bautizo($idmiembro) {
      

        $datos = array();
        $sql_miembro = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, i.descripcion AS iglesia
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        WHERE m.idmiembro={$idmiembro}";
        $miembro = DB::select($sql_miembro);
        
        $datos["miembro"] = $miembro;
        $datos["nivel_organizativo"] = session("nivel_organizativo");

        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=6 AND cm.vigente='1' AND  m.idiglesia=".$miembro[0]->idiglesia;
        $secretario = DB::select($sql_secretario);

        $datos["nombre_secretario"] = (isset($secretario[0]->nombres))  ? $secretario[0]->nombres : "";
       
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("asociados.ficha_bautizo", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("ficha_bautizo.pdf"); // ver
        
    }

    public function guardar_curriculum(Request $request) {

        if(isset($_REQUEST["idparentesco"]) && gettype($_REQUEST["idparentesco"]) == "array" && count($_REQUEST["idparentesco"]) > 0) {
            DB::table("iglesias.parentesco_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
            // print_r($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D")); exit;
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.parentesco_miembro", $_POST, "D"), "D");
           
        }


        if(isset($_REQUEST["nivelestudios"]) && gettype($_REQUEST["nivelestudios"]) == "array" && count($_REQUEST["nivelestudios"]) > 0) {
            DB::table("iglesias.educacion_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
            // print_r($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D")); exit;
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.educacion_miembro", $_POST, "D"), "D");
           
        }


        if(isset($_REQUEST["cargo"]) && gettype($_REQUEST["cargo"]) == "array" && count($_REQUEST["cargo"]) > 0) {
            DB::table("iglesias.laboral_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
            // print_r($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D")); exit;
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.laboral_miembro", $_POST, "D"), "D");
           
        }

        echo json_encode($result);
    }

    public function obtener_parentesco_miembro(Request $request) {
        $sql = "SELECT pm.*, p.descripcion AS parentesco, td.descripcion AS tipodoc, pp.descripcion AS pais
        FROM iglesias.parentesco_miembro AS pm
        INNER JOIN iglesias.miembro AS m ON(m.idmiembro=pm.idmiembro)
        INNER JOIN public.parentesco AS p ON(p.idparentesco=pm.idparentesco)

        INNER JOIN public.pais AS pp ON(pp.idpais=pm.idpais)
        INNER JOIN public.tipodoc AS td ON(td.idtipodoc=pm.idtipodoc)

        /*INNER JOIN iglesias.institucion AS i ON(i.idinstitucion=cm.idinstitucion)*/
        WHERE pm.idmiembro=".$request->input("idmiembro")."
        ORDER BY pm.idparentescomiembro DESC";
        $result = DB::select($sql);
        echo json_encode($result);
       //print_r($_REQUEST);
    }


    public function obtener_educacion_miembro(Request $request) {
        $sql = "SELECT em.*
        FROM iglesias.educacion_miembro AS em
        INNER JOIN iglesias.miembro AS m ON(m.idmiembro=em.idmiembro)
       

        /*INNER JOIN iglesias.institucion AS i ON(i.idinstitucion=cm.idinstitucion)*/
        WHERE em.idmiembro=".$request->input("idmiembro")."
        ORDER BY em.ideducacionmiembro DESC";
        $result = DB::select($sql);
        echo json_encode($result);
       //print_r($_REQUEST);
    }


    public function obtener_laboral_miembro(Request $request) {
        $sql = "SELECT lm.*
        FROM iglesias.laboral_miembro AS lm
        INNER JOIN iglesias.miembro AS m ON(m.idmiembro=lm.idmiembro)
       

        /*INNER JOIN iglesias.institucion AS i ON(i.idinstitucion=cm.idinstitucion)*/
        WHERE lm.idmiembro=".$request->input("idmiembro")."
        ORDER BY lm.idlaboralmiembro DESC";
        $result = DB::select($sql);
        echo json_encode($result);
       //print_r($_REQUEST);
    }


    public function imprimir_curriculum($idmiembro) {

        $datos = array();
        $sql_miembro = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, CASE WHEN m.sexo='M' THEN 'Masculino' ELSE 'Femenino' END AS sexo, mi.descripcion AS nivel_organizativo
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.mision AS mi  ON(m.idmision=mi.idmision)
        WHERE m.idmiembro={$idmiembro}";
        $miembro = DB::select($sql_miembro);

       

        $sql_cargos = "SELECT c.descripcion AS cargo, cm.periodoini, cm.periodofin, cm.lugar, cm.vigente, cm.lugar FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(cm.idmiembro=m.idmiembro)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        WHERE m.idmiembro=".$idmiembro."
        ORDER BY cm.idcargomiembro DESC";
        $cargos = DB::select($sql_cargos);


        $sql_parentesco = "SELECT pm.*, p.descripcion AS parentesco, td.descripcion AS tipodoc, pp.descripcion AS pais, ".formato_fecha_idioma("pm.fechanacimiento")." AS fechanacimiento
        FROM iglesias.parentesco_miembro AS pm
        INNER JOIN public.parentesco AS p ON(p.idparentesco=pm.idparentesco)
        INNER JOIN public.tipodoc AS td ON(td.idtipodoc=pm.idtipodoc)
        INNER JOIN public.pais AS pp ON(pp.idpais=pm.idpais)
        WHERE pm.idmiembro=".$idmiembro;
        $parentesco = DB::select($sql_parentesco);


        $sql_educacion = "SELECT em.* 
        FROM iglesias.educacion_miembro AS em
     
        WHERE em.idmiembro=".$idmiembro;
        $educacion = DB::select($sql_educacion);

        $sql_laboral = "SELECT * FROM iglesias.laboral_miembro WHERE idmiembro=".$idmiembro;
        $laboral = DB::select($sql_laboral);

        $nivel_organizativo = $miembro[0]->nivel_organizativo;
        foreach ($cargos as $key => $value) {
            if($value->vigente == "1") {
                $nivel_organizativo = $value->lugar;
                break;
            }
        }
        
        $datos["miembro"] = $miembro;
        $datos["parentesco"] = $parentesco;
        $datos["educacion"] = $educacion;
        $datos["laboral"] = $laboral;
        $datos["nivel_organizativo"] = $nivel_organizativo
        ;
    
        $datos["cargos"] = $cargos; 
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("asociados.imprimir_curriculum", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("curriculum.pdf"); // ver
    }
   
}
