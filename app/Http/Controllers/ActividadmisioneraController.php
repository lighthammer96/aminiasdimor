<?php

namespace App\Http\Controllers;

use App\Models\ActividadmisioneraModel;

use App\Models\BaseModel;
use App\Models\DistritosmisionerosModel;
use App\Models\DivisionesModel;
use App\Models\IglesiasModel;
use App\Models\MisionesModel;
use App\Models\PaisesModel;
use App\Models\UnionesModel;
// use App\Models\ActividadmisioneraModel;
// use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PDF;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
class ActividadmisioneraController extends Controller
{
    //
    private $base_model;
    private $divisiones_model;
    private $paises_model;
    private $uniones_model;
    private $misiones_model;
    private $distritos_misioneros_model;
    private $iglesias_model;
    private $actividad_misionera_model;



    public function __construct() {
        parent:: __construct();
        // $this->perfiles_model = new ActividadmisioneraModel();
        $this->base_model = new BaseModel();
        $this->divisiones_model = new DivisionesModel();
        $this->paises_model = new PaisesModel();
        $this->uniones_model = new UnionesModel();
        $this->misiones_model = new MisionesModel();
        $this->distritos_misioneros_model = new DistritosmisionerosModel();
        $this->iglesias_model = new IglesiasModel();
        $this->actividad_misionera_model = new ActividadmisioneraModel();
       
    }

    public function index() {
        $view = "actividad_misionera.index";
        $data["title"] = traducir("traductor.titulo_actividad_misionera");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->perfiles_model->tabla()->HTML();

        // $botones = array();
        // $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-primary btn-sm" id="nuevo-perfil">'.traducir("traductor.nuevo").' [F1]</button>';
        // $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-success btn-sm" id="modificar-perfil">'.traducir("traductor.modificar").' [F2]</button>';
        // $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-danger btn-sm" id="eliminar-perfil">'.traducir("traductor.eliminar").' [F7]</button>';
        // $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["actividad_misionera.js"]);
        return parent::init($view, $data);



    }

    public function reporte() {
        $view = "actividad_misionera.reporte";
        $data["title"] = traducir("traductor.titulo_reporte_actividad_misionera");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->perfiles_model->tabla()->HTML();

        $data["scripts"] = $this->cargar_js(["reporte_actividad_misionera.js"]);
        return parent::init($view, $data);



    }

    // public function buscar_datos() {
    //     $json_data = $this->perfiles_model->tabla()->obtenerDatos();
    //     echo json_encode($json_data);
    // }


    public function guardar_actividad(Request $request) {

        // $_POST = $this->toUpper($_POST);
        // if ($request->input("perfil_id") == '') {
        //     $result = $this->base_model->insertar($this->preparar_datos("seguridad.perfiles", $_POST));
        // }else{
        //     $result = $this->base_model->modificar($this->preparar_datos("seguridad.perfiles", $_POST));
        // }

        $accion = $request->input("accion");
        $idactividadmisionera = $request->input("idactividadmisionera");
        $valor = $request->input("valor");
        $semana = $request->input("semana");
        $anio = $request->input("anio");
        $mes = $request->input("mes");


        $array_pais = explode("|", $_POST["pais_id"]);
        $_POST["pais_id"] = $array_pais[0];
        if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_POST["idunion"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_POST["pais_id"]}";
            $res = DB::select($sql);
            $_POST["idunion"] = $res[0]->idunion;
        }


        $_POST["fecha_inicial"] = $this->FormatoFecha($_REQUEST["fecha_inicial"], "server");
        $_POST["fecha_final"] = $this->FormatoFecha($_REQUEST["fecha_final"], "server");
        // $idtrimestre = $request->input("idtrimestre");
        // $_POST["trimestre"] = $idtrimestre;
        $idiglesia = $request->input("idiglesia");


        $sql_validacion = "SELECT * FROM iglesias.controlactmisionera WHERE idactividadmisionera={$idactividadmisionera} AND anio='{$anio}' AND mes={$mes} AND idiglesia={$idiglesia} AND semana={$semana}";

