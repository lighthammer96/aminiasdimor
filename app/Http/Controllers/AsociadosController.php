<?php

namespace App\Http\Controllers;

use App\Models\AsambleasModel;
use App\Models\AsociadosModel;
use App\Models\BaseModel;
use App\Models\CargosModel;
use App\Models\DistritosmisionerosModel;
use App\Models\DivisionesModel;
use App\Models\IglesiasModel;
use App\Models\MisionesModel;
use App\Models\NivelesModel;
use App\Models\PaisesModel;
use App\Models\PrincipalModel;
use App\Models\TiposcargoModel;
use App\Models\UnionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;
use PDF;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
// use PHPMailer\PHPMailer\Exception;

class AsociadosController extends Controller
{
    //

    private $base_model;
    private $asociados_model;
    private $divisiones_model;
    private $paises_model;
    private $uniones_model;
    private $misiones_model;
    private $distritos_misioneros_model;
    private $iglesias_model;
    private $principal_model;
    private $niveles_model;
    private $tipos_cargo_model;
    private $cargos_model;
    private $asambleas_model;

    public function __construct() {
        parent:: __construct();
        $this->asociados_model = new AsociadosModel();
        $this->base_model = new BaseModel();
        $this->divisiones_model = new DivisionesModel();
        $this->paises_model = new PaisesModel();
        $this->uniones_model = new UnionesModel();
        $this->misiones_model = new MisionesModel();
        $this->distritos_misioneros_model = new DistritosmisionerosModel();
        $this->iglesias_model = new IglesiasModel();
        $this->principal_model = new PrincipalModel();
        $this->niveles_model = new NivelesModel();
        $this->tipos_cargo_model = new TiposcargoModel();
        $this->cargos_model = new CargosModel();
        $this->asambleas_model = new AsambleasModel();
    }

    public function index() {


        $view = "asociados.index";
        $data["title"] = traducir('traductor.titulo_asociados');
        $data["subtitle"] = "";
        $data["tabla"] = $this->asociados_model->tabla()->HTML();
        $data["tabla_responsables"] = $this->asociados_model->tabla_responsables()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nuevo-asociado"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-asociado"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F4" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ver-asociado"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/documento.png').'"><br>'.traducir("traductor.ver").' [F4]</button>';
        $botones[3] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-asociado"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        // $botones[3] = '<button tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-asociado">'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["asociados.js?version=140620231547"]);
        return parent::init($view, $data);
    }


    public function asignacion_delegados() {


        $view = "asociados.asignacion_delegados";
        $data["title"] = traducir('asambleas.titulo_asignacion_delegados');
        $data["subtitle"] = "";


        $data["scripts"] = $this->cargar_js(["asignacion_delegados.js?version=160920212027"]);
        return parent::init($view, $data);
    }

    public function delegados() {


        $view = "asociados.delegados";
        $data["title"] = traducir('asambleas.titulo_delegados');
        $data["subtitle"] = "";
        $data["tabla"] = $this->asociados_model->tabla("", "1")->HTML();


        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ingresar-datos"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.ingresar_datos").' [F1]</button>';

        $data["botones"] = $botones;

