<?php

namespace App\Http\Controllers;

use App\Exports\AsociadosExport;
use App\Models\BaseModel;
use App\Models\ReportesModel;

// use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use PDF;
class ReportesController extends Controller
{
    //
    private $base_model;
    private $ReportesController_model;
    
    public function __construct() {
        parent:: __construct();
        $this->reportes_model = new ReportesModel();
        $this->base_model = new BaseModel();
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



    public function buscar_datos() {
        $json_data = $this->ReportesController_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_ReportesController(Request $request) {
   
        $_POST = $this->toUpper($_POST);
        if ($request->input("perfil_id") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("seguridad.ReportesController", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("seguridad.ReportesController", $_POST));
        }

   
        DB::table("seguridad.ReportesController_idiomas")->where("perfil_id", $result["id"])->delete();
        if(isset($_REQUEST["idioma_id"]) && isset($_REQUEST["pi_descripcion"])) {
     
            $_POST["perfil_id"] = $result["id"];
           
            $this->base_model->insertar($this->preparar_datos("seguridad.ReportesController_idiomas", $_POST, "D"), "D");
        }
        echo json_encode($result);
    }

   


    public function get(Request $request) {

        $sql = "SELECT * FROM seguridad.ReportesController WHERE perfil_id=".$request->input("id");
        $one = DB::select($sql);
        echo json_encode($one);
    }

     
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

        if($request->input("idocupacion") != '') {
            array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        }
        

        if($request->input("idocupacion") != '') {
            array_push($array_where, 'm.idocupacion='.$request->input("idocupacion"));
        }

        if($request->input("estado") != '') {
            array_push($array_where, "m.estado='".$request->input("estado")."'");
        }

        if($request->input("iddivision") != '') {
            array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
        }

        if($request->input("pais_id") != '') {
            $array_pais = explode("|", $request->input("pais_id"));
            array_push($array_where, 'm.pais_id='.$array_pais[0]);
        }

        if($request->input("idunion") != '') {
            array_push($array_where, 'm.idunion='.$request->input("idunion"));
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
            $select = " m.*, to_char( m.fechanacimiento, 'DD/MM/YYYY') AS fechanacimiento,
            gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, to_char( m.fechabautizo, 'DD/MM/YYYY') AS fechabautizo, vr.nombres AS bautizador ";
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
        WHERE ".$where;
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
            echo '<script>alert("No hay Datos!"); window.close();</script>';
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
            echo '<script>alert("No hay Datos!"); window.close();</script>';
            exit;
        }
        $sql_estado_civil = "SELECT * FROM public.estadocivil";
        $estado_civil = DB::select($sql_estado_civil);
        $sql_motivos_baja = "SELECT * FROM iglesias.motivobaja";
        $motivos_baja = DB::select($sql_motivos_baja);

        foreach ($miembros as $km => $vm) {
            $sql_baja = "SELECT h.*, to_char( h.fecha, 'DD/MM/YYYY') AS fecha 
            FROM iglesias.historial_altasybajas AS h
            WHERE h.idmiembro=".$vm->idmiembro."
            ORDER BY h.fecha DESC";
            $miembros[$km]->bajas = DB::select($sql_baja);



            $sql_cargos = "SELECT c.descripcion AS cargo, cm.periodoini, cm.periodofin, cm.lugar FROM iglesias.miembro AS m
            INNER JOIN iglesias.cargo_miembro AS cm ON(cm.idmiembro=m.idmiembro)
            INNER JOIN public.cargo AS c ON(c.idcargo=cm.idcargo)
            WHERE m.idmiembro=".$vm->idmiembro;

            $miembros[$km]->cargos = DB::select($sql_cargos);  


            $sql_control = "SELECT to_char(ct.fecha, 'DD/MM/YYYY') AS fecha_aceptacion, to_char(ht.fecha, 'DD/MM/YYYY') AS fecha_aceptacion_local FROM iglesias.control_traslados AS ct
            INNER JOIN iglesias.historial_traslados AS ht ON(ct.idcontrol=ht.idcontrol)
            WHERE estado='0' AND ht.idmiembro=".$vm->idmiembro." 
            ORDER BY ct.idcontrol DESC";
            $control = DB::select($sql_control);
            $miembros[$km]->fecha_aceptacion = (isset($control[0]->fecha_aceptacion)) ? $control[0]->fecha_aceptacion : "";
            $miembros[$km]->fecha_aceptacion_local = (isset($control[0]->fecha_aceptacion_local)) ? $control[0]->fecha_aceptacion_local : "";
            
        }

      
    

        $datos["estado_civil"] = $estado_civil;
        // $datos["baja"] = $baja;
        $datos["motivos_baja"] = $motivos_baja; 

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
            echo '<script>alert("No hay Datos!"); window.close();</script>';
            exit;
        }
        return Excel::download(new AsociadosExport, 'reporte_general_asociados.xlsx');
    }

