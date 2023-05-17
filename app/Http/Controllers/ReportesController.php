<?php

namespace App\Http\Controllers;

use App\Exports\AsociadosExport;
use App\Models\ActividadmisioneraModel;
use App\Models\AsociadosModel;
use App\Models\BaseModel;
use App\Models\DistritosmisionerosModel;
use App\Models\DivisionesModel;
use App\Models\IglesiasModel;
use App\Models\MisionesModel;
use App\Models\PaisesModel;
use App\Models\PrincipalModel;
use App\Models\ReportesModel;
use App\Models\UnionesModel;
// use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use PDF;
class ReportesController extends Controller
{
    //
    // private $base_model;
    private $ReportesController_model;
    private $reportes_model;
    private $divisiones_model;
    private $paises_model;
    private $uniones_model;
    private $misiones_model;
    private $distritos_misioneros_model;
    private $iglesias_model;
    private $principal_model;
    private $asociados_model;
    private $actividad_misionera_model;

    public function __construct() {
        parent:: __construct();
        $this->reportes_model = new ReportesModel();
        $this->divisiones_model = new DivisionesModel();
        $this->paises_model = new PaisesModel();
        $this->uniones_model = new UnionesModel();
        $this->misiones_model = new MisionesModel();
        $this->distritos_misioneros_model = new DistritosmisionerosModel();
        $this->iglesias_model = new IglesiasModel();
        $this->principal_model = new PrincipalModel();
        $this->asociados_model = new AsociadosModel();
        $this->actividad_misionera_model = new ActividadmisioneraModel();
        // $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "reportes.general_asociados";
        $data["title"] = traducir("traductor.titulo_general_asociados");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->ReportesController_model->tabla()->HTML();

        // $botones = array();
        // $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-perfil">'.traducir("traductor.nuevo").' [F1]</button>';
        // $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">'.traducir("traductor.eliminar").' [F7]</button>';
        // $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["idiomas.js", "ReportesController.js"]);
        return parent::init($view, $data);


    }

    public function general_asociados() {
        $view = "reportes.general_asociados";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_reporte_general_asociados");
        $data["subtitle"] = "";



        $data["scripts"] = $this->cargar_js(["reporte_general_asociados.js"]);
        return parent::init($view, $data);
    }

    public function grafico_feligresia() {
        $view = "reportes.grafico_feligresia";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_grafico_feligresia");
        $data["subtitle"] = "";



        $data["scripts"] = $this->cargar_js(["grafico_feligresia.js"]);
        return parent::init($view, $data);
    }

    public function miembros_iglesia() {
        $view = "reportes.miembros_iglesia";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_miembros_iglesia");
        $data["subtitle"] = "";



        $data["scripts"] = $this->cargar_js(["miembros_iglesia.js"]);
        return parent::init($view, $data);
    }

    public function oficiales_iglesia() {
        $view = "reportes.oficiales_iglesia";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_reporte_oficiales_iglesia");
        $data["subtitle"] = "";



        $data["scripts"] = $this->cargar_js(["oficiales_iglesia.js"]);
        return parent::init($view, $data);
    }


    public function oficiales_union_asociacion() {
        $view = "reportes.oficiales_union_asociacion";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_reporte_oficiales_union_asociacion");
        $data["subtitle"] = "";

        $data["scripts"] = $this->cargar_js(["oficiales_union_asociacion.js?version=090920210947"]);
        return parent::init($view, $data);
    }

    public function oficiales_union() {
        $view = "reportes.oficiales_union";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_reporte_oficiales_union");
        $data["subtitle"] = "";



        $data["scripts"] = $this->cargar_js(["oficiales_union.js?version=140420230947"]);
        return parent::init($view, $data);
    }

    public function informe_semestral() {
        $view = "reportes.informe_semestral";
        // echo traducir("traductor.titulo_general_asociados");
        // exit;
        $data["title"] = traducir("traductor.titulo_informe_semestral");
        $data["subtitle"] = "";



        $data["scripts"] = $this->cargar_js(["informe_semestral.js"]);
        return parent::init($view, $data);
    }

    public function buscar_datos() {
        $json_data = $this->ReportesController_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }



    // public function get(Request $request) {

    //     $sql = "SELECT * FROM seguridad.ReportesController WHERE perfil_id=".$request->input("id");
    //     $one = DB::select($sql);
    //     echo json_encode($one);
    // }


    public function obtener_iglesias(Request $request) {

        $sql = "";
        $result = array();
		if(isset($_REQUEST["iddistritomisionero"]) && !empty($_REQUEST["iddistritomisionero"])) {

			$sql = "SELECT idiglesia AS id, descripcion FROM iglesias.iglesia
            WHERE iddistritomisionero IS NOT NULL AND estado='1' AND iddistritomisionero=".$request->input("iddistritomisionero");
            $result = DB::select($sql);
		}
        // die($sql);


        echo json_encode($result);
    }

    public function obtener_miembros($request, $fichas = "") {
        $array_where = array();
        $where = '';
        if($request->input("idcondicioneclesiastica") != '') {
            array_push($array_where, 'm.idcondicioneclesiastica='.$request->input("idcondicioneclesiastica"));
        }

        if($request->input("idestadocivil") != '') {
            array_push($array_where, 'm.idestadocivil='.$request->input("idestadocivil"));
        }

        if($request->input("idocupacion") != '' && $request->input("idocupacion") != '0') {
            array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        }


        // if($request->input("idocupacion") != '') {
        //     array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        // }

        if($request->input("estado") != '') {
            array_push($array_where, "m.estado='".$request->input("estado")."'");
        }

        if($request->input("iddivision") != '') {
            array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
        }

        if($request->input("pais_id") != '') {
            $array_pais = explode("|", $request->input("pais_id"));
            array_push($array_where, 'm.pais_id='.$array_pais[0]);

            $_REQUEST["pais_id"] = $array_pais[0];
            if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
                $sql = "SELECT * FROM iglesias.union AS u
                INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                WHERE up.pais_id={$_REQUEST["pais_id"]}";
                $res = DB::select($sql);
                $_REQUEST["idunion"] = $res[0]->idunion;
            }
        }



        if(isset($_REQUEST["idunion"]) && $_REQUEST["idunion"] != '') {
            array_push($array_where, 'm.idunion='.$_REQUEST["idunion"]);
        }

        if($request->input("idmision") != '') {
            array_push($array_where, 'm.idmision='.$request->input("idmision"));
        }