        $data["scripts"] = $this->cargar_js(["delegados.js?version=051020212027"]);
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
        $data["scripts"] = $this->cargar_js(["curriculum.js?version=310820211759"]);
        return parent::init($view, $data);
    }



    public function buscar_datos() {
        // var_dump($_REQUEST["curriculum"]);
        // $_REQUEST["pdf"] = $_REQUEST["pdf"];
        $curriculum = "";
        if(isset($_REQUEST["curriculum"])) {
            $curriculum = $_REQUEST["curriculum"];
        }

        $delegados = "";
        if(isset($_REQUEST["delegados"])) {
            $delegados = $_REQUEST["delegados"];
        }
        $json_data = $this->asociados_model->tabla($curriculum, $delegados)->obtenerDatos();
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
            $idtipodoc = (isset($_REQUEST["idtipodoc"])) ? $request->input("idtipodoc") : 0;
            $nrodoc = (isset($_REQUEST["nrodoc"])) ? $request->input("nrodoc") : 0;
            $pais_id_nacimiento = (isset($_REQUEST["pais_id_nacimiento"])) ? $request->input("pais_id_nacimiento") : 0;


            $sql_validacion = "SELECT * FROM iglesias.miembro WHERE idtipodoc={$idtipodoc} AND nrodoc='{$nrodoc}' AND pais_id_nacimiento={$pais_id_nacimiento}";
            // die($sql_validacion);
            $validacion = DB::select($sql_validacion);

            if($request->input("idmiembro") == '' && count($validacion) > 0) {
                $response["validacion"] = "ED"; //EXISTE DOCUMENTO
                throw new Exception(traducir("traductor.existe_asociado"));
            }

            if(isset($_POST["pais_id"])) {

                $array_pais = explode("|", $_POST["pais_id"]);
                $_POST["pais_id"] = $array_pais[0];
                if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_POST["idunion"])) {
                    $sql = "SELECT * FROM iglesias.union AS u
                    INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                    WHERE up.pais_id={$_POST["pais_id"]}";
                    $res = DB::select($sql);
                    $_POST["idunion"] = $res[0]->idunion;
                }

                $_POST["pais_id_domicilio"] = $array_pais[0];
            }

            if(isset($_POST["posee_seguro"])) {
                $_POST["posee_seguro"] = "S";
            }  else {
                $_POST["posee_seguro"] = "N";
            }


            if(isset($_POST["posee_visa"])) {
                $_POST["posee_visa"] = "S";
            }  else {
                $_POST["posee_visa"] = "N";
            }




            // $array_tipo_cargo = explode("|", $_POST["idtipocargo"]);
            // $_POST["idtipocargo"] = $array_tipo_cargo[0];

            $_POST["fechaingresoiglesia"]            = (isset($_REQUEST["fechaingresoiglesia"])) ? $this->FormatoFecha($_REQUEST["fechaingresoiglesia"], "server") : "";
            $_POST["fechanacimiento"] = (isset($_REQUEST["fechanacimiento"])) ? $this->FormatoFecha($_REQUEST["fechanacimiento"], "server")." ".date("H:i:s") : "";
            $_POST["fechabautizo"] = (isset($_REQUEST["fechabautizo"])) ? $this->FormatoFecha($_REQUEST["fechabautizo"], "server") : "";
            $_POST["fecha_vencimiento_pasaporte"] = (isset($_REQUEST["fecha_vencimiento_pasaporte"])) ?$this->FormatoFecha($_REQUEST["fecha_vencimiento_pasaporte"], "server") : "";
            $_POST["fecha_pasaje"] = (isset($_REQUEST["fecha_pasaje"])) ? $this->FormatoFecha($_REQUEST["fecha_pasaje"], "server") : "";
            $_POST["fecha_inicia_seguro"] = (isset($_REQUEST["fecha_inicia_seguro"])) ? $this->FormatoFecha($_REQUEST["fecha_inicia_seguro"], "server") : "";
            $_POST["fecha_termina_seguro"] = (isset($_REQUEST["fecha_termina_seguro"])) ? $this->FormatoFecha($_REQUEST["fecha_termina_seguro"], "server") : "";
            $_POST["fecha_vencimiento_visa"] = (isset($_REQUEST["fecha_vencimiento_visa"])) ?$this->FormatoFecha($_REQUEST["fecha_vencimiento_visa"], "server") : "";

            $_POST = $this->toUpper($_POST, ["tipolugarnac", "direccion", "email", "emailalternativo", "tabla_encargado_bautizo", "texto_bautismal"]);
            if ($request->input("idmiembro") == '') {
                $_POST["fecharegistro"] = date("Y-m-d H:i:s");
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.miembro", $_POST));
            }else{
                // print_r($this->preparar_datos("iglesias.miembro", $_POST)); exit;git
                unset($_POST["iddivision"]);
                unset($_POST["pais_id"]);
                unset($_POST["idunion"]);
                unset($_POST["idmision"]);
                unset($_POST["iddistritomisionero"]);
                unset($_POST["idiglesia"]);

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
            DB::table("iglesias.cargo_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
            if(isset($_REQUEST["idcargo"]) && gettype($_REQUEST["idcargo"]) == "array" && count($_REQUEST["idcargo"]) > 0) {

                //print_r($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D")); exit;
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.cargo_miembro", $_POST, "D"), "D");

            }

            //$_REQUEST["capacitacion"] = (array) $_REQUEST["capacitacion"];
            DB::table("iglesias.capacitacion_miembro")->where("idmiembro", $request->input("idmiembro"))->delete();
            if(isset($_REQUEST["capacitacion"]) && gettype($_REQUEST["capacitacion"]) == "array" && count($_REQUEST["capacitacion"]) > 0) {

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

            $_POST = $this->toUpper($_POST, ["tabla", "rebautizo"]);
            $_POST["usuario"] = session("usuario_user");
            $_POST["idmiembro"] = $_POST["idmiembro_alta"];
            $_POST["responsable"] = $_POST["idresponsable"];
            $_POST["alta"] = "1";

            $_POST["fecha"] = $this->FormatoFecha($_REQUEST["fecha"], "server");
            // var_dump($_POST["rebautizo"]);
            if(isset($_POST["rebautizo"])) {
                $_POST["rebautizo"] = "1";
            }  else {
                $_POST["rebautizo"] = "0";
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
        try {
            $sql_capacitacion_miembro = "SELECT * FROM iglesias.capacitacion_miembro WHERE idmiembro=".$_REQUEST["id"];
            $capacitacion_miembro = DB::select($sql_capacitacion_miembro);

            if(count($capacitacion_miembro) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_capacitacion_miembro"));
            }

            $sql_cargo_miembro = "SELECT * FROM iglesias.cargo_miembro WHERE idmiembro=".$_REQUEST["id"];
            $cargo_miembro = DB::select($sql_cargo_miembro);

            if(count($cargo_miembro) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_cargo_miembro"));
            }


            $sql_control_traslados = "SELECT * FROM iglesias.control_traslados WHERE idmiembro=".$_REQUEST["id"];
            $control_traslados = DB::select($sql_control_traslados);

            if(count($control_traslados) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_control_traslados"));
            }

            $sql_educacion_miembro = "SELECT * FROM iglesias.educacion_miembro WHERE idmiembro=".$_REQUEST["id"];
            $educacion_miembro = DB::select($sql_educacion_miembro);

            if(count($educacion_miembro) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_educacion_miembro"));
            }

            $sql_historial_altasybajas = "SELECT * FROM iglesias.historial_altasybajas WHERE idmiembro=".$_REQUEST["id"];
            $historial_altasybajas = DB::select($sql_historial_altasybajas);

            if(count($historial_altasybajas) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_historial_altasybajas"));
            }

            $sql_historial_traslados = "SELECT * FROM iglesias.historial_traslados WHERE idmiembro=".$_REQUEST["id"];
            $historial_traslados = DB::select($sql_historial_traslados);

            if(count($historial_traslados) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_historial_traslados"));
            }

            $sql_laboral_miembro = "SELECT * FROM iglesias.laboral_miembro WHERE idmiembro=".$_REQUEST["id"];
            $laboral_miembro = DB::select($sql_laboral_miembro);

            if(count($laboral_miembro) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_laboral_miembro"));
            }

            $sql_parentesco_miembro = "SELECT * FROM iglesias.parentesco_miembro WHERE idmiembro=".$_REQUEST["id"];
            $parentesco_miembro = DB::select($sql_parentesco_miembro);

            if(count($parentesco_miembro) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_parentesco_miembro"));
            }

            $sql_usuarios = "SELECT * FROM seguridad.usuarios WHERE idmiembro=".$_REQUEST["id"];
            $usuarios = DB::select($sql_usuarios);

            if(count($usuarios) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_usuarios"));
            }

            $sql_comentarios = "SELECT * FROM asambleas.comentarios WHERE idmiembro=".$_REQUEST["id"];
            $comentarios = DB::select($sql_comentarios);

            if(count($comentarios) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_comentarios"));
            }

            $sql_delegados = "SELECT * FROM asambleas.delegados WHERE idmiembro=".$_REQUEST["id"];
            $delegados = DB::select($sql_delegados);

            if(count($delegados) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_delegados"));
            }


            $sql_detalle_asistencia = "SELECT * FROM asambleas.detalle_asistencia WHERE idmiembro=".$_REQUEST["id"];
            $detalle_asistencia = DB::select($sql_detalle_asistencia);

            if(count($detalle_asistencia) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_detalle_asistencia"));
            }

            $sql_detalle_propuestas = "SELECT * FROM asambleas.detalle_propuestas WHERE idmiembro=".$_REQUEST["id"];
            $detalle_propuestas = DB::select($sql_detalle_propuestas);

            if(count($detalle_propuestas) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_detalle_propuestas"));
            }


            $sql_votos = "SELECT * FROM asambleas.votos WHERE idmiembro=".$_REQUEST["id"];
            $votos = DB::select($sql_votos);

            if(count($votos) > 0) {
                throw new Exception(traducir("traductor.eliminar_asociado_votos"));
            }

            $result = $this->base_model->eliminar(["iglesias.miembro","idmiembro"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }


    }


    public function get_asociados(Request $request) {

        $sql = "SELECT m.*, (m.pais_id || '|' || p.posee_union) AS pais_id, p.posee_union, vr.nombres AS responsable,
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
        $result = $this->asociados_model->obtener_estado_civil();
        echo json_encode($result);
    }

    public function obtener_nivel_educativo() {
        $result = $this->asociados_model->obtener_nivel_educativo();
        echo json_encode($result);
    }

    public function obtener_profesiones() {
        $result = $this->asociados_model->obtener_profesiones();
        echo json_encode($result);
    }


    public function obtener_profesiones_todos() {
        $array = array("id" => 0, "descripcion" => "Todos");
        $array = (object) $array;
        $sql = "SELECT idocupacion as id, descripcion FROM public.ocupacion ORDER BY descripcion ASC";
        $result = DB::select($sql);
        array_push($result, $array);
        echo json_encode($result);
    }

    public function obtener_periodos_ini() {
        $array = $this->asociados_model->obtener_periodos_ini();

        echo json_encode($array);
    }

    public function obtener_periodos_fin() {
        $array = $this->asociados_model->obtener_periodos_fin();
        echo json_encode($array);
    }


    public function obtener_periodos_fin_dependiente() {
        $result = array();
        $array = array();
        $periodoini = (isset($_REQUEST["periodoini"])) ? $_REQUEST["periodoini"] : "";
        $anio_inicio = date("Y");
        if(isset($_REQUEST["periodoini"])) {
            for($i=$anio_inicio; $i>=$periodoini; $i-- ) {
                $result["id"] = $i;
                $result["descripcion"] = $i;
                array_push($array, $result);
            }

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

        $datos["nombre_secretario"] = (isset($secretario[0]->nombres)) ? $secretario[0]->nombres : "";

        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("asociados.ficha_bautizo", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("ficha_bautizo.pdf"); // ver

    }

    public function guardar_curriculum(Request $request) {
        $result = array();
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


        $sql_parentesco = "SELECT pm.*, p.descripcion AS parentesco, td.descripcion AS tipodoc, pp.descripcion AS pais, gua
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

    public function filtrar_asociados(Request $request) {


        $array_where = array();
        $where = '';
        if($request->input("nombres") != '') {
            array_push($array_where, "(TRIM(m.nombres) || ' ' || TRIM(m.apellidos)) ILIKE '%".$request->input("nombres")."%'");
        }

        if($request->input("idgradoinstruccion") != '') {
            array_push($array_where, 'm.idgradoinstruccion='.$request->input("idgradoinstruccion"));
        }

        if($request->input("idocupacion") != '') {
            array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        }

        if($request->input("idcargo") != '') {
            array_push($array_where, 'cm.idcargo='.$request->input("idcargo"));
        }

        $where = implode(" AND ", $array_where);

        if(!empty($where)) {
            $where = " WHERE {$where} ";
        }
        $funcion = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || CASE WHEN m.idiglesia IS NULL THEN 0 ELSE m.idiglesia END, ".session("idioma_id").", ".session("idioma_id_defecto").")";

        $sql = "SELECT m.idmiembro, (m.nombres || ' ' || m.apellidos) AS nombres, m.nrodoc AS documento, c.descripcion AS cargo, p.pais_descripcion AS pais, {$funcion} AS jerarquia, m.email AS correo, m.telefono, CASE WHEN a.asamblea_descripcion IS NULL THEN '' ELSE a.asamblea_descripcion END AS convocatoria,
        CASE WHEN d.delegado_tipo = 'T' THEN '".traducir("asambleas.titular")."'
        WHEN d.delegado_tipo = 'S' THEN '".traducir("asambleas.suplente")."' ELSE '' END AS delegado FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        INNER JOIN iglesias.paises AS p ON(p.pais_id=m.pais_id)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        LEFT JOIN asambleas.delegados AS d ON(d.idmiembro=m.idmiembro AND d.estado='A')
        LEFT JOIN asambleas.asambleas AS a ON(a.asamblea_id=d.asamblea_id AND a.estado='A')
        {$where}
        ORDER BY m.idmiembro DESC";
        // die($sql);
        $result = DB::select($sql);

        echo json_encode($result);
    }


    public function guardar_asignacion_delegados(Request $request) {
        $_POST["idmiembro"] = explode("|", $_POST["miembros"]);
        $delegado_tipo = $request->input("delegado_tipo");
        $asamblea = explode("|", $_POST["asamblea_id"]);
        $result = array();
        // $_POST["delegado_tipo"] = array();
        // for ($i=0; $i < count($_POST["idmiembro"]); $i++) {
        //    array_push($_POST["delegado_tipo"], $delegado_tipo);
        // }

        // DB::table("asambleas.delegados")->where("asamblea_id", $request->input("asamblea_id"))->delete();
        // $result = $this->base_model->insertar($this->preparar_datos("asambleas.delegados", $_POST, "D"), "D");

        for ($i=0; $i < count($_POST["idmiembro"]); $i++) {
            $array_datos = array();

            // DB::table("asambleas.delegados")->where("asamblea_id", $asamblea[1])->where("idmiembro",$_POST["idmiembro"][$i])->delete();

            DB::table("asambleas.delegados")
            //   ->where("asamblea_id", $asamblea[1])
              ->where("idmiembro", $_POST["idmiembro"][$i])
              ->update(array("estado" => "I"));

            $array_datos["asamblea_id"] = $asamblea[1];
            $array_datos["delegado_tipo"] = $delegado_tipo;
            $array_datos["idmiembro"] = $_POST["idmiembro"][$i];
            $array_datos["delegado_fecha"] = date("Y-m-d H:i:s");


            $result = $this->base_model->insertar($this->preparar_datos("asambleas.delegados", $array_datos));


            // array_push($_POST["delegado_tipo"], $delegado_tipo);
        }
        //  print_R($_POST);
        //  print_r($this->preparar_datos("asambleas.delegados", $_POST, "D"));
        //  exit;

        // $result = $this->base_model->insertar($this->preparar_datos("asambleas.delegados", $_POST, "D"), "D");
        echo json_encode($result);
    }


    public function guardar_delegados(Request $request) {
        if(isset($_POST["posee_seguro"])) {
            $_POST["posee_seguro"] = "S";
        }  else {
            $_POST["posee_seguro"] = "N";
        }

        if(isset($_POST["posee_visa"])) {
            $_POST["posee_visa"] = "S";
        }  else {
            $_POST["posee_visa"] = "N";
        }
        $result = $this->base_model->modificar($this->preparar_datos("iglesias.miembro", $_POST));
        echo json_encode($result);
    }


    public function imprimir_listado_delegados(Request $request) {
        // echo "hola";
        // echo "<pre>";
        // print_r($_REQUEST); exit;

        // if() {


        // }
        $where = " WHERE 1=1 ";

        $select = implode(", ", $request->input("campos"));

        if(isset($_REQUEST["delegados"]) && !empty($_REQUEST["delegados"])) {
            $where = " AND d.idmiembro IN(".str_replace("|",",", $request->input("delegados")).")";
        }


        if(isset($_REQUEST["asamblea_id_impresion"]) && !empty($_REQUEST["asamblea_id_impresion"])) {
            $where .= " AND d.asamblea_id = {$_REQUEST["asamblea_id_impresion"]} ";
        }

        if(isset($_REQUEST["asamblea_id_imprimir"]) && !empty($_REQUEST["asamblea_id_imprimir"])) {
            $array = explode("|", $_REQUEST["asamblea_id_imprimir"]);
            $where .= " AND d.asamblea_id = {$array[1]} ";
        }

        // $funcion = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || m.idiglesia, ".session("idioma_id").", ".session("idioma_id_defecto").")";

        $sql = "SELECT {$select} FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        INNER JOIN iglesias.paises AS p ON(p.pais_id=m.pais_id)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        INNER JOIN asambleas.delegados AS d ON(d.idmiembro=m.idmiembro )
        INNER JOIN asambleas.asambleas AS a ON(a.asamblea_id=d.asamblea_id)
        {$where} AND  d.estado='A' AND a.estado='A'
        ORDER BY m.idmiembro DESC";

        $datos["delegados"] = DB::select($sql);
        if(count($datos["delegados"]) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }

        $datos["nivel_organizativo"] = "";
        //  die($sql);

        $pdf = PDF::loadView("asociados.listado_delegados", $datos)->setPaper('A4', "portrait");

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("listado_delegados.pdf"); // ver

    }

    public function notificar_delegados(Request $request) {
        // print_r($_REQUEST);
        // echo (extension_loaded('openssl')?'SSL loaded':'SSL not loaded')."\n";
        $array = explode("|", $_REQUEST["asamblea_id"]);
        $asamblea_id = $array[1];

        $msg = "";
        $response = array();
        $response["result"] = "";
        $response["msg"] = "";

        $sql = "SELECT  m.*, CASE WHEN d.delegado_tipo = 'T' THEN '".traducir("asambleas.titular")."'
        WHEN d.delegado_tipo = 'S' THEN '".traducir("asambleas.suplente")."' ELSE '' END AS delegado, a.*  FROM iglesias.miembro AS m
        INNER JOIN asambleas.delegados AS d ON(d.idmiembro=m.idmiembro )
        INNER JOIN asambleas.asambleas AS a ON(a.asamblea_id=d.asamblea_id)
        WHERE  d.estado='A' AND a.estado='A' and d.asamblea_id={$asamblea_id}
        ORDER BY m.idmiembro DESC";
    // echo "<pre>";
        $delegados = DB::select($sql);
        // print_r($delegados); exit;

        foreach ($delegados as $key => $value) {
            $email = $value->email;
            if(empty($email)) {
                $email = $value->emailalternativo;

                if(empty($email)) {
                    continue;
                }


            }

            // echo $value->email."<br>";
            $mail = new PHPMailer(true);
            $mail->SMTPOptions = [
                'ssl' => [
                    'verify_peer' => false,
                    'verify_peer_name' => false,
                    'allow_self_signed' => true,
                ]
            ];
            try {
                $mail->SMTPDebug  = SMTP::DEBUG_OFF; // SMTP::DEBUG_OFF: No output, SMTP::DEBUG_SERVER: Client and server messages
                $mail->isSMTP();
                // $mail->Host       = "smtp.gmail.com";
                // $mail->SMTPAuth = true;
                // $mail->Username = "bleonardo.gsinarahua@gmail.com";
                // $mail->Password = "garcia@2004";
                // $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;  // TLS: ENCRYPTION_STARTTLS, SSL: ENCRYPTION_SMTPS
                // $mail->Port = 587

                $mail->Host = 'localhost';
                $mail->SMTPAuth = false;
                $mail->Username = "imssystem@iglesia.solucionesahora.com";
                $mail->Password = "imssystem@1235";
                // $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;  // TLS:

                $mail->Port       = 25; // si no quiere con el puerto 25 poner el puerto 587, al parecer en produccion va el puerto 587 y en desarollo el puerto 25,
                //o sino la mejor opcion es con SMTPSecure='ssl' y el puerto 665

                $mail->setFrom("imssystem@iglesia.solucionesahora.com", utf8_decode(traducir("traductor.titulo_cabecera_2")).utf8_decode(" (Iglesia Adventista del Séptimo Día Movimiento de Reforma)"));
                $mail->addAddress($email, $value->apellidos.", ".$value->nombres);
                $mail->Subject = utf8_decode(traducir("asambleas.notificacion_asignacion_delegados")).utf8_decode(" (Notificación de Asignación de Delegados)");
                $mail->isHTML(true);


                $Contenido = utf8_decode(traducir("asambleas.estimado")).": " . $value->apellidos.", ".$value->nombres .utf8_decode(traducir("asambleas.notifica")).": ".$value->delegado." ".traducir("asambleas.asamblea_convocatoria").": ". utf8_decode($value->asamblea_descripcion);
                $Contenido .= "<br> ".utf8_decode(traducir("asambleas.atentamente")).": ".utf8_decode(traducir("traductor.titulo_cabecera_2")).utf8_decode(" (Iglesia Adventista del Séptimo Día Movimiento de Reforma)")."<br><br><br>";


                $Contenido .= "Estimado: " . $value->apellidos.", ".$value->nombres . " se le notifica que usted ha sido asignado como delegado: ".$value->delegado." de la asamblea/convocatoria: ". utf8_decode($value->asamblea_descripcion);
                $Contenido .= "<br> Atentamente: ".utf8_decode(traducir("traductor.titulo_cabecera_2")).utf8_decode(" (Iglesia Adventista del Séptimo Día Movimiento de Reforma)");

                $mail->Body = $Contenido;



                $mail->send();

            } catch (Exception $e) {
                // echo $e->getMessage()."<br>";
                // echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";

                $response["result"] = "N";
                $msg .= $e->getMessage(). " Message could not be sent. Mailer Error: {$mail->ErrorInfo} \n";



            }

        }
        if($response["result"] == "N") {
            $response["msg"] = $msg;
            echo json_encode($response);

            exit;
        }
        $response["result"] = "S";
        $response["msg"] = "";
        echo json_encode($response);


        // $where .= " AND d.asamblea_id = {$array[1]} ";
    }


    public function imprimir_certificado($idmiembro) {

        $datos = array();
        $sql_miembro = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, CASE WHEN m.sexo='M' THEN 'Masculino' ELSE 'Femenino' END AS sexo, mi.descripcion AS nivel_organizativo,
        d.*, a.*, ".formato_fecha_idioma("a.asamblea_fecha_inicio")." AS asamblea_fecha_inicio, ".formato_fecha_idioma("a.asamblea_fecha_fin")." AS asamblea_fecha_fin, p.descripcion AS pais, tc.*, ".formato_fecha_idioma("d.delegado_fecha")." AS delegado_fecha, pp.descripcion AS pais_ciudadania, ec.descripcion AS estado_civil, to_char(m.fechaingresoiglesia, 'YYYY') AS anio_ingreso, i.descripcion AS iglesia, ".formato_fecha_idioma("m.fecha_emision_pasaporte")." AS fecha_emision_pasaporte, ".formato_fecha_idioma("m.fecha_vencimiento_pasaporte")." AS fecha_vencimiento_pasaporte, CASE WHEN m.fecha_vencimiento_pasaporte < NOW() THEN 'VENCIDO' ELSE 'VIGENTE' END AS estado_pasaporte
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.mision AS mi  ON(m.idmision=mi.idmision)
        INNER JOIN asambleas.delegados AS d ON(d.idmiembro=m.idmiembro)
        INNER JOIN asambleas.asambleas AS a ON(a.asamblea_id=d.asamblea_id)
        INNER JOIN public.pais AS p ON(p.idpais=a.idpais)
        LEFT JOIN public.pais AS pp ON(pp.idpais=m.pais_id_nacimiento)
        LEFT JOIN public.estadocivil AS ec ON(ec.idestadocivil=m.idestadocivil)
        INNER JOIN asambleas.tipo_convocatoria AS tc ON(tc.tipconv_id=a.tipconv_id)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        WHERE m.idmiembro={$idmiembro}";
        $miembro = DB::select($sql_miembro);

        $sql_totales = "SELECT delegado_tipo, COUNT(idmiembro) AS total FROM asambleas.delegados
        WHERE asamblea_id = {$miembro[0]->asamblea_id} AND estado='A'
        GROUP BY delegado_tipo";
        $totales = DB::select($sql_totales);


        $sql_cargos = "SELECT c.descripcion AS cargo, (cm.periodoini || '-' || cm.periodofin) AS anios, cm.lugar, cm.vigente, n.descripcion AS nivel FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(cm.idmiembro=m.idmiembro)
        INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
        INNER JOIN public.nivel AS n ON(cm.idnivel=n.idnivel)
        WHERE m.idmiembro=".$idmiembro."
        ORDER BY cm.idcargomiembro DESC LIMIT 7";
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
        $datos["totales"] = $totales;
        $datos["laboral"] = $laboral;
        $datos["nivel_organizativo"] = $nivel_organizativo;

        $datos["cargos"] = $cargos;
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/

        $pdf = PDF::loadView("asociados.imprimir_certificado", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("certificado.pdf"); // ver
    }


    public function select_init(Request $request) {
        $data["iddivision"] = $this->divisiones_model->obtener_divisiones($request);
        $data["pais_id"] = $this->paises_model->obtener_paises_asociados($request);
        $data["idunion"] = $this->uniones_model->obtener_uniones_paises($request);
        $data["idmision"] = $this->misiones_model->obtener_misiones($request);
        $data["iddistritomisionero"] = $this->distritos_misioneros_model->obtener_distritos_misioneros($request);
        $data["idiglesia"] = $this->iglesias_model->obtener_iglesias($request);

        $data["iddivisioncargo"] = $this->divisiones_model->obtener_divisiones($request);
        $data["pais_idcargo"] = $this->paises_model->obtener_paises_asociados($request);
        $data["idunioncargo"] = $this->uniones_model->obtener_uniones_paises($request);
        $data["idmisioncargo"] = $this->misiones_model->obtener_misiones($request);
        $data["iddistritomisionerocargo"] = $this->distritos_misioneros_model->obtener_distritos_misioneros($request);
        $data["idiglesia"] = $this->iglesias_model->obtener_iglesias($request);

        $data["idmotivobaja"] = $this->principal_model->obtener_motivos_baja();
        $data["pais_id_nacimiento"] = $this->paises_model->obtener_todos_paises();
        $data["pais"] = $this->paises_model->obtener_todos_paises();
        $data["idtipodoc"] = $this->principal_model->obtener_tipos_documento();
        $data["tipodoc"] = $this->principal_model->obtener_tipos_documento();
        $data["idestadocivil"] = $this->asociados_model->obtener_estado_civil();
        $data["idgradoinstruccion"] = $this->asociados_model->obtener_nivel_educativo();
        $data["periodoini"] = $this->asociados_model->obtener_periodos_ini();
        $data["periodofin"] = $this->asociados_model->obtener_periodos_fin();
        $data["perini"] = $this->asociados_model->obtener_periodos_ini();
        $data["perfin"] = $this->asociados_model->obtener_periodos_fin();
        $data["idocupacion"] = $this->asociados_model->obtener_profesiones();
        $data["idreligion"] = $this->principal_model->obtener_religiones();
        $data["idcondicioneclesiastica"] = $this->principal_model->obtener_condicion_eclesiastica();

        $data["idnivel"] = $this->niveles_model->obtener_niveles($request);
        $data["idtipocargo"] = $this->tipos_cargo_model->obtener_tipos_cargo();
        $data["idcargo"] = $this->cargos_model->obtener_cargos($request);

        $data["iddepartamentodomicilio"] = $this->principal_model->obtener_departamentos($request);
        $data["idprovinciadomicilio"] = $this->principal_model->obtener_provincias($request);
        $data["iddistritodomicilio"] = $this->principal_model->obtener_distritos($request);
        $data["parentesco"] = $this->principal_model->obtener_parentesco();
        $data["parentesco"] = $this->principal_model->obtener_parentesco();

        $data["asamblea_id"] = $this->asambleas_model->obtener_asambleas();
        $data["asamblea_id_imprimir"] = $this->asambleas_model->obtener_asambleas();
        $data["asamblea_id_notificar"] = $this->asambleas_model->obtener_asambleas();

        echo json_encode($data);
    }

}