        // die($sql_validacion);
        $validacion = DB::select($sql_validacion);

        if($accion == "valor") {
            DB::table("iglesias.controlactmisionera")->where(array("idactividadmisionera" => $idactividadmisionera, "anio" => $anio, "mes" => $mes, "semana" => $semana, "idiglesia" => $idiglesia))->delete();


            $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
        }


        if($accion == "cantidad") {

            if(count($validacion) > 0) {
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } else {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            }
        }

        if($accion == "asistentes") {
            $_POST["valor"] = "";
            $_POST["asistentes"] = $valor;
            if(count($validacion) > 0) {
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } else {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            }

        }

        if($accion == "interesados") {
            $_POST["valor"] = "";
            $_POST["interesados"] = $valor;
            if(count($validacion) > 0) {
                $result = $this->base_model->modificar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            } else {
                $result = $this->base_model->insertar($this->preparar_datos("iglesias.controlactmisionera", $_POST));
            }

        }

        echo json_encode($result);
    }


    // public function get(Request $request) {

    //     $sql = "SELECT * FROM seguridad.perfiles WHERE perfil_id=".$request->input("id");
    //     $one = DB::select($sql);
    //     echo json_encode($one);
    // }



    public function obtener_anios() {
        $array = $this->actividad_misionera_model->obtener_anios();
        echo json_encode($array);
    }


    public function obtener_trimestres() {
        $result = $this->actividad_misionera_model->obtener_trimestres();
        echo json_encode($result);
    }

    public function obtener_actividades(Request $request) {
        $anio = $request->input("anio");
        // $idtrimestre = $request->input("idtrimestre");
        $mes = $request->input("mes");
        $semana = $request->input("semana");
        $idiglesia = $request->input("idiglesia");
        $iddivision = $request->input("iddivision");

        $array_pais = explode("|", $_REQUEST["pais_id"]);
        $_REQUEST["pais_id"] = $array_pais[0];
        if(isset($array_pais[1]) && $array_pais[1] == "N" && empty($_REQUEST["idunion"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }


        $pais_id = $_REQUEST["pais_id"];
        $idunion = $_REQUEST["idunion"];
        $idmision = $request->input("idmision");
        $iddistritomisionero = $request->input("iddistritomisionero");

        $where = "";
        // if($idtrimestre != "0") {
        //     $where .= ' AND c.trimestre='.$idtrimestre;
        // }
        $group_by = "";
        $select = "";
        if($anio != "0") {
            $where .= " AND c.anio='".$anio."'";
        }

        if(!isset($_REQUEST["idtrimestre"])) {
            if($mes != "0") {
                $where .= ' AND c.mes='.$mes;
            }


            if($semana != "0") {
                $where .= ' AND c.semana='.$semana;
            }
            $group_by = " GROUP BY am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, c.semana ";
            $select = " am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, c.semana, SUM(c.valor) AS valor, SUM(c.asistentes) AS asistentes, SUM(c.interesados) AS interesados, SUM(c.valor) AS cantidad,
            array_to_string(array_agg(c.planes), '\n') AS planes, array_to_string(array_agg(c.informe_espiritual), '\n') AS informe_espiritual ";
        } else {
            switch ($_REQUEST["idtrimestre"]) {
                case 1:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-01-01' AND '".$anio."-03-31'";
                    break;
                case 2:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-04-01' AND '".$anio."-06-30'";
                    break;
                case 3:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-07-01' AND '".$anio."-09-30'";
                    break;
                case 4:
                    $where .=  " AND c.fecha_final BETWEEN '".$anio."-10-01' AND '".$anio."-12-31'";
                    break;
            }
            $select = " am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia, SUM(c.valor) AS valor, SUM(c.asistentes) AS asistentes, SUM(c.interesados) AS interesados, SUM(c.valor) AS cantidad,
            array_to_string(array_agg(c.planes), '\n') AS planes, array_to_string(array_agg(c.informe_espiritual), '\n') AS informe_espiritual ";
            $group_by = " GROUP BY am.idactividadmisionera, am.descripcion, am.tipo, c.anio, c.idiglesia ";
        }

        if($iddivision != "0" && $iddivision != "") {
            $where .= ' AND c.iddivision='.$iddivision;
        }

        if($pais_id != "0" && $pais_id != "") {
            $where .= ' AND c.pais_id='.$pais_id;
        }

        if($idunion != "0" && $idunion != "") {
            $where .= ' AND c.idunion='.$idunion;
        }

        if($idmision != "0" && $idmision != "") {
            $where .= ' AND c.idmision='.$idmision;
        }

        if($iddistritomisionero != "0" && $iddistritomisionero != "") {
            $where .= ' AND c.iddistritomisionero='.$iddistritomisionero;
        }

        if($idiglesia != "0" && $idiglesia != "") {
            $where .= ' AND c.idiglesia='.$idiglesia;
        }

        $sql = "SELECT ".$select."
        FROM iglesias.actividadmisionera AS am
        LEFT JOIN iglesias.controlactmisionera AS c ON(am.idactividadmisionera=c.idactividadmisionera ".$where.")
       ".$group_by."
        ORDER BY am.idactividadmisionera ASC";
        // die($sql);
        $result = DB::select($sql);

        echo json_encode($result);
    }


    public function obtener_trimestres_todos() {

        $array = array("id" => 0, "descripcion" => "Todos");
        $array = (object) $array;

    //  print_r($array);
        $sql = "SELECT idtrimestre AS id, descripcion FROM public.trimestre
        ORDER BY idtrimestre ASC";
        $result = DB::select($sql);
        array_push($result, $array);
        echo json_encode($result);
    }

    public function obtener_data_actividades($where) {


        $sql = "SELECT
        ".formato_fecha_idioma("c.fecha_final")." AS fecha_final,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=1 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS estudios_biblicos,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=2 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS visitas_misioneras,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=19 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS conferencias_publicas,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=20 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS seminarios,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=22 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS congresos,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=28 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS libros,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=29 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS revistas,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=30 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS volantes,

        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=31 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS lecciones,
        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=32 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS guard,

        (SELECT COALESCE(SUM(valor),0) FROM iglesias.controlactmisionera WHERE idactividadmisionera=33 AND
        anio=c.anio AND fecha_final=c.fecha_final AND idiglesia=c.idiglesia) AS ancla_juvenil


        FROM iglesias.controlactmisionera AS c
        WHERE 1=1 ".$where."

        GROUP BY c.fecha_final, c.anio, c.idiglesia, c.semana
        ORDER BY c.fecha_final ASC";
        // die($sql);
        $actividades = DB::select($sql);
        return $actividades;
    }


    public function imprimir_actividades_misioneras(Request $request) {
        // print_r($_GET); exit;
        $datos = array();
        $anio = $request->input("anio");
        // $idtrimestre = $request->input("idtrimestre");
        // $mes = $request->input("mes");
        // $semana = $request->input("semana");
        $idiglesia = $request->input("idiglesia");

        $where = "";
        $where .= " AND c.anio='".$anio."'";

        switch ($_REQUEST["idtrimestre"]) {
            case 1:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-01-01' AND '".$anio."-03-31'";
                break;
            case 2:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-04-01' AND '".$anio."-06-30'";
                break;
            case 3:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-07-01' AND '".$anio."-09-30'";
                break;
            case 4:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-10-01' AND '".$anio."-12-31'";
                break;
        }

        $where .= ' AND c.idiglesia='.$idiglesia;


        $actividades = $this->obtener_data_actividades($where);

        $sql_textos = " SELECT ".formato_fecha_idioma("c.fecha_final")." AS fecha_final, array_to_string(array_agg(c.planes), '\n') AS planes, array_to_string(array_agg(c.informe_espiritual), '\n') AS informe_espiritual
        FROM iglesias.controlactmisionera AS c
        WHERE c.idactividadmisionera=39 ".$where."

        GROUP BY c.fecha_final
        ORDER BY c.fecha_final ASC
        ";
        // die($sql_textos);
        $textos = DB::select($sql_textos);
        // $planes = "";
        // $informe_espiritual = "";

        // foreach ($textos as $kt => $vt) {
        //     $planes .= $vt->planes."\n";
        //     $informe_espiritual .= $vt->informe_espiritual."\n";
        // }


        $sql_director = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=5 AND cm.vigente='1' AND  m.idiglesia=".$idiglesia;

        $director = DB::select($sql_director);


        $sql_director_obra = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=20 AND cm.vigente='1' AND  m.idiglesia=".$idiglesia;

        $director_obra = DB::select($sql_director_obra);


        $datos["nivel_organizativo"] = $this->obtener_nivel_organizativo($_REQUEST);
        $datos["anio"] = $_REQUEST["anio"];
        $datos["actividades"] = $actividades;
        $datos["textos"] = $textos;
        $datos["director"] = (isset($director[0]->nombres))  ? $director[0]->nombres : "";
        $datos["director_obra"] = (isset($director_obra[0]->nombres))  ? $director_obra[0]->nombres : "";
        // $datos["planes"] = $planes;
        // $datos["informe_espiritual"] = $informe_espiritual;

        $datos["trimestre"] = traducir("traductor.trimestre_".$_REQUEST["idtrimestre"]);

        $pdf = PDF::loadView("actividad_misionera.imprimir", $datos)->setPaper('A4', "portrait");



        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("actividades_misioneras.pdf"); // ver
    }

    public function exportar_excel_actividades_misioneras(Request $request) {

        $anio = $request->input("anio");

        $idiglesia = $request->input("idiglesia");

        $where = "";
        $where .= " AND c.anio='".$anio."'";

        switch ($_REQUEST["idtrimestre"]) {
            case 1:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-01-01' AND '".$anio."-03-31'";
                break;
            case 2:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-04-01' AND '".$anio."-06-30'";
                break;
            case 3:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-07-01' AND '".$anio."-09-30'";
                break;
            case 4:
                $where .=  " AND c.fecha_final BETWEEN '".$anio."-10-01' AND '".$anio."-12-31'";
                break;
        }

        $where .= ' AND c.idiglesia='.$idiglesia;


        $actividades = $this->obtener_data_actividades($where);

        // echo "<pre>";
        // print_r($actividades);

        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        $array = range('A', 'L');

        for ($i = 0; $i < count($array); $i++) {
            $sheet->getColumnDimension($array[$i])->setAutoSize(true);

        }

        $sheet->setCellValueByColumnAndRow(1, 1, traducir("traductor.para_semana_termina"));
        $sheet->setCellValueByColumnAndRow(2, 1, traducir("traductor.estudios_biblicos"));
        $sheet->setCellValueByColumnAndRow(3, 1, traducir("traductor.visitas_misioneras"));
        $sheet->setCellValueByColumnAndRow(4, 1, traducir("traductor.conferencias_biblicas"));
        $sheet->setCellValueByColumnAndRow(5, 1, traducir("traductor.seminarios"));
        $sheet->setCellValueByColumnAndRow(6, 1, traducir("traductor.congresos"));
        $sheet->setCellValueByColumnAndRow(7, 1, traducir("traductor.libros"));
        $sheet->setCellValueByColumnAndRow(8, 1, traducir("traductor.revistas"));
        $sheet->setCellValueByColumnAndRow(9, 1, traducir("traductor.volantes"));
        $sheet->setCellValueByColumnAndRow(10, 1, traducir("traductor.lecciones_esc_sab"));
        $sheet->setCellValueByColumnAndRow(11, 1, traducir("traductor.guard_sab"));
        $sheet->setCellValueByColumnAndRow(12, 1, traducir("traductor.ancla_juvenil"));

        $fila = 2;
        $estudios_biblicos = 0;
        $visitas_misioneras = 0;
        $conferencias_publicas = 0;
        $seminarios = 0;
        $congresos = 0;
        $libros = 0;
        $revistas = 0;
        $volantes = 0;
        $lecciones = 0;
        $guard = 0;
        $ancla_juvenil = 0;

        foreach ($actividades as $key => $value) {
            $sheet->setCellValueByColumnAndRow(1, $fila, $value->fecha_final);
            $sheet->setCellValueByColumnAndRow(2, $fila, $value->estudios_biblicos);
            $sheet->setCellValueByColumnAndRow(3, $fila, $value->visitas_misioneras);
            $sheet->setCellValueByColumnAndRow(4, $fila, $value->conferencias_publicas);
            $sheet->setCellValueByColumnAndRow(5, $fila, $value->seminarios);
            $sheet->setCellValueByColumnAndRow(6, $fila, $value->congresos);
            $sheet->setCellValueByColumnAndRow(7, $fila, $value->libros);
            $sheet->setCellValueByColumnAndRow(8, $fila, $value->revistas);
            $sheet->setCellValueByColumnAndRow(9, $fila, $value->volantes);
            $sheet->setCellValueByColumnAndRow(10, $fila, $value->lecciones);
            $sheet->setCellValueByColumnAndRow(11, $fila, $value->guard);
            $sheet->setCellValueByColumnAndRow(12, $fila, $value->ancla_juvenil);

            $estudios_biblicos += intval($value->estudios_biblicos);
            $visitas_misioneras += intval($value->visitas_misioneras);
            $conferencias_publicas += intval($value->conferencias_publicas);
            $seminarios += intval($value->seminarios);
            $congresos += intval($value->congresos);
            $libros += intval($value->libros);
            $revistas += intval($value->revistas);
            $volantes += intval($value->volantes);
            $lecciones += intval($value->lecciones);
            $guard += intval($value->guard);
            $ancla_juvenil += intval($value->ancla_juvenil);

            $fila ++;
        }

        $sheet->setCellValueByColumnAndRow(1, $fila, traducir("traductor.total_trimestre"));
        $sheet->setCellValueByColumnAndRow(2, $fila, $estudios_biblicos);
        $sheet->setCellValueByColumnAndRow(3, $fila, $visitas_misioneras);
        $sheet->setCellValueByColumnAndRow(4, $fila, $conferencias_publicas);
        $sheet->setCellValueByColumnAndRow(5, $fila, $seminarios);
        $sheet->setCellValueByColumnAndRow(6, $fila, $congresos);
        $sheet->setCellValueByColumnAndRow(7, $fila, $libros);
        $sheet->setCellValueByColumnAndRow(8, $fila, $revistas);
        $sheet->setCellValueByColumnAndRow(9, $fila, $volantes);
        $sheet->setCellValueByColumnAndRow(10, $fila, $lecciones);
        $sheet->setCellValueByColumnAndRow(11, $fila, $guard);
        $sheet->setCellValueByColumnAndRow(12, $fila, $ancla_juvenil);
        $fila ++;

        $styleArray = [
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
                    'color' => ['rgb' => '000000'],
                ],
            ],
            'alignment' => [
                'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
            ],
        ];


        $sheet->getStyle('A1:L' . ($fila - 1))->applyFromArray($styleArray);

        $writer = new Xlsx($spreadsheet);


        // $writer->save('hello world.xlsx');

        // redirect output to client browser
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="actividades_misioneras_'.$request->input("idtrimestre").'-'.$request->input("anio").'.xlsx"');
        header('Cache-Control: max-age=0');

        $writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($spreadsheet, 'Xlsx');
        $writer->save('php://output');
    }

    public function select_init(Request $request) {
        $data["iddivision"] = $this->divisiones_model->obtener_divisiones($request);
        $data["pais_id"] = $this->paises_model->obtener_paises_asociados($request);
        $data["idunion"] = $this->uniones_model->obtener_uniones_paises($request);
        $data["idmision"] = $this->misiones_model->obtener_misiones($request);
        $data["iddistritomisionero"] = $this->distritos_misioneros_model->obtener_distritos_misioneros($request);
        $data["idiglesia"] = $this->iglesias_model->obtener_iglesias($request);

        $data["idtrimestre"] = $this->actividad_misionera_model->obtener_trimestres();
        $data["anio"] = $this->actividad_misionera_model->obtener_anios();



        echo json_encode($data);
    }
}
