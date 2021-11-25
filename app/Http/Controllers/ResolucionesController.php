<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\PropuestasModel;
use App\Models\ResolucionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;
use PDF;
class ResolucionesController extends Controller
{
    //
    private $base_model;
    private $resoluciones_model;
    
    public function __construct() {
        parent:: __construct();
        $this->resoluciones_model = new ResolucionesModel();
        $this->propuestas_model = new PropuestasModel();
        $this->base_model = new BaseModel();
    }

    public function index() {
        $view = "resoluciones.index";
        $data["title"] = traducir("asambleas.titulo_resoluciones");
        $data["subtitle"] = "";
        $data["tabla"] = $this->resoluciones_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-resolucion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-resolucion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-resolucion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        
        $botones[3] = '<button disabled="disabled" tecla_rapida="F8" style="margin-right: 5px;" class="btn btn-default btn-sm" id="traducir-resolucion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/traducir.png').'"><br>'.traducir("asambleas.traducir").'</button>';
        $data["botones"] = $botones;

        $data["tabla_propuestas_temas"] = $this->propuestas_model->tabla("S")->HTML();
        $data["tabla_propuestas_elecciones"] = $this->propuestas_model->tabla_propuestas_elecciones("S")->HTML();


        $data["scripts"] = $this->cargar_js(["resoluciones.js?261020210706"]);
        return parent::init($view, $data);

      
       
    }

    public function buscar_datos() {
        $json_data = $this->resoluciones_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_resoluciones(Request $request) {
        
        $array_traducciones = array();
        
        try {
            DB::beginTransaction();
            // print_r($_REQUEST); 
            // exit;
            
            $idioma = (isset($_REQUEST["tr_idioma"])) ? $_REQUEST["tr_idioma"] : "";
            foreach ($_REQUEST as $key => $value) {
            // $arr = explode("_traduccion", $key);
                if(strpos($key, "_traduccion") !== false) {

                    if(!empty($value)) {
                        $array_traducciones[str_replace("_traduccion","",$key)] = $value;

                        if(str_replace("_traduccion","",$key) == "tr_idioma") {
                            $idioma = $value;
                        }
                    }
                    
                    // echo $key." -> ". $value." ".str_replace("_traduccion","",$key)."\n";
                }

            }

            $_POST = $this->toUpper($_POST, ["tr_idioma", "tabla"]);
            
            if ($request->input("resolucion_id") == '') {
                $_POST["resolucion_fecha"] = date("Y-m-d H:i:s");
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.resoluciones", $_POST));
            }else{
                $result = $this->base_model->modificar($this->preparar_datos("asambleas.resoluciones", $_POST));
            }


            $_POST["resolucion_id"] = $result["id"];
            DB::table("asambleas.traduccion_resoluciones")->where("resolucion_id", $result["id"])->where("tr_idioma", $idioma)->delete();
            // print_r($array_traducciones);
            if(count($array_traducciones) > 0){
                // print_r($this->preparar_datos("asambleas.traduccion_resoluciones", $array_traducciones));
                $array_traducciones["resolucion_id"] = $_POST["resolucion_id"];
                $array_traducciones = $this->toUpper($array_traducciones, ["tr_idioma"]);
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.traduccion_resoluciones", $array_traducciones));
                
            } else {
                // print_r($this->preparar_datos("asambleas.traduccion_resoluciones", $_POST));
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.traduccion_resoluciones", $_POST));
            }   

            $resultado_ids = explode(",", $_REQUEST["resultado_ids"]);

            if(count($resultado_ids) > 0) {
                for ($i=0; $i < count($resultado_ids); $i++) { 

                    $update_resultado = array();
                    $update_resultado["resultado_id"] = $resultado_ids[$i];
                    $update_resultado["resolucion_id"] = $_POST["resolucion_id"];
                    $this->base_model->modificar($this->preparar_datos("asambleas.resultados", $update_resultado));
                }
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

    public function eliminar_resoluciones() {
       

        try {
            $sql_agenda = "SELECT * FROM asambleas.agenda WHERE resolucion_id=".$_REQUEST["id"];
            $agenda = DB::select($sql_agenda);

            if(count($agenda) > 0) {
                throw new Exception(traducir("traductor.eliminar_asamblea_agenda"));
            }

           

            $result = $this->base_model->eliminar(["asambleas.resoluciones","resolucion_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_resoluciones(Request $request) {
        $id = explode("|", $_REQUEST["id"]);
        $resolucion_id = $id[0];
        $idioma_codigo = $id[1];
        $sql = "SELECT *
        FROM asambleas.resoluciones AS r 
        LEFT JOIN asambleas.traduccion_resoluciones AS tr ON(tr.resolucion_id=r.resolucion_id AND tr.tr_idioma='{$idioma_codigo}')
        WHERE r.resolucion_id=".$resolucion_id;
        $one = DB::select($sql);

        // if($one[0]->tabla == "asambleas.propuestas_temas") {
        //     $sql_propuesta = "SELECT * FROM  asambleas.propuestas_temas AS pt 
        //     \nLEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".session("idioma_codigo")."')
        //     WHERE pt.pt_id = {$one[0]->propuesta_id}
        //     ORDER BY ";
        // }

        // if($one[0]->tabla == "asambleas.propuestas_elecciones") {
        //     $sql_propuesta = "SELECT * FROM  asambleas.propuestas_elecciones AS pe 
        //     \nLEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id AND tpe.tpe_idioma='".session("idioma_codigo")."'))
        //     WHERE pe.pe_id = {$one[0]->propuesta_id}";
        // }


        

        echo json_encode($one);
    }

    public function imprimir_resolucion($resolucion_id) {
        // print_r($resolucion_id); exit;  

        $resolucion = explode("|", $resolucion_id);
        $resolucion_id = $resolucion[0];
        $idioma_codigo = $resolucion[1];


        $sql = "SELECT r.resolucion_id, 
   
        CASE WHEN tr.tr_descripcion IS NULL THEN (SELECT tr_descripcion FROM asambleas.traduccion_resoluciones WHERE resolucion_id=r.resolucion_id AND tr_idioma='".trim(session("idioma_defecto"))."') ELSE tr.tr_descripcion  END AS tr_descripcion, 

        ".formato_fecha_idioma_customer(" r.resolucion_fecha", $idioma_codigo)." AS resolucion_fecha,
    
        CASE WHEN tr.tr_titulo_propuesta IS NULL THEN (SELECT tr_titulo_propuesta FROM asambleas.traduccion_resoluciones WHERE resolucion_id=r.resolucion_id AND tr_idioma='".trim(session("idioma_defecto"))."') ELSE tr.tr_titulo_propuesta  END AS tr_titulo_propuesta, 
        CASE WHEN tr.tr_propuesta IS NULL THEN (SELECT tr_propuesta FROM asambleas.traduccion_resoluciones WHERE resolucion_id=r.resolucion_id AND tr_idioma='".trim(session("idioma_defecto"))."') ELSE tr.tr_propuesta  END AS tr_propuesta, 
        CASE 
        WHEN r.resolucion_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN r.resolucion_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN r.resolucion_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS resolucion_estado,
        r.resolucion_estado AS estado_resolucion,
        r.resolucion_anio_correlativo,
       
        r.tabla
        
        FROM asambleas.resoluciones AS r
        LEFT JOIN asambleas.traduccion_resoluciones AS tr ON(tr.resolucion_id=r.resolucion_id AND tr.tr_idioma='".$idioma_codigo."')
        WHERE r.resolucion_id={$resolucion_id}";
        $resolucion = DB::select($sql);


        $sql_resultados = "SELECT * FROM asambleas.resultados where resolucion_id={$resolucion_id}";
        $resultados = DB::select($sql_resultados);

        // die($sql_resultados);
    // print_r($resultados); exit;
        $datos["resolucion"] = $resolucion;
        $datos["resultados"] = $resultados;
 

        $datos["nivel_organizativo"] = session("nivel_organizativo"); 
        // echo "<pre>";
        // print_r($datos);
        // exit;
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("resoluciones.imprimir", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("resolucion.pdf"); // ver
    }
    

    

    
}