        if($request->input("iddistritomisionero") != '') {
            array_push($array_where, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
        }

        if($fichas == "") {
            $select = implode(", ", $request->input("campos"));
        } else {
            $select = " m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
            gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, ec.descripcion AS estado_civil, CASE WHEN m.sexo='M' THEN '".traducir("traductor.hombre")."' ELSE '".traducir("traductor.mujer")."' END AS sexo, CASE WHEN m.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado ";
        }



        $where = implode(" AND ", $array_where);

        if($request->input("fechaini") != '' && $request->input("fechafin") !=  '') {
            $where .= " AND m.fechabautizo BETWEEN '".$this->FormatoFecha($_REQUEST["fechaini"], "server")."' AND '".$this->FormatoFecha($_REQUEST["fechafin"], "server")."'";
        }

        if($request->input("fechaini") != '' && $request->input("fechafin") ==  '') {
            $where .= " AND m.fechabautizo = '".$this->FormatoFecha($_REQUEST["fechaini"], "server")."'";
        }

        if($request->input("fechaini") == '' && $request->input("fechafin") !=  '') {
            $where .= " AND m.fechabautizo = '".$this->FormatoFecha($_REQUEST["fechafin"], "server")."'";
        }

        if(isset($_REQUEST["iglesias"]) && count($_REQUEST["iglesias"]) > 0) {
            $iglesias = implode(", ", $request->input("iglesias"));
            $where .= ' AND m.idiglesia IN('.$iglesias.')';
        }
        // die($select);
        if(!empty($where)) {
            $where = " WHERE ".$where;
        }
        $sql_miembros = "SELECT ".$select."
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN public.estadocivil AS ec ON(ec.idestadocivil=m.idestadocivil)
        LEFT JOIN iglesias.division AS d ON(d.iddivision=m.iddivision)
        LEFT JOIN iglesias.paises AS p ON(p.pais_id=m.pais_id)
        LEFT JOIN iglesias.union AS u ON(u.idunion=m.idunion)
        LEFT JOIN iglesias.mision AS mm ON(mm.idmision=m.idmision)
        LEFT JOIN iglesias.distritomisionero AS dm ON(dm.iddistritomisionero=m.iddistritomisionero)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        LEFT JOIN iglesias.condicioneclesiastica AS ce ON(ce.idcondicioneclesiastica=m.idcondicioneclesiastica)
        ".$where;
        // die($sql_miembros);
        return DB::select($sql_miembros);
    }

    public function imprimir_general_asociados(Request $request) {
        // echo "hola";
        // print_r($request->input("iddivision"));



        // $array_where = array();
        // $where = '';
        // if($request->input("idcondicioneclesiastica") != '') {
        //     array_push($array_where, 'm.idcondicioneclesiastica='.$request->input("idcondicioneclesiastica"));
        // }

        // if($request->input("idestadocivil") != '') {
        //     array_push($array_where, 'm.idestadocivil='.$request->input("idestadocivil"));
        // }

        // if($request->input("idocupacion") != '') {
        //     array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        // }


        // if($request->input("idocupacion") != '') {
        //     array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        // }

        // if($request->input("estado") != '') {
        //     array_push($array_where, 'm.estado='.$request->input("estado"));
        // }

        // if($request->input("iddivision") != '') {
        //     array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
        // }

        // if($request->input("pais_id") != '') {
        //     $array_pais = explode("|", $request->input("pais_id"));
        //     array_push($array_where, 'm.pais_id='.$array_pais[0]);
        // }

        // if($request->input("idunion") != '') {
        //     array_push($array_where, 'm.idunion='.$request->input("idunion"));
        // }

        // if($request->input("idmision") != '') {
        //     array_push($array_where, 'm.idmision='.$request->input("idmision"));
        // }

        // if($request->input("iddistritomisionero") != '') {
        //     array_push($array_where, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
        // }

        // $select = implode(", ", $request->input("campos"));


        // $where = implode(" AND ", $array_where);

        // if($request->input("fechaini") != '' && $request->input("fechafin") !=  '') {
        //     $where .= " AND m.fechabautizo BETWEEN '".$this->FormatoFecha($_REQUEST["fechaini"], "server")."' AND '".$this->FormatoFecha($_REQUEST["fechafin"], "server")."'";
        // }

        // if($request->input("fechaini") != '' && $request->input("fechafin") ==  '') {
        //     $where .= " AND m.fechabautizo = '".$this->FormatoFecha($_REQUEST["fechaini"], "server")."'";
        // }

        // if($request->input("fechaini") == '' && $request->input("fechafin") !=  '') {
        //     $where .= " AND m.fechabautizo = '".$this->FormatoFecha($_REQUEST["fechafin"], "server")."'";
        // }

        // if(isset($_REQUEST["iglesias"]) && count($_REQUEST["iglesias"]) > 0) {
        //     $iglesias = implode(", ", $request->input("iglesias"));
        //     $where .= ' AND m.idiglesia IN('.$iglesias.')';
        // }
        // // die($select);

        // $sql_miembros = "SELECT ".$select."
        // FROM iglesias.miembro AS m
        // LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        // LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        // LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        // LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        // LEFT JOIN public.estadocivil AS ec ON(ec.idestadocivil=m.idestadocivil)
        // LEFT JOIN iglesias.division AS d ON(d.iddivision=m.iddivision)
        // LEFT JOIN iglesias.paises AS p ON(p.pais_id=m.pais_id)
        // LEFT JOIN iglesias.union AS u ON(u.idunion=m.idunion)
        // LEFT JOIN iglesias.mision AS mm ON(mm.idmision=m.idmision)
        // LEFT JOIN iglesias.distritomisionero AS dm ON(dm.iddistritomisionero=m.iddistritomisionero)
        // LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        // LEFT JOIN iglesias.condicioneclesiastica AS ce ON(ce.idcondicioneclesiastica=m.idcondicioneclesiastica)
        // WHERE ".$where;
        // // die($sql_miembros);
        // $miembros = DB::select($sql_miembros);
        $miembros = $this->obtener_miembros($request, "");
        if(count($miembros) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }


        $datos["miembros"] = $miembros;
        // print_r($miembros[0]); exit;
        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["formato"] = $request->input("formato");
        // echo "<pre>";
        // print_r($miembros); exit;
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/

        // $pdf = PDF::loadView("reportes.imprimir_general_asociados", $datos)->setPaper('A4', $request->input("formato"));

        // // return $pdf->save("ficha_asociado.pdf"); // guardar
        // // return $pdf->download("ficha_asociado.pdf"); // descargar
        // return $pdf->stream("reporte_general_asociados.pdf"); // ver
        $view = "reportes.imprimir_general_asociados";
        return parent::init($view, $datos);
    }



    public function imprimir_fichas_asociados(Request $request) {
        // echo "hola";
        // print_r($request->input("iddivision"));


        $miembros = $this->obtener_miembros($request, "fichas");

        if(count($miembros) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }
        $sql_estado_civil = "SELECT * FROM public.estadocivil";
        $estado_civil = DB::select($sql_estado_civil);
        // $sql_motivos_baja = "SELECT * FROM iglesias.motivobaja";
        // $motivos_baja = DB::select($sql_motivos_baja);

        foreach ($miembros as $km => $vm) {
            $sql_baja = "SELECT h.*, ".formato_fecha_idioma("h.fecha")." AS fecha, mb.descripcion AS motivo_baja
            FROM iglesias.historial_altasybajas AS h
            INNER JOIN iglesias.motivobaja AS mb ON(mb.idmotivobaja=h.idmotivobaja)
            WHERE h.idmiembro=".$vm->idmiembro."
            ORDER BY h.fecha DESC";
            $miembros[$km]->bajas = DB::select($sql_baja);



            $sql_cargos = "SELECT c.descripcion AS cargo, cm.periodoini, cm.periodofin, cm.lugar FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(cm.idmiembro=m.idmiembro)
            INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
            WHERE m.idmiembro=".$vm->idmiembro;

            $miembros[$km]->cargos = DB::select($sql_cargos);


            $sql_control = "SELECT ".formato_fecha_idioma("ct.fecha")." AS fecha_aceptacion, ".formato_fecha_idioma("ht.fecha")." AS fecha_aceptacion_local FROM iglesias.control_traslados AS ct
            INNER JOIN iglesias.historial_traslados AS ht ON(ct.idcontrol=ht.idcontrol)
            WHERE estado='0' AND ht.idmiembro=".$vm->idmiembro."
            ORDER BY ct.idcontrol DESC";
            $control = DB::select($sql_control);
            $miembros[$km]->fecha_aceptacion = (isset($control[0]->fecha_aceptacion)) ? $control[0]->fecha_aceptacion : "";
            $miembros[$km]->fecha_aceptacion_local = (isset($control[0]->fecha_aceptacion_local)) ? $control[0]->fecha_aceptacion_local : "";

        }




        $datos["estado_civil"] = $estado_civil;
        // $datos["baja"] = $baja;
        // $datos["motivos_baja"] = $motivos_baja;

        // $datos["cargos"] = $cargos;
        $datos["miembros"] = $miembros;
        // print_r($miembros[0]); exit;
        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);


        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/