    public function obtener_feligresia(Request $request) {
        $array_where = array();
        $where = "";
        if($request->input("iddivision") != '0') {
            array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
        }

        if($request->input("pais_id") != '0') {
            $array_pais = explode("|", $request->input("pais_id"));
            array_push($array_where, 'm.pais_id='.$array_pais[0]);
        }

        if($request->input("idunion") != '0') {
            array_push($array_where, 'm.idunion='.$request->input("idunion"));
        }

        if($request->input("idmision") != '0') {
            array_push($array_where, 'm.idmision='.$request->input("idmision"));
        }

        if($request->input("iddistritomisionero") != '0') {
            array_push($array_where, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
        }

        if($request->input("idiglesia") != '0') {
            array_push($array_where, 'm.idiglesia='.$request->input("idiglesia"));
        }

        if(count($array_where) > 0 ) {
            $where .= "WHERE ".implode(" AND ", $array_where);
        } 
        

        $sql = "SELECT *
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.condicioneclesiastica AS ce ON(ce.idcondicioneclesiastica=m.idcondicioneclesiastica)
        ".$where;
        // die($sql);
        $total = DB::select($sql);
        $total = count($total);


        $sql = "SELECT (COUNT(m.idmiembro)* 100 / ".$total.") AS y, (COUNT(m.idmiembro) || '-' || (CASE WHEN ce.descripcion <> 'Bautizado' THEN  'Escuela Sabática' ELSE ce.descripcion  END)) AS name 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.condicioneclesiastica AS ce ON(ce.idcondicioneclesiastica=m.idcondicioneclesiastica)
        ".$where."
        GROUP BY ce.descripcion ";
        //die($sql);
        $data = DB::select($sql);
        echo json_encode($data);

    }

    public function imprimir_miembros_iglesia(Request $request) {
        $datos = array();
        $array_where = array();
        $where = "";
        if($request->input("iddivision") != '') {
            array_push($array_where, 'm.iddivision='.$request->input("iddivision"));
        }

        if($request->input("pais_id") != '') {
            $array_pais = explode("|", $request->input("pais_id"));
            array_push($array_where, 'm.pais_id='.$array_pais[0]);
        }

        if($request->input("idunion") != '') {
            array_push($array_where, 'm.idunion='.$request->input("idunion"));
        }

        if($request->input("idmision") != '') {
            array_push($array_where, 'm.idmision='.$request->input("idmision"));
        }

        if($request->input("iddistritomisionero") != '') {
            array_push($array_where, 'm.iddistritomisionero='.$request->input("iddistritomisionero"));
        }

        if($request->input("idiglesia") != '') {
            array_push($array_where, 'm.idiglesia='.$request->input("idiglesia"));
        }

        if(count($array_where) > 0 ) {
            $where .= "WHERE ".implode(" AND ", $array_where);
        } 
        

        $datos = array();
        $sql_miembros = "SELECT m.*, to_char( m.fechanacimiento, 'DD/MM/YYYY') AS fechanacimiento,
        gi.descripcion AS educacion, o.descripcion AS ocupacion, r.descripcion AS religion, to_char( m.fechabautizo, 'DD/MM/YYYY') AS fechabautizo, vr.nombres AS bautizador, i.descripcion AS iglesia
        FROM iglesias.miembro AS m
        LEFT JOIN public.gradoinstruccion AS gi ON(gi.idgradoinstruccion=m.idgradoinstruccion)
        LEFT JOIN public.ocupacion AS o ON(o.idocupacion=m.idocupacion)
        LEFT JOIN iglesias.religion AS r ON(r.idreligion=m.idreligion)
        LEFT JOIN iglesias.vista_responsables AS vr ON(m.encargado_bautizo=vr.id AND vr.tabla=m.tabla_encargado_bautizo)
        LEFT JOIN iglesias.iglesia AS i ON(i.idiglesia=m.idiglesia)
        ".$where;
        $miembros = DB::select($sql_miembros);

        $sql_secretario = "SELECT (m.apellidos || ', ' || m.nombres) AS nombres 
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.cargo_miembro AS cm ON(m.idmiembro=cm.idmiembro)
        WHERE cm.idcargo=6 AND cm.vigente='1' AND  m.idiglesia=".$request->input("idiglesia");
        $secretario = DB::select($sql_secretario);

        
        foreach ($miembros as $km => $vm) {
            $sql_baja = "SELECT h.*, to_char( h.fecha, 'DD/MM/YYYY') AS fecha 
            FROM iglesias.historial_altasybajas AS h
            WHERE h.idmiembro=".$vm->idmiembro."
            ORDER BY h.fecha DESC";
            $miembros[$km]->bajas = DB::select($sql_baja);

            $sql_control = "SELECT to_char(ct.fecha, 'DD/MM/YYYY') AS fecha_aceptacion, to_char(ht.fecha, 'DD/MM/YYYY') AS fecha_aceptacion_local FROM iglesias.control_traslados AS ct
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

}