        $pdf = PDF::loadView("reportes.fichas", $datos)->setPaper('A4', "portrait");

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("fichas_asociados.pdf"); // ver
    }

    public function exportar_excel_general_asociados(Request $request) {
        $miembros = $this->obtener_miembros($request, "");

        if(count($miembros) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }
        // echo '<script>window.close();</script>';
        return Excel::download(new AsociadosExport, 'reporte_general_asociados.xlsx');

    }

    public function obtener_feligresia(Request $request) {
        $array_where = array();
        $where = "";
        if($request->input("iddivision") != '-1') {
            array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
        }

        if($request->input("pais_id") != '-1') {
            $array_pais = explode("|", $request->input("pais_id"));
            array_push($array_where, 'm.pais_id='.$array_pais[0]);


            $_REQUEST["pais_id"] = $array_pais[0];
            if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
                $sql = "SELECT * FROM iglesias.union AS u
                INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                WHERE up.pais_id={$_REQUEST["pais_id"]}";
                $res = DB::select($sql);
                $_REQUEST["idunion"] = $res[0]->idunion;
            }
        }


        if($_REQUEST["idunion"] != '-1') {
            array_push($array_where, 'm.idunion='.$_REQUEST["idunion"]);
        }

        if($request->input("idmision") != '-1') {
            array_push($array_where, 'm.idmision='.$request->input("idmision"));
        }

        if($request->input("iddistritomisionero") != '-1') {
            array_push($array_where, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
        }

        if($request->input("idiglesia") != '-1') {
            array_push($array_where, 'm.idiglesia='.$request->input("idiglesia"));
        }

        if(count($array_where) > 0 ) {
            $where .= " AND ".implode(" AND ", $array_where);
        }


        $sql = "SELECT *
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.condicioneclesiastica AS ce ON(ce.idcondicioneclesiastica=m.idcondicioneclesiastica)
        WHERE m.estado='1' ".$where;
        // die($sql);
        $total = DB::select($sql);
        $total = count($total);


        $sql = "SELECT (COUNT(m.idmiembro)* 100 / ".$total.") AS y, (COUNT(m.idmiembro) || '-' || (CASE WHEN ce.descripcion <> 'Bautizado' THEN  'Escuela Sabática' ELSE ce.descripcion  END)) AS name
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.condicioneclesiastica AS ce ON(ce.idcondicioneclesiastica=m.idcondicioneclesiastica)
        WHERE m.estado='1' ".$where."
        GROUP BY ce.descripcion ";
        //die($sql);
        $data = DB::select($sql);
        echo json_encode($data);

    }

    public function imprimir_miembros_iglesia(Request $request) {
        $datos = array();
        $array_where = array();
        $where = "";
        $array_where_secretario = array();
        if($request->input("iddivision") != '') {
            array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
            array_push($array_where_secretario, 'm.iddivision='.$request->input("iddivision"));
        }

        if($request->input("pais_id") != '') {
            // $array_pais = explode("|", $request->input("pais_id"));
            $array_pais = explode("|", $_REQUEST["pais_id"]);
            $_REQUEST["pais_id"] = $array_pais[0];
            if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
                $sql = "SELECT * FROM iglesias.union AS u
                INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
                WHERE up.pais_id={$_REQUEST["pais_id"]}";
                $res = DB::select($sql);
                $_REQUEST["idunion"] = $res[0]->idunion;
            }
            array_push($array_where, 'm.pais_id='.$array_pais[0]);
            array_push($array_where_secretario, 'm.pais_id='.$array_pais[0]);
        }

        if(isset($_REQUEST["idunion"]) && $_REQUEST["idunion"] != '') {
            array_push($array_where, 'm.idunion='.$_REQUEST["idunion"]);
            array_push($array_where_secretario, 'm.idunion='.$_REQUEST["idunion"]);
        }

        if($request->input("idmision") != '') {
            array_push($array_where, 'm.idmision='.$request->input("idmision"));
            array_push($array_where_secretario, 'm.idmision='.$request->input("idmision"));
        }

        if($request->input("iddistritomisionero") != '') {
            array_push($array_where, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
            array_push($array_where_secretario, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
        }

        if($request->input("idiglesia") != '') {
            array_push($array_where, 'm.idiglesia='.$request->input("idiglesia"));
            array_push($array_where_secretario, 'm.idiglesia='.$request->input("idiglesia"));
        }

        if($request->input("idcondicioneclesiastica_all") != '' && $request->input("idcondicioneclesiastica_all") != '-1') {
            array_push($array_where, 'm.idcondicioneclesiastica='.$request->input("idcondicioneclesiastica_all"));
        }

        if(count($array_where) > 0 ) {
            $where .= "WHERE ".implode(" AND ", $array_where);
        } else {
            $where .= "";
        }


        $datos = array();
        $sql_miembros = "SELECT m.*, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, ".formato_fecha_idioma("m.fechabautizo")." AS fechabautizo, vr.nombres AS bautizador, i.descripcion AS iglesia, CASE WHEN m.idcondicioneclesiastica=1 THEN 'Bautismo' ELSE '-.-' END AS condicion
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        ".$where;
        // die($sql_miembros);
        $miembros = DB::select($sql_miembros);

        if(count($miembros) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }

        $where_secretario = "";
        if(count($array_where_secretario) > 0 ) {
            $where_secretario .= " AND  ".implode(" AND ", $array_where_secretario);
        }

        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=6 ".$where_secretario;
        $secretario = DB::select($sql_secretario);


        foreach ($miembros as $km => $vm) {
            $sql_baja = "SELECT h.*, ".formato_fecha_idioma("h.fecha")." AS fecha, mb.descripcion AS motivo_baja, mb.idmotivobaja
            FROM iglesias.historial_altasybajas AS h
            INNER JOIN iglesias.motivobaja AS mb ON(mb.idmotivobaja=h.idmotivobaja)
            WHERE h.idmiembro=".$vm->idmiembro."
            ORDER BY h.fecha DESC";
            $miembros[$km]->bajas = DB::select($sql_baja);

            $sql_control = "SELECT ".formato_fecha_idioma("ct.fecha")." AS fecha_aceptacion, ".formato_fecha_idioma("ht.fecha")." AS fecha_aceptacion_local FROM iglesias.control_traslados AS ct
            INNER JOIN iglesias.historial_traslados AS ht ON(ct.idcontrol=ht.idcontrol)
            WHERE estado='0' AND ht.idmiembro=".$vm->idmiembro."
            ORDER BY ct.idcontrol DESC";

            $miembros[$km]->control = DB::select($sql_control);

        }

        $sql_motivos_baja = "SELECT * FROM iglesias.motivobaja";
        $motivos_baja = DB::select($sql_motivos_baja);

        $datos["motivos_baja"] = $motivos_baja;

        $datos["miembros"] = $miembros;
        $datos["nombre_secretario"] = (isset($secretario[0]->nombres))  ? $secretario[0]->nombres : "";

        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);


        $pdf = PDF::loadView("reportes.imprimir_miembros_iglesia", $datos)->setPaper('A4', "portrait");



        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("miembros_iglesia.pdf"); // ver

    }

    public function imprimir_oficiales_iglesia(Request $request) {
        $datos = array();

        // echo round(9 / 2); exit;
        $where = "";
        // if(isset($_REQUEST["idiglesia"]) && !empty($_REQUEST["idiglesia"])) {
        //     $where = " AND cm.idlugar=".$request->input("idiglesia");
        // }

        if(isset($_REQUEST["idiglesia"]) && !empty($_REQUEST["idiglesia"])) {
            $where = " AND e.idiglesia=".$request->input("idiglesia");
        }
        $anio = $request->input("anio");

        $sql_eleccion = "SELECT * FROM iglesias.eleccion AS e
        INNER JOIN iglesias.eleccion_oficiales AS eo ON(e.ideleccion=eo.ideleccion)
        WHERE e.tipo='I' AND {$anio} BETWEEN e.periodoini AND e.periodofin {$where}";
        $eleccion = DB::select($sql_eleccion);

        if(count($eleccion) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }
        $ideleccion = $eleccion[0]->ideleccion;

        $sql_director = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=5 ";
        // die($sql_director);
        $director = DB::select($sql_director);


        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=6 ";
        $secretario = DB::select($sql_secretario);


        $sql_tesorero = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=7 ";
        // die($sql_tesorero);
        $tesorero = DB::select($sql_tesorero);

        $sql_diacono = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=64 ";
        $diacono = DB::select($sql_diacono);


        $sql_director_escuela_sabatica = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=65 ";
        $director_escuela_sabatica = DB::select($sql_director_escuela_sabatica);


        $sql_director_obra_misionera = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=20 ";
        $director_obra_misionera = DB::select($sql_director_obra_misionera);

        $sql_director_jovenes = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=66 ";
        $director_jovenes = DB::select($sql_director_jovenes);


        $sql_comite = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo=67 ";
        $comite = DB::select($sql_comite);

        $sql_otros = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    INNER JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    INNER JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo NOT IN(5, 6, 7, 20, 64, 65, 66, 67) ";
        // die($sql_otros);
        $otros = DB::select($sql_otros);


        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["anio"] = $anio;
        $datos["director"] = $director;
        $datos["secretario"] = $secretario;
        $datos["tesorero"] = $tesorero;
        $datos["diacono"] = $diacono;
        $datos["otros"] = $otros;
        $datos["director_escuela_sabatica"] = $director_escuela_sabatica;
        $datos["director_obra_misionera"] = $director_obra_misionera;
        $datos["director_jovenes"] = $director_jovenes;
        $datos["comite"] = $comite;

        $pdf = PDF::loadView("reportes.imprimir_oficiales_iglesia", $datos)->setPaper('A4', "portrait");
        return $pdf->stream("oficiales_iglesia.pdf"); // ver
    }


    public function imprimir_oficiales_union_asociacion(Request $request) {
        $datos = array();
        // echo "<pre>";
        //  print_r($_REQUEST); exit;
        // echo round(9 / 2); exit;
        $periodoini = $request->input("periodoini");
        $periodofin = $request->input("periodofin");

        $sql_eleccion = "SELECT e.*, CASE WHEN e.tiporeunion='O' THEN '".traducir("traductor.reunion_ordinaria")."' ELSE '".traducir("traductor.reunion_extraordinaria")."' END AS tiporeunion FROM iglesias.eleccion AS e
        INNER JOIN iglesias.eleccion_oficiales AS eo ON(e.ideleccion=eo.ideleccion)
        WHERE e.tipo='A' AND e.periodoini={$periodoini} AND e.periodofin={$periodofin}";
        // die($sql_eleccion);
        $eleccion = DB::select($sql_eleccion);

        if(count($eleccion) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }
        $ideleccion = $eleccion[0]->ideleccion;

        $array_pais = explode("|", $_REQUEST["pais_id"]);
        $_REQUEST["pais_id"] = $array_pais[0];
        if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }


        $idunion = $_REQUEST["idunion"];
        $idmision = $request->input("idmision");
        $idlugar = $idunion;

        $presidente_id = 59;
        $vicepresidente_id = 60;
        $secretario_id = 61;
        $tesorero_id = 62;
        $colportaje_id = 19;
        $obra_id = 71;
        $jovenes_id = 26;
        $director_editorial_id = 73;
        $nombre_editorial_id = 75;
        $dorca_id = 77;
        $salud_id = 21;
        $educacion_id = 24;
        $auditor_id_1 = 80;
        $auditor_id_2 = 97;
        $comite_union_asociacion_id = 82;
        $comite_ejecutivo_id = 84;
        $comite_finanzas_id = 86;
        $comite_literario_id = 88;
        $comite_salud_id = 90;
        $delegado_id = 92;
        $delegado_subs_id = 94;
        $tabla = "iglesias.union";
        $idlugar = $idunion;
        $nombre = "Unión";
        $asociaciones = "";
        $array = array();
        $sql_misiones = "SELECT * FROM iglesias.mision WHERE idunion={$idunion}";
        $misiones = DB::select($sql_misiones);

        foreach ($misiones as $key => $value) {
            array_push($array, $value->descripcion);
        }

        $asociaciones = implode(", ", $array);

        $sql_sede = "SELECT * FROM iglesias.union WHERE idunion={$idunion}";
        if($idmision != "") {
            $asociaciones = "";
            $presidente_id = 69;
            $vicepresidente_id = 98;
            $secretario_id = 99;
            $tesorero_id = 100;
            $colportaje_id = 70;
            $obra_id = 72;
            $jovenes_id = 14;
            $director_editorial_id = 74;
            $nombre_editorial_id = 76;
            $dorca_id = 78;
            $salud_id = 13;
            $educacion_id = 79;
            $auditor_id_1 = 96;
            $auditor_id_2 = 81;
            $comite_union_asociacion_id = 83;
            $comite_ejecutivo_id = 85;
            $comite_finanzas_id = 87;
            $comite_literario_id = 89;
            $comite_salud_id = 91;
            $delegado_id = 93;
            $delegado_subs_id = 95;
            $tabla = "iglesias.mision";
            $idlugar = $idmision;
            $nombre = "Asociación";
            $sql_sede = "SELECT * FROM iglesias.mision WHERE idmision={$idmision}";
        }

        $sede = DB::select($sql_sede);

        $sql_presidente = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$presidente_id}";

        $presidente = DB::select($sql_presidente);


        $sql_vicepresidente = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$vicepresidente_id}";
        $vicepresidente = DB::select($sql_vicepresidente);


        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$secretario_id}";
        // die($sql_secretario);
        $secretario = DB::select($sql_secretario);

        $sql_tesorero = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$tesorero_id}";
        $tesorero = DB::select($sql_tesorero);


        $sql_colportaje = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$colportaje_id}";
        $colportaje = DB::select($sql_colportaje);

        $sql_obra = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$obra_id}";
        $obra = DB::select($sql_obra);


        $sql_jovenes = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$jovenes_id}";
        $jovenes = DB::select($sql_jovenes);

        $sql_director_editorial = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$director_editorial_id}";
        // die($sql_director_editorial);
        $director_editorial = DB::select($sql_director_editorial);


        $sql_nombre_editorial = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$nombre_editorial_id}";
        $nombre_editorial = DB::select($sql_nombre_editorial);


        $sql_dorca = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$dorca_id}";
        $dorca = DB::select($sql_dorca);

        $sql_salud = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$salud_id}";
        $salud = DB::select($sql_salud);


        $sql_educacion = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$educacion_id}";
        $educacion = DB::select($sql_educacion);


        $sql_auditor_1 = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$auditor_id_1}";
        // die($sql_auditor_1);
        $auditor_1 = DB::select($sql_auditor_1);

        $sql_auditor_2 = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$auditor_id_2}";
        $auditor_2 = DB::select($sql_auditor_2);

        $sql_comite_union_asociacion = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_union_asociacion_id}";
        $comite_union_asociacion = DB::select($sql_comite_union_asociacion);


        $sql_comite_ejecutivo = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_ejecutivo_id}";
        $comite_ejecutivo = DB::select($sql_comite_ejecutivo);


        $sql_comite_finanzas = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_finanzas_id}";
        $comite_finanzas = DB::select($sql_comite_finanzas);


        $sql_comite_literario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_literario_id}";
        $comite_literario = DB::select($sql_comite_literario);


        $sql_comite_salud = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_salud_id}";
        $comite_salud = DB::select($sql_comite_salud);

        $sql_delegado = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$delegado_id}";
        $delegado = DB::select($sql_delegado);

        $sql_delegado_subs = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
	    LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$delegado_subs_id}";
        $delegado_subs = DB::select($sql_delegado_subs);


        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["nombre"] = $nombre;
        $datos["periodoini"] = $periodoini;
        $datos["periodofin"] = $periodofin;
        $datos["presidente"] = $presidente;
        $datos["vicepresidente"] = $vicepresidente;
        $datos["secretario"] = $secretario;
        $datos["tesorero"] = $tesorero;
        $datos["colportaje"] = $colportaje;
        $datos["obra"] = $obra;
        $datos["jovenes"] = $jovenes;
        $datos["director_editorial"] = $director_editorial;
        $datos["nombre_editorial"] = $nombre_editorial;
        $datos["dorca"] = $dorca;
        $datos["salud"] = $salud;
        $datos["educacion"] = $educacion;
        $datos["auditor_1"] = $auditor_1;
        $datos["auditor_2"] = $auditor_2;
        $datos["comite_union_asociacion"] = $comite_union_asociacion;
        $datos["comite_ejecutivo"] = $comite_ejecutivo;
        $datos["comite_finanzas"] = $comite_finanzas;
        $datos["comite_literario"] = $comite_literario;
        $datos["comite_salud"] = $comite_salud;
        $datos["delegado"] = $delegado;
        $datos["delegado_subs"] = $delegado_subs;
        $datos["lugar"] = $request->input("lugar");
        $datos["sede"] = $sede;
        $datos["eleccion"] = $eleccion;
        $datos["asociaciones"] = $asociaciones;



        $pdf = PDF::loadView("reportes.imprimir_oficiales_union_asociacion", $datos)->setPaper('A4', "portrait");
        return $pdf->stream("oficiales_iglesia.pdf"); // ver
    }

    public function imprimir_oficiales_union(Request $request) {
        $datos = array();

        $periodoini = $request->input("periodoini");
        $periodofin = $request->input("periodofin");


        $sql_eleccion = "SELECT e.*, CASE WHEN e.tiporeunion='O' THEN '".traducir("traductor.reunion_ordinaria")."' ELSE '".traducir("traductor.reunion_extraordinaria")."' END AS tiporeunion FROM iglesias.eleccion AS e
        INNER JOIN iglesias.eleccion_oficiales AS eo ON(e.ideleccion=eo.ideleccion)
        WHERE e.tipo='U' AND e.periodoini={$periodoini} AND e.periodofin={$periodofin}";
        // die($sql_eleccion);
        $eleccion = DB::select($sql_eleccion);

        if(count($eleccion) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }
        $ideleccion = $eleccion[0]->ideleccion;

        $array_pais = explode("|", $_REQUEST["pais_id"]);
        $_REQUEST["pais_id"] = $array_pais[0];
        if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }


        $idunion = $_REQUEST["idunion"];

        $idlugar = $idunion;

        $presidente_id = 59;
        $vicepresidente_id = 60;
        $secretario_id = 61;
        $tesorero_id = 62;
        $colportaje_id = 19;
        $obra_id = 71;
        $jovenes_id = 26;
        $director_editorial_id = 73;
        $nombre_editorial_id = 75;
        $dorca_id = 77;
        $salud_id = 21;
        $educacion_id = 24;
        $auditor_id_1 = 80;
        $auditor_id_2 = 97;
        $comite_union_asociacion_id = 82;
        $comite_ejecutivo_id = 84;
        $comite_finanzas_id = 86;
        $comite_literario_id = 88;
        $comite_salud_id = 90;
        $delegado_id = 92;
        $delegado_subs_id = 94;
        $tabla = "iglesias.union";
        $idlugar = $idunion;
        $nombre = "Unión";
        $asociaciones = "";
        $array = array();
        $sql_misiones = "SELECT * FROM iglesias.mision WHERE idunion={$idunion}";
        $misiones = DB::select($sql_misiones);

        foreach ($misiones as $key => $value) {
            array_push($array, $value->descripcion);
        }

        $asociaciones = implode(", ", $array);

        $sql_sede = "SELECT * FROM iglesias.union WHERE idunion={$idunion}";


        $sede = DB::select($sql_sede);

        $sql_presidente = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)

        WHERE c.idcargo={$presidente_id}";


        $presidente = DB::select($sql_presidente);


        $sql_vicepresidente = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$vicepresidente_id}";
        $vicepresidente = DB::select($sql_vicepresidente);


        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$secretario_id}";
        // die($sql_secretario);
        $secretario = DB::select($sql_secretario);

        $sql_tesorero = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$tesorero_id}";
        $tesorero = DB::select($sql_tesorero);


        $sql_colportaje = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$colportaje_id}";
        $colportaje = DB::select($sql_colportaje);

        $sql_obra = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$obra_id}";
        $obra = DB::select($sql_obra);


        $sql_jovenes = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$jovenes_id}";
        $jovenes = DB::select($sql_jovenes);

        $sql_director_editorial = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$director_editorial_id}";
        // die($sql_director_editorial);
        $director_editorial = DB::select($sql_director_editorial);


        $sql_nombre_editorial = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$nombre_editorial_id}";
        $nombre_editorial = DB::select($sql_nombre_editorial);


        $sql_dorca = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$dorca_id}";
        $dorca = DB::select($sql_dorca);

        $sql_salud = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$salud_id}";
        $salud = DB::select($sql_salud);


        $sql_educacion = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$educacion_id}";
        $educacion = DB::select($sql_educacion);


        $sql_auditor_1 = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$auditor_id_1}";
        // die($sql_auditor_1);
        $auditor_1 = DB::select($sql_auditor_1);

        $sql_auditor_2 = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$auditor_id_2}";
        $auditor_2 = DB::select($sql_auditor_2);

        $sql_comite_union_asociacion = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_union_asociacion_id}";
        $comite_union_asociacion = DB::select($sql_comite_union_asociacion);


        $sql_comite_ejecutivo = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_ejecutivo_id}";
        $comite_ejecutivo = DB::select($sql_comite_ejecutivo);


        $sql_comite_finanzas = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_finanzas_id}";
        $comite_finanzas = DB::select($sql_comite_finanzas);


        $sql_comite_literario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_literario_id}";
        $comite_literario = DB::select($sql_comite_literario);


        $sql_comite_salud = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$comite_salud_id}";
        $comite_salud = DB::select($sql_comite_salud);

        $sql_delegado = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$delegado_id}";
        $delegado = DB::select($sql_delegado);

        $sql_delegado_subs = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres, m.direccion, ".formato_fecha_idioma("m.fechanacimiento")." AS fechanacimiento, m.celular, m.telefono, m.email, c.descripcion AS cargo
        FROM public.cargo AS c
        LEFT JOIN iglesias.eleccion_oficiales AS eo ON(c.idcargo=eo.idcargo AND eo.ideleccion={$ideleccion})
	    LEFT JOIN iglesias.miembro AS m ON (m.idmiembro = eo.idmiembro)
        WHERE c.idcargo={$delegado_subs_id}";
        $delegado_subs = DB::select($sql_delegado_subs);





        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["nombre"] = $nombre;
        $datos["periodoini"] = $periodoini;
        $datos["periodofin"] = $periodofin;
        $datos["presidente"] = $presidente;
        $datos["vicepresidente"] = $vicepresidente;
        $datos["secretario"] = $secretario;
        $datos["tesorero"] = $tesorero;
        $datos["colportaje"] = $colportaje;
        $datos["obra"] = $obra;
        $datos["jovenes"] = $jovenes;
        $datos["director_editorial"] = $director_editorial;
        $datos["nombre_editorial"] = $nombre_editorial;
        $datos["dorca"] = $dorca;
        $datos["salud"] = $salud;
        $datos["educacion"] = $educacion;
        $datos["auditor_1"] = $auditor_1;
        $datos["auditor_2"] = $auditor_2;
        $datos["comite_union_asociacion"] = $comite_union_asociacion;
        $datos["comite_ejecutivo"] = $comite_ejecutivo;
        $datos["comite_finanzas"] = $comite_finanzas;
        $datos["comite_literario"] = $comite_literario;
        $datos["comite_salud"] = $comite_salud;
        $datos["delegado"] = $delegado;
        $datos["delegado_subs"] = $delegado_subs;
        $datos["lugar"] = $request->input("lugar");
        $datos["sede"] = $sede;
        $datos["eleccion"] = $eleccion;
        $datos["asociaciones"] = $asociaciones;



        $pdf = PDF::loadView("reportes.imprimir_oficiales_union", $datos)->setPaper('A4', "portrait");
        return $pdf->stream("oficiales_iglesia.pdf"); // ver
    }

    public function imprimir_informe_semestral(Request $request) {
        $datos = array();
        // echo "<pre>";
        // print_r($_REQUEST); exit;
        $anio = $request->input("anio");

        $array_pais = explode("|", $_REQUEST["pais_id"]);
        $_REQUEST["pais_id"] = $array_pais[0];
        if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

        $idunion = $_REQUEST["idunion"];
        $where = "";




        switch ($_REQUEST["semestre"]) {
            case 1:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-01-01' AND '".$anio."-06-30'";
                $fecha_inicial = "'".$anio."-01-01'";
                $fecha_final = "'".$anio."-06-30'";
                $fecha_inicial_anterior = "'".($anio - 1)."-07-01'";
                $fecha_final_anterior = "'".($anio - 1)."-12-31'";
                break;
            case 2:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-07-01' AND '".$anio."-12-31'";
                $fecha_inicial = "'".$anio."-07-01'";
                $fecha_final = "'".$anio."-12-31'";

                $fecha_inicial_anterior = "'".($anio - 1)."-01-01'";
                $fecha_final_anterior = "'".($anio - 1)."-06-30'";
                break;

        }

        $sql_misiones = "SELECT * FROM iglesias.mision WHERE idunion={$idunion} AND estado='1'";
        $misiones = DB::select($sql_misiones);

        if(count($misiones) <= 0) {
            echo '<script>alert("'.traducir("traductor.no_hay_datos").'"); window.close();</script>';
            exit;
        }

        foreach ($misiones as $key => $value) {
            $iglesias = DB::select("SELECT COUNT(*) AS iglesias FROM iglesias.iglesia WHERE estado='1' AND idmision={$value->idmision}");
            $misiones[$key]->iglesias = (isset($iglesias[0]->iglesias)) ? $iglesias[0]->iglesias : 0;

            $feligresia_anterior = DB::select("SELECT COUNT(*) AS miembros FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND fechaingresoiglesia BETWEEN {$fecha_inicial_anterior} AND {$fecha_final_anterior}");

            $misiones[$key]->feligresia_anterior = (isset($feligresia_anterior[0]->miembros)) ? $feligresia_anterior[0]->miembros : 0;



            $bautismos = DB::select("SELECT COUNT(*) AS bautismos FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=1 AND fechabautizo BETWEEN  {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->bautismos = (isset($bautismos[0]->bautismos)) ? $bautismos[0]->bautismos : 0;

            $misiones[$key]->recibimientos = 0;

            $traslados_positivos = DB::select("
            SELECT COUNT(*) AS traslados_positivos
            FROM iglesias.miembro AS m
            INNER JOIN iglesias.historial_traslados AS ht ON(ht.idmiembro=m.idmiembro)
            INNER JOIN iglesias.control_traslados AS ct ON(ct.idcontrol=ht.idcontrol)
            WHERE m.estado='1' AND ct.idmisionactual={$value->idmision} AND ht.fecha BETWEEN  {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->traslados_positivos = (isset($traslados_positivos[0]->traslados_positivos)) ? $traslados_positivos[0]->traslados_positivos : 0;



            $muertes = DB::select("
            SELECT COUNT(*) AS muertes
            FROM iglesias.miembro AS m
            INNER JOIN iglesias.historial_altasybajas AS hab ON(hab.idmiembro=m.idmiembro)

            WHERE m.idmision={$value->idmision} AND hab.fecha BETWEEN {$fecha_inicial} AND {$fecha_final} AND hab.idmotivobaja=4");

            $misiones[$key]->muertes = (isset($muertes[0]->muertes)) ? $muertes[0]->muertes : 0;


            $renuncias = DB::select("
            SELECT COUNT(*) AS renuncias
            FROM iglesias.miembro AS m
            INNER JOIN iglesias.historial_altasybajas AS hab ON(hab.idmiembro=m.idmiembro)

            WHERE m.idmision={$value->idmision} AND hab.fecha BETWEEN {$fecha_inicial} AND {$fecha_final} AND hab.idmotivobaja=6");

            $misiones[$key]->renuncias = (isset($renuncias[0]->renuncias)) ? $renuncias[0]->renuncias : 0;


            $exclusiones = DB::select("
            SELECT COUNT(*) AS exclusiones
            FROM iglesias.miembro AS m
            INNER JOIN iglesias.historial_altasybajas AS hab ON(hab.idmiembro=m.idmiembro)

            WHERE m.idmision={$value->idmision} AND hab.fecha BETWEEN {$fecha_inicial} AND {$fecha_final} AND hab.idmotivobaja=3");

            $misiones[$key]->exclusiones = (isset($exclusiones[0]->exclusiones)) ? $exclusiones[0]->exclusiones : 0;

            $traslados_negativos = DB::select("
            SELECT COUNT(*) AS traslados_negativos
            FROM iglesias.miembro AS m
            INNER JOIN iglesias.historial_traslados AS ht ON(ht.idmiembro=m.idmiembro)
            INNER JOIN iglesias.control_traslados AS ct ON(ct.idcontrol=ht.idcontrol)
            WHERE m.estado='1' AND ct.idmisionactual={$value->idmision} AND ht.fecha BETWEEN  {$fecha_inicial} AND {$fecha_final} AND ct.estado='2'");

            $misiones[$key]->traslados_negativos = (isset($traslados_negativos[0]->traslados_negativos)) ? $traslados_negativos[0]->traslados_negativos : 0;

            $feligresia_actual = DB::select("SELECT COUNT(*) AS miembros FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=1"); // feligresia actual es solo bautizados

            $misiones[$key]->feligresia_actual = (isset($feligresia_actual[0]->miembros)) ? $feligresia_actual[0]->miembros : 0;

            $almas_interesadas = DB::select("SELECT COUNT(*) AS almas_interesadas FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=0 AND fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final}");
            // die("SELECT COUNT(*) AS almas_interesadas FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=0 AND fechaingresoiglesia BETWEEN  {$fecha_inicial} AND {$fecha_final}");
            $misiones[$key]->almas_interesadas = (isset($almas_interesadas[0]->almas_interesadas)) ? $almas_interesadas[0]->almas_interesadas : 0;



            $ministros_r = DB::select("SELECT COUNT(*) AS ministros_r FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=101 AND cm.condicion='R' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->ministros_r = (isset($ministros_r[0]->ministros_r)) ? $ministros_r[0]->ministros_r : 0;


            $ministros_nr = DB::select("SELECT COUNT(*) AS ministros_nr FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=101 AND cm.condicion='N' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->ministros_nr = (isset($ministros_nr[0]->ministros_nr)) ? $ministros_nr[0]->ministros_nr : 0;


            $obreros_r = DB::select("SELECT COUNT(*) AS obreros_r FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=102 AND cm.condicion='R' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->obreros_r = (isset($obreros_r[0]->obreros_r)) ? $obreros_r[0]->obreros_r : 0;


            $obreros_nr = DB::select("SELECT COUNT(*) AS obreros_nr FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=102 AND cm.condicion='N' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->obreros_nr = (isset($obreros_nr[0]->obreros_nr)) ? $obreros_nr[0]->obreros_nr : 0;



            $empleados_r = DB::select("SELECT COUNT(*) AS empleados_r FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=103 AND cm.condicion='R' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->empleados_r = (isset($empleados_r[0]->empleados_r)) ? $empleados_r[0]->empleados_r : 0;


            $empleados_nr = DB::select("SELECT COUNT(*) AS empleados_nr FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=103 AND cm.condicion='N' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->empleados_nr = (isset($empleados_r[0]->empleados_nr)) ? $empleados_nr[0]->empleados_nr : 0;

            $colportores_c = DB::select("SELECT COUNT(*) AS colportores_c FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=3 AND cm.tiempo='C' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->colportores_c = (isset($colportores_c[0]->colportores_c)) ? $colportores_c[0]->colportores_c : 0;

            $colportores_p = DB::select("SELECT COUNT(*) AS colportores_p FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=3 AND cm.tiempo='P' AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->colportores_p = (isset($colportores_p[0]->colportores_p)) ? $colportores_p[0]->colportores_p : 0;


            $ancianos = DB::select("SELECT COUNT(*) AS ancianos FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
            WHERE cm.idcargo=104 AND m.fecharegistro BETWEEN  {$fecha_inicial} AND {$fecha_final} AND cm.tabla='iglesias.mision' AND cm.idlugar={$value->idmision}");

            $misiones[$key]->ancianos = (isset($ancianos[0]->ancianos)) ? $ancianos[0]->ancianos : 0;


            $estudios_biblicos = DB::select("SELECT SUM(ca.valor) AS estudios_biblicos FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=1 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->estudios_biblicos = (isset($estudios_biblicos[0]->estudios_biblicos)) ? $estudios_biblicos[0]->estudios_biblicos : 0;

            $visitas_misioneras = DB::select("SELECT SUM(ca.valor) AS visitas_misioneras FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=2 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->visitas_misioneras = (isset($visitas_misioneras[0]->visitas_misioneras)) ? $visitas_misioneras[0]->visitas_misioneras : 0;


            $conferencias_publicas = DB::select("SELECT SUM(ca.valor) AS conferencias_publicas FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=19 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->conferencias_publicas = (isset($conferencias_publicas[0]->conferencias_publicas)) ? $conferencias_publicas[0]->conferencias_publicas : 0;


            $seminarios = DB::select("SELECT SUM(ca.valor) AS seminarios FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=20 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->seminarios = (isset($seminarios[0]->seminarios)) ? $seminarios[0]->seminarios : 0;


            $congresos = DB::select("SELECT SUM(ca.valor) AS congresos FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=22 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->congresos = (isset($congresos[0]->congresos)) ? $congresos[0]->congresos : 0;


            $libros = DB::select("SELECT SUM(ca.valor) AS libros FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=28 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->libros = (isset($libros[0]->libros)) ? $libros[0]->libros : 0;


            $revistas = DB::select("SELECT SUM(ca.valor) AS revistas FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=29 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->revistas = (isset($revistas[0]->revistas)) ? $revistas[0]->revistas : 0;


            $volantes = DB::select("SELECT SUM(ca.valor) AS volantes FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=30 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->volantes = (isset($volantes[0]->volantes)) ? $volantes[0]->volantes : 0;


            $lecciones = DB::select("SELECT SUM(ca.valor) AS lecciones FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=31 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->lecciones = (isset($lecciones[0]->lecciones)) ? $lecciones[0]->lecciones : 0;

            $guard = DB::select("SELECT SUM(ca.valor) AS guard FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=32 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->guard = (isset($guard[0]->guard)) ? $guard[0]->guard : 0;


            $ancla_juvenil = DB::select("SELECT SUM(ca.valor) AS ancla_juvenil FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=33 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->ancla_juvenil = (isset($ancla_juvenil[0]->ancla_juvenil)) ? $ancla_juvenil[0]->ancla_juvenil : 0;


            $almas_0_12 = DB::select("SELECT COUNT(*) AS almas_0_12 FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=0 AND fechaingresoiglesia BETWEEN  {$fecha_inicial} AND {$fecha_final} AND DATE_PART('year',AGE(fechanacimiento)) between 0 and 12");

            $misiones[$key]->almas_0_12 = (isset($almas_0_12[0]->almas_0_12)) ? $almas_0_12[0]->almas_0_12 : 0;

            $almas_13_19 = DB::select("SELECT COUNT(*) AS almas_13_19 FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=0 AND fechaingresoiglesia BETWEEN  {$fecha_inicial} AND {$fecha_final} AND DATE_PART('year',AGE(fechanacimiento)) between 13 and 19");

            $misiones[$key]->almas_13_19 = (isset($almas_13_19[0]->almas_13_19)) ? $almas_13_19[0]->almas_13_19 : 0;


            $almas_20_30 = DB::select("SELECT COUNT(*) AS almas_20_30 FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=0 AND fechaingresoiglesia BETWEEN  {$fecha_inicial} AND {$fecha_final} AND DATE_PART('year',AGE(fechanacimiento)) between 20 and 30");

            $misiones[$key]->almas_20_30 = (isset($almas_20_30[0]->almas_20_30)) ? $almas_20_30[0]->almas_20_30 : 0;


            $miembros_19 = DB::select("SELECT COUNT(*) AS miembros_19 FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=1 AND fechaingresoiglesia BETWEEN  {$fecha_inicial} AND {$fecha_final} AND DATE_PART('year',AGE(fechanacimiento)) <= 19");

            $misiones[$key]->miembros_19 = (isset($miembros_19[0]->miembros_19)) ? $miembros_19[0]->miembros_19 : 0;

            $miembros_20_30 = DB::select("SELECT COUNT(*) AS miembros_20_30 FROM iglesias.miembro WHERE estado='1' AND idmision={$value->idmision} AND idcondicioneclesiastica=1 AND fechaingresoiglesia BETWEEN  {$fecha_inicial} AND {$fecha_final} AND DATE_PART('year',AGE(fechanacimiento)) between 20 and 30");

            $misiones[$key]->miembros_20_30 = (isset($miembros_20_30[0]->miembros_20_30)) ? $miembros_20_30[0]->miembros_20_30 : 0;



            $reuniones_juveniles = DB::select("SELECT SUM(ca.valor) AS reuniones_juveniles FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=34 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->reuniones_juveniles = (isset($reuniones_juveniles[0]->reuniones_juveniles)) ? $reuniones_juveniles[0]->reuniones_juveniles : 0;

            $sabados_juveniles = DB::select("SELECT SUM(ca.valor) AS sabados_juveniles FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=35 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->sabados_juveniles = (isset($sabados_juveniles[0]->sabados_juveniles)) ? $sabados_juveniles[0]->sabados_juveniles : 0;


            $semanas_juveniles = DB::select("SELECT SUM(ca.valor) AS semanas_juveniles FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=36 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->semanas_juveniles = (isset($semanas_juveniles[0]->semanas_juveniles)) ? $semanas_juveniles[0]->semanas_juveniles : 0;


            $seminarios_juveniles = DB::select("SELECT SUM(ca.valor) AS seminarios_juveniles FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=37 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->seminarios_juveniles = (isset($seminarios_juveniles[0]->seminarios_juveniles)) ? $seminarios_juveniles[0]->seminarios_juveniles : 0;


            $congresos_juveniles = DB::select("SELECT SUM(ca.valor) AS congresos_juveniles FROM iglesias.controlactmisionera AS ca
            WHERE ca.idmision={$value->idmision} AND ca.idactividadmisionera=38 AND ca.fecha_final BETWEEN {$fecha_inicial} AND {$fecha_final}");

            $misiones[$key]->congresos_juveniles = (isset($congresos_juveniles[0]->congresos_juveniles)) ? $congresos_juveniles[0]->congresos_juveniles : 0;


            $oficinas = DB::select("SELECT COUNT(*) AS oficinas
            FROM iglesias.institucion AS i
            WHERE i.idmision={$value->idmision} AND i.tipo='Oficinas'");

            $misiones[$key]->oficinas = (isset($oficinas[0]->oficinas)) ? $oficinas[0]->oficinas : 0;

            $casas = DB::select("SELECT COUNT(*) AS casas
            FROM iglesias.institucion AS i
            WHERE i.idmision={$value->idmision} AND i.tipo='Casas'");

            $misiones[$key]->casas = (isset($casas[0]->casas)) ? $casas[0]->casas : 0;

            $apartamentos = DB::select("SELECT COUNT(*) AS apartamentos
            FROM iglesias.institucion AS i
            WHERE i.idmision={$value->idmision} AND i.tipo='Apartamentos'");

            $misiones[$key]->apartamentos = (isset($apartamentos[0]->apartamentos)) ? $apartamentos[0]->apartamentos : 0;


            $escuelas = DB::select("SELECT COUNT(*) AS escuelas
            FROM iglesias.institucion AS i
            WHERE i.idmision={$value->idmision} AND i.tipo='Escuelas'");

            $misiones[$key]->escuelas = (isset($escuelas[0]->escuelas)) ? $escuelas[0]->escuelas : 0;


            $centros_salud = DB::select("SELECT COUNT(*) AS centros_salud
            FROM iglesias.institucion AS i
            WHERE i.idmision={$value->idmision} AND i.tipo='Centros de Salud'");

            $misiones[$key]->centros_salud = (isset($centros_salud[0]->centros_salud)) ? $centros_salud[0]->centros_salud : 0;


            $editoriales = DB::select("SELECT COUNT(*) AS editoriales
            FROM iglesias.institucion AS i
            WHERE i.idmision={$value->idmision} AND i.tipo='Editoriales'");

            $misiones[$key]->editoriales = (isset($editoriales[0]->editoriales)) ? $editoriales[0]->editoriales : 0;



        }


        $instituciones = DB::select("SELECT i.*, dm.descripcion AS distrito_misionero
        FROM iglesias.institucion AS i
        INNER JOIN iglesias.distritomisionero AS dm ON(i.iddistritomisionero=dm.iddistritomisionero)
        WHERE i.idunion={$idunion}");




        $otras = DB::select("SELECT ot.*, dm.descripcion AS distrito_misionero
        FROM iglesias.otras_propiedades AS ot
        INNER JOIN iglesias.distritomisionero AS dm ON(ot.iddistritomisionero=dm.iddistritomisionero)
        WHERE ot.idunion={$idunion}");



        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["semestre"] = traducir("traductor.semestre_".$_REQUEST["semestre"]);
        $datos["anio"] = $anio;
        $datos["misiones"] = $misiones;
        $datos["instituciones"] = $instituciones;
        $datos["otras"] = $otras;

        $pdf = PDF::loadView("reportes.imprimir_informe_semestral", $datos)->setPaper('A4', "portrait");
        return $pdf->stream("informe_semestral.pdf"); // ver
    }

    public function select_init(Request $request) {
        $data["iddivision"] = $this->divisiones_model->obtener_divisiones($request);
        $data["pais_id"] = $this->paises_model->obtener_paises_asociados($request);
        $data["idunion"] = $this->uniones_model->obtener_uniones_paises($request);
        $data["idmision"] = $this->misiones_model->obtener_misiones($request);
        $data["iddistritomisionero"] = $this->distritos_misioneros_model->obtener_distritos_misioneros($request);
        $data["idiglesia"] = $this->iglesias_model->obtener_iglesias($request);

        $data["idcondicioneclesiastica"] = $this->principal_model->obtener_condicion_eclesiastica();
        $data["idcondicioneclesiastica_all"] = $this->principal_model->obtener_condicion_eclesiastica_all();
        $data["idestadocivil"] = $this->asociados_model->obtener_estado_civil();
        $data["idocupacion"] = $this->asociados_model->obtener_profesiones();

        $data["iddivision_all"] = $this->divisiones_model->obtener_divisiones_all($request);
        $data["pais_id_all"] = $this->paises_model->obtener_paises_asociados_all($request);
        $data["idunion_all"] = $this->uniones_model->obtener_uniones_paises_all($request);
        $data["idmision_all"] = $this->misiones_model->obtener_misiones_all($request);
        $data["iddistritomisionero_all"] = $this->distritos_misioneros_model->obtener_distritos_misioneros_all($request);
        $data["idiglesia_all"] = $this->iglesias_model->obtener_iglesias_all($request);

        $data["anio"] = $this->actividad_misionera_model->obtener_anios();

        $data["periodoini"] = $this->asociados_model->obtener_periodos_ini();
        $data["periodofin"] = $this->asociados_model->obtener_periodos_fin();
        echo json_encode($data);
    }
}
