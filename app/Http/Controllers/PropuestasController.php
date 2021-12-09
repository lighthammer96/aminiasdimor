<?php

namespace App\Http\Controllers;

use App\Models\AsociadosModel;
use App\Models\BaseModel;
use App\Models\PropuestasModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;
use PDF;
class PropuestasController extends Controller
{
    //
    private $base_model;
    private $propuestas_model;
    
    public function __construct() {
        parent:: __construct();
        $this->propuestas_model = new PropuestasModel();
        $this->asociados_model = new AsociadosModel();
        $this->base_model = new BaseModel();
    }

    public function temas() {
        $view = "propuestas.temas";
        $data["title"] = traducir("asambleas.titulo_propuestas_temas");
        $data["subtitle"] = "";
        $data["tabla"] = $this->propuestas_model->tabla()->HTML();
        $data["tabla_asociados"] = $this->asociados_model->tabla()->HTML();
        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';

        $botones[3] = '<button disabled="disabled" tecla_rapida="F8" style="margin-right: 5px;" class="btn btn-default btn-sm" id="traducir-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/traducir.png').'"><br>'.traducir("asambleas.traducir").'</button>';
        $botones[4] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="votacion-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/votacion.png').'"><br>'.traducir("asambleas.votacion").'</button>';

        $botones[5] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ver-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/documento.png').'"><br>'.traducir("traductor.ver").'</button>';

        $botones[6] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="listado-propuesta-tema"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/listado.png').'"><br>'.traducir("asambleas.listado").'</button>';
        
        // $botones[7] = ' ';
       

        $data["botones"] = $botones;
        
        $data["scripts"] = $this->cargar_js(["propuestas_temas.js?21120211722"]);
        return parent::init($view, $data);  

      
       
    }


    public function elecciones() {
        $view = "propuestas.elecciones";
        $data["title"] = traducir("asambleas.titulo_propuestas_elecciones");
        $data["subtitle"] = "";
        $data["tabla"] = $this->propuestas_model->tabla_propuestas_elecciones()->HTML();
        $data["tabla_propuestas_elecciones_origen"] = $this->propuestas_model->tabla_propuestas_elecciones_origen()->HTML();
        $data["tabla_asociados"] = $this->asociados_model->tabla()->HTML();
        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';

        $botones[3] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="traducir-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/traducir.png').'"><br>'.traducir("asambleas.traducir").'</button>';

        $botones[4] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="votacion-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/votacion.png').'"><br>'.traducir("asambleas.votacion").'</button>';

        $botones[5] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="ver-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/documento.png').'"><br>'.traducir("traductor.ver").'</button>';

        $botones[6] = '<button disabled="disabled" tecla_rapida="F10" style="margin-right: 5px;" class="btn btn-default btn-sm" id="listado-propuesta-eleccion"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/listado.png').'"><br>'.traducir("asambleas.listado").'</button>';

        $data["botones"] = $botones;
        $data["scripts"] = $this->cargar_js(["propuestas_elecciones.js?2112021"]);
        return parent::init($view, $data);  
    }

    public function buscar_datos() {
        $con_votacion = (isset($_REQUEST["con_votacion"])) ? $_REQUEST["con_votacion"] : "N";
        $json_data = $this->propuestas_model->tabla($con_votacion)->obtenerDatos();
        echo json_encode($json_data);
    }

    public function buscar_datos_elecciones() {
        $con_votacion = (isset($_REQUEST["con_votacion"])) ? $_REQUEST["con_votacion"] : "N";
      
        $json_data = $this->propuestas_model->tabla_propuestas_elecciones($con_votacion)->obtenerDatos();
        echo json_encode($json_data);
    }

    public function buscar_datos_elecciones_origen() {
      
     
        $json_data = $this->propuestas_model->tabla_propuestas_elecciones_origen()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_propuestas_temas(Request $request) {

        $array_traducciones = array();
        
        try {
            DB::beginTransaction();
            // print_r($_REQUEST); 
            // exit;
            if(isset($_POST["pt_digitar"])) {
                $_POST["pt_digitar"] = "S";
                $_POST["idunion"] = -1;
                $_POST["idmision"] = -1;
            }  else {
                $_POST["pt_digitar"] = "N";
                $_POST["pt_union"] = "-.-";
                $_POST["pt_mision"] = "-.-";
            }




            $idioma = (isset($_REQUEST["tpt_idioma"])) ? $_REQUEST["tpt_idioma"] : "";
            foreach ($_REQUEST as $key => $value) {
            // $arr = explode("_traduccion", $key);
                if(strpos($key, "_traduccion") !== false) {

                    if(!empty($value)) {
                        $array_traducciones[str_replace("_traduccion","",$key)] = $value;

                        if(str_replace("_traduccion","",$key) == "tpt_idioma") {
                            $idioma = $value;
                        }
                    }
                    
                    // echo $key." -> ". $value." ".str_replace("_traduccion","",$key)."\n";
                }

            }
            // print_r($array_traducciones); 
            // exit;
            $_POST = $this->toUpper($_POST, ["pt_email", "tpt_idioma", "lugar", "tabla"]);
           
            $asamblea = array();
            $pais = array();
            if(isset($_POST["asamblea_id"])) {
                $asamblea = explode("|", $_POST["asamblea_id"]);
            }

            if(isset($_POST["pais_id"])) {
                $pais = explode("|", $_POST["pais_id"]);
            }
            
            $_POST["asamblea_id"] = "";
            $_POST["pais_id"] = "";
        
            $_POST["pt_fecha_reunion_cpag"] = $this->FormatoFecha($_REQUEST["pt_fecha_reunion_cpag"], "server");
            $_POST["pt_fecha_reunion_uya"] = $this->FormatoFecha($_REQUEST["pt_fecha_reunion_uya"], "server");

            if(count($asamblea) > 1) {
                $_POST["asamblea_id"] = $asamblea[1];
            }

            if(count($pais) > 1) {
                $_POST["pais_id"] = $pais[0];
            }
            // print_r($_POST); exit;
            // print_r($this->preparar_datos("asambleas.propuestas_temas", $_POST));
            if ($request->input("pt_id") == '') {
                $_POST["pt_fecha"] = date("Y-m-d");
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.propuestas_temas", $_POST));
            }else{
                $result = $this->base_model->modificar($this->preparar_datos("asambleas.propuestas_temas", $_POST));
            }
            $_POST["pt_id"] = $result["id"];
            DB::table("asambleas.traduccion_propuestas_temas")->where("pt_id", $result["id"])->where("tpt_idioma", $idioma)->delete();
            // print_r($array_traducciones);
            if(count($array_traducciones) > 0){
                // print_r($this->preparar_datos("asambleas.traduccion_propuestas_temas", $array_traducciones));
                $array_traducciones["pt_id"] = $_POST["pt_id"];
                $array_traducciones = $this->toUpper($array_traducciones, ["tpt_idioma"]);
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.traduccion_propuestas_temas", $array_traducciones));
                
            } else {
                // print_r($this->preparar_datos("asambleas.traduccion_propuestas_temas", $_POST));
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.traduccion_propuestas_temas", $_POST));
            }

            DB::table("asambleas.propuestas_origen")->where("pt_id", $_POST["pt_id"] )->delete();
            if(isset($_REQUEST["pt_id_origen"])) {
                // $_POST["idunion"] = $result["id"];
                
                $this->base_model->insertar($this->preparar_datos("asambleas.propuestas_origen", $_POST, "D"), "D");
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


    public function guardar_propuestas_elecciones(Request $request) {
    //    exit;

        $array_traducciones = array();
        
        
        try {
            DB::beginTransaction();

            if(isset($_POST["asamblea_id"])) {
                $asamblea =  explode("|", $_POST["asamblea_id"]);
                if(count($asamblea) > 1) {

                    $_POST["asamblea_id"] = $asamblea[1];
                } 
            }
            
            

            $idioma = (isset($_REQUEST["tpe_idioma"])) ? $_REQUEST["tpe_idioma"] : "";
            foreach ($_REQUEST as $key => $value) {
            // $arr = explode("_traduccion", $key);
                if(strpos($key, "_traduccion") !== false) {

                    if(!empty($value)) {
                        $array_traducciones[str_replace("_traduccion","",$key)] = $value;

                        if(str_replace("_traduccion","",$key) == "tpe_idioma") {
                            $idioma = $value;
                        }
                    }
                    
                    // echo $key." -> ". $value." ".str_replace("_traduccion","",$key)."\n";
                }

            }

            $_POST = $this->toUpper($_POST, ["tpe_idioma"]);
            // print_r($array_traducciones); exit;

            if ($request->input("pe_id") == '') {
                $_POST["pe_fecha"] = date("Y-m-d");
                $sql = "SELECT COALESCE(MAX(pe_correlativo) + 1, 1) AS correlativo FROM asambleas.propuestas_elecciones  WHERE date_part('year', pe_fecha)=".date("Y");
                $correlativo = DB::select($sql);
                $_POST["pe_correlativo"] = $correlativo[0]->correlativo;
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.propuestas_elecciones", $_POST));
            }else{
                $result = $this->base_model->modificar($this->preparar_datos("asambleas.propuestas_elecciones", $_POST));
            }

            // print_r($result);
            $_POST["pe_id"] = $result["id"];

            // DB::table("asambleas.detalle_propuestas")->where("pe_id", $request->input("pe_id"))->where("dp_idioma", $idioma)->delete();
            if(isset($_REQUEST["dp_descripcion"]) && gettype($_REQUEST["dp_descripcion"]) == "array" && count($_REQUEST["dp_descripcion"]) > 0) {
                DB::table("asambleas.detalle_propuestas")->where("pe_id", $request->input("pe_id"))->delete();
            
                
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.detalle_propuestas", $_POST, "D"), "D");
            
            }



            DB::table("asambleas.traduccion_propuestas_elecciones")->where("pe_id", $_POST["pe_id"])->where("tpe_idioma", $idioma)->delete();
            // print_r($array_traducciones);
            if(count($array_traducciones) > 0){
                // print_r($this->preparar_datos("asambleas.traduccion_propuestas_elecciones", $array_traducciones));
                $array_traducciones["pe_id"] = $_POST["pe_id"];
                $array_traducciones = $this->toUpper($array_traducciones, ["tpe_idioma"]);
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.traduccion_propuestas_elecciones", $array_traducciones));
                
            } else {
                // print_r($this->preparar_datos("asambleas.traduccion_propuestas_elecciones", $_POST));
                $result = $this->base_model->insertar($this->preparar_datos("asambleas.traduccion_propuestas_elecciones", $_POST));
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

    public function eliminar_propuestas_temas() {
       

        try {
            $sql_detalle_traduccion = "SELECT * FROM asambleas.traduccion_propuestas_temas WHERE pt_id=".$_REQUEST["id"];
            $detalle_traduccion  = DB::select($sql_detalle_traduccion);

            if(count($detalle_traduccion) > 0) {
                throw new Exception(traducir("asambleas.eliminar_propuesta_temas_traduccion"));
            }

           

            $result = $this->base_model->eliminar(["asambleas.propuestas_temas","pt_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }

    public function eliminar_propuestas_elecciones() {
       

        try {
            // $sql_agenda = "SELECT * FROM asambleas.agenda WHERE pt_id=".$_REQUEST["id"];
            // $agenda = DB::select($sql_agenda);

            // if(count($agenda) > 0) {
            //     throw new Exception(traducir("asambleas.eliminar_asamblea_agenda"));
            // }

            $sql_detalle_traduccion = "SELECT * FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=".$_REQUEST["id"];
            $detalle_traduccion  = DB::select($sql_detalle_traduccion);

            if(count($detalle_traduccion) > 0) {
                throw new Exception(traducir("asambleas.eliminar_propuesta_eleccion_traduccion"));
            }


            $sql_detalle = "SELECT * FROM asambleas.detalle_propuestas WHERE pe_id=".$_REQUEST["id"];
            $detalle  = DB::select($sql_detalle);

            if(count($detalle) > 0) {
                throw new Exception(traducir("asambleas.eliminar_propuesta_eleccion_detalle"));
            }


           

            $result = $this->base_model->eliminar(["asambleas.propuestas_elecciones","pe_id"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }


    public function get_propuestas_temas(Request $request) {
        $id = explode("|", $_REQUEST["id"]);
        $pt_id = $id[0];
        $idioma_codigo = $id[1];

        $sql = "SELECT pt.*, (pt.pais_id || '|' || p.posee_union) AS pais_id , (m.apellidos || ', ' || m.nombres) AS asociado, tpt.*, pt.pt_id, a.*, v.*, (tc.tipconv_id || '|' || pt.asamblea_id) AS asamblea_id, pt.estado, CASE WHEN tpt.tpt_idioma IS NULL THEN '".$idioma_codigo."' ELSE tpt.tpt_idioma END AS tpt_idioma, pt.tabla, r.resolucion_id FROM asambleas.propuestas_temas AS pt 
        INNER JOIN asambleas.asambleas AS a ON(a.asamblea_id=pt.asamblea_id)
        INNER JOIN asambleas.tipo_convocatoria AS tc ON(a.tipconv_id=tc.tipconv_id)
        LEFT JOIN iglesias.miembro AS m ON(m.idmiembro=pt.pt_dirigido_por_uya)
        LEFT JOIN iglesias.paises AS p ON(p.pais_id=pt.pais_id)
        LEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='{$idioma_codigo}')
        LEFT JOIN asambleas.votaciones AS v ON(v.propuesta_id=pt.pt_id AND v.tabla='asambleas.propuestas_temas' AND v.estado='A')
        LEFT JOIN asambleas.resultados AS r ON(r.votacion_id=v.votacion_id)
        WHERE pt.pt_id=".$pt_id."
        ORDER BY tpt.tpt_id DESC LIMIT 1";
        $one = DB::select($sql);
        echo json_encode($one);
    }


    
    public function get_propuestas_elecciones(Request $request) {
        $id = explode("|", $_REQUEST["id"]);
        $pe_id = $id[0];
        $idioma_codigo = $id[1];

        $sql = "SELECT v.*, tpe.*, pe.*, CASE WHEN tpe.tpe_idioma IS NULL THEN '".$idioma_codigo."' ELSE tpe.tpe_idioma END AS tpe_idioma, (tc.tipconv_id || '|' || pe.asamblea_id) AS asamblea_id, r.resolucion_id FROM asambleas.propuestas_elecciones AS pe 
        INNER JOIN asambleas.asambleas AS a ON(a.asamblea_id=pe.asamblea_id)
        INNER JOIN asambleas.tipo_convocatoria AS tc ON(a.tipconv_id=tc.tipconv_id)
        LEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id AND tpe.tpe_idioma='{$idioma_codigo}')
        LEFT JOIN asambleas.votaciones AS v ON(v.propuesta_id=pe.pe_id AND v.tabla='asambleas.propuestas_elecciones' AND v.estado='A')
        LEFT JOIN asambleas.resultados AS r ON(r.votacion_id=v.votacion_id)
        WHERE pe.pe_id=".$pe_id."
         ORDER BY tpe.tpe_id DESC LIMIT 1";
        $one = DB::select($sql);
        echo json_encode($one);
    }

    public function obtener_detalle_propuesta(Request $request) {
        $sql = "SELECT *
        FROM asambleas.detalle_propuestas AS dp 
      
        WHERE dp.pe_id={$request->input("pe_id")} /*AND dp.dp_idioma='{$request->input("idioma")}'*/";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }

    

    public function obtener_anios() {
        $result = array();
        $array = array();
        for($i=date("Y"); $i < date("Y") + 10; $i++ ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        echo json_encode($array);
    }


    public function obtener_tipo_convocatoria() {
        $sql = "SELECT  tc.tipconv_id  AS id, tc.tipconv_descripcion AS descripcion
        FROM asambleas.tipo_convocatoria AS tc";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_asambleas() {
        $sql = "SELECT  a.pt_id  AS id, a.asamblea_descripcion AS descripcion
        FROM asambleas.propuestas_temas AS a
        WHERE a.estado='A'";
        // die($sql);
        $result = DB::select($sql);
        echo json_encode($result);
    }


    public function obtener_correlativo() {
        $sql = "SELECT COALESCE(MAX(pt_correlativo) + 1, 1) AS correlativo FROM asambleas.propuestas_temas  WHERE date_part('year', pt_fecha)=".date("Y");

        $correlativo = DB::select($sql);

        echo json_encode($correlativo);
    }

    public function obtener_categorias_propuestas() {
        $sql = "SELECT cp_id as id, cp_descripcion AS descripcion FROM asambleas.categorias_propuestas 
        WHERE estado='A'
        ORDER BY cp_descripcion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }
    

    
    public function obtener_formas_votacion(Request $request) {
        $sql = "SELECT fv_id as id, fv_descripcion AS descripcion FROM asambleas.formas_votacion
        WHERE estado='A' AND fv_tipo='{$request->input("fv_tipo")}'
        ORDER BY fv_descripcion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function get_votaciones() {
        $id = (empty($_REQUEST["id"])) ? 0 : $_REQUEST["id"];
        $sql = "SELECT * FROM asambleas.votaciones
        WHERE votacion_id={$id} AND estado = 'A'";
        $result = DB::select($sql);

        echo json_encode($result);
    }

    public function guardar_votaciones(Request $request) {
        // print_r($_REQUEST); exit;
        $update_propuesta = array();
        try {
            DB::beginTransaction();

            if(isset($_POST["asamblea_id"])) {
                $asamblea =  explode("|", $_POST["asamblea_id"]);
                if(count($asamblea) > 1) {

                    $_POST["asamblea_id"] = $asamblea[1];
                } 
            }
            
            
            
            // exit;
          
            if($request->input("estado") == "A") {
                if ($request->input("votacion_id") == '') {
                    $_POST["votacion_fecha"] = date("Y-m-d H:i:s");
                    $result = $this->base_model->insertar($this->preparar_datos("asambleas.votaciones", $_POST));
                }else{
                    $result = $this->base_model->modificar($this->preparar_datos("asambleas.votaciones", $_POST));
                }
               
               
                // print_R($result); exit;
                if($request->input("tabla") == "asambleas.propuestas_temas") {
                    $update_propuesta["pt_id"] = $request->input("propuesta_id");
                    $update_propuesta["pt_someter_votacion"] = "S";
                } elseif($request->input("tabla") == "asambleas.propuestas_elecciones") {
                    $update_propuesta["pe_id"] = $request->input("propuesta_id");
                    $update_propuesta["pe_someter_votacion"] = "S";
                }

                
            } elseif($request->input("estado") == "I") {
                $update_votacion["votacion_id"] = $request->input("votacion_id");
                $update_votacion["estado"] = "I";
                $result = $this->base_model->modificar($this->preparar_datos("asambleas.votaciones", $update_votacion));

                if($request->input("tabla") == "asambleas.propuestas_temas") {
                    $update_propuesta["pt_id"] = $request->input("propuesta_id");
                    $update_propuesta["pt_someter_votacion"] = "N";
                } elseif($request->input("tabla") == "asambleas.propuestas_elecciones") {
                    $update_propuesta["pe_id"] = $request->input("propuesta_id");
                    $update_propuesta["pe_someter_votacion"] = "N";
                }
                
            }
            $r = $this->base_model->modificar($this->preparar_datos($request->input("tabla"), $update_propuesta));
            // print_r($this->preparar_datos($request->input("tabla"), $update_propuesta));     exit;

            if($request->input("estado") == "I") {
                DB::commit();
                echo json_encode($result);
                exit;
            }
           
            $sql_forma_votacion = "SELECT fv.*, v.propuesta_id, v.tabla, v.asamblea_id, v.votacion_id
            FROM asambleas.votaciones AS v
            INNER JOIN asambleas.formas_votacion AS fv ON(v.fv_id=fv.fv_id) 
            WHERE v.votacion_id={$result["id"]} AND v.estado='A'";

            $result["formas_votacion"] = DB::select($sql_forma_votacion);
            $result["formas_votacion"][0]->items = array();

            // print_r($result); exit;
            if($request->input("tabla") == "asambleas.propuestas_temas") {

                $sql_propuestas = "SELECT CASE WHEN tpt.tpt_titulo IS NULL THEN '' ELSE tpt.tpt_titulo END AS propuesta, tpt.tpt_idioma AS idioma_codigo FROM asambleas.propuestas_temas AS pt
                INNER JOIN asambleas.traduccion_propuestas_temas AS tpt ON(pt.pt_id=tpt.pt_id)
                WHERE pt.pt_id = {$result["formas_votacion"][0]->propuesta_id}";
                $propuestas = DB::select($sql_propuestas);

            } elseif($request->input("tabla") == "asambleas.propuestas_elecciones") {

                $sql_propuestas = "SELECT CASE WHEN tpe.tpe_descripcion IS NULL THEN '' ELSE tpe.tpe_descripcion END AS propuesta, tpe.tpe_idioma AS idioma_codigo FROM asambleas.propuestas_elecciones AS pe
                INNER JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(pe.pe_id=tpe.pe_id)
                WHERE pe.pe_id = {$result["formas_votacion"][0]->propuesta_id}";

                $propuestas = DB::select($sql_propuestas);
            }
           
            if($result["formas_votacion"][0]->fv_id == 3) {
                $sql_asistencia = "SELECT m.idmiembro AS id, (m.apellidos || ', ' || m.nombres) AS descripcion FROM asambleas.asistencia AS a
                INNER JOIN asambleas.detalle_asistencia AS da ON(a.asistencia_id=da.asistencia_id)
                INNER JOIN iglesias.miembro AS m ON(m.idmiembro=da.idmiembro)
                WHERE a.estado='A' AND a.asamblea_id={$result["formas_votacion"][0]->asamblea_id}";
                $result["formas_votacion"][0]->items = DB::select($sql_asistencia);
            }

            if($result["formas_votacion"][0]->fv_id == 6) {
                $sql_detalle_propuesta = "SELECT dp.dp_id AS id, dp.dp_descripcion AS descripcion FROM asambleas.propuestas_elecciones AS pe
                INNER JOIN asambleas.detalle_propuestas AS dp ON(dp.pe_id=pe.pe_id)
                WHERE pe.estado='A' AND pe.pe_id={$result["formas_votacion"][0]->propuesta_id}";
                // die($sql_detalle_propuesta);
                $result["formas_votacion"][0]->items = DB::select($sql_detalle_propuesta);
            }
            // print_r($propuestas); exit;
            $result["formas_votacion"][0]->propuestas = $propuestas;
            if($result["formas_votacion"][0]->fv_id == 5) {
                // $sql_detalle_propuesta = "SELECT dp.dp_id AS id, dp.dp_descripcion AS descripcion FROM asambleas.propuestas_elecciones AS pe
                // INNER JOIN asambleas.detalle_propuestas AS dp ON(dp.pe_id=pe.pe_id)
                // WHERE pe.estado='A' AND pe.pe_id={$result["formas_votacion"][0]->propuesta_id} AND dp.dp_idioma='".session("idioma_codigo")."'";
                // $result["formas_votacion"][0]->items = DB::select($sql_detalle_propuesta);
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

    
    public function imprimir_propuesta_tema($pt_id) {

        $sql = "SELECT tpt.*, pt.*, a.*, ".formato_fecha_idioma(" a.asamblea_fecha_inicio")." AS asamblea_fecha_inicio, ".formato_fecha_idioma(" a.asamblea_fecha_fin")." AS asamblea_fecha_fin, p.descripcion AS pais, tc.*, (m.apellidos || ', ' || m.nombres) AS responsable, ".formato_fecha_idioma("pt.pt_fecha_reunion_uya")." AS pt_fecha_reunion_uya
        
        FROM asambleas.propuestas_temas AS pt
        INNER JOIN asambleas.asambleas AS a ON(pt.asamblea_id=a.asamblea_id)
        LEFT JOIN public.pais AS p ON(p.idpais=a.idpais)
        LEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".session("idioma_codigo")."')
        LEFT JOIN asambleas.tipo_convocatoria AS tc ON(tc.tipconv_id=a.tipconv_id)
        LEFT JOIN iglesias.miembro AS m ON(pt.pt_dirigido_por_uya=m.idmiembro)
        WHERE pt.pt_id={$pt_id}";
        $propuesta = DB::select($sql);

        $sql = "SELECT * FROM asambleas.categorias_propuestas WHERE estado='A'";
        $categorias = DB::select($sql);
        

        $datos["propuesta"] = $propuesta;
        $datos["categorias"] = $categorias;

        $datos["nivel_organizativo"] = session("nivel_organizativo"); 
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("propuestas.imprimir", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("propuesta_tema.pdf"); // ver
    }
    

    public function obtener_propuestas_temas_origen() {
        
        $where = (isset($_REQUEST["pt_id"]) && !empty($_REQUEST["pt_id"])) ?  " AND pt.pt_id NOT IN({$_REQUEST["pt_id"]})" : "";
        $sql = "SELECT pt.pt_id AS id, CASE WHEN tpt.tpt_titulo IS NULL THEN
        (SELECT tpt_titulo FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."')
        ELSE tpt.tpt_titulo END AS descripcion
        FROM asambleas.propuestas_temas AS pt
        INNER JOIN iglesias.paises AS p on(p.pais_id=pt.pais_id)
        LEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".trim(session("idioma_codigo"))."')
        WHERE pt.estado='A' {$where}
        ORDER BY tpt.tpt_titulo ASC";
        // die($sql);

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_propuestas_origen(Request $request) {
        $sql = "SELECT * FROM asambleas.propuestas_origen 
        WHERE pt_id={$request->input("pt_id")}"; 

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_descripciones_propuestas_origen(Request $request) {
        
        $in = "";

        if(!empty($_REQUEST["pt_id_origen"])) {
            $in = " AND pt.pt_id IN(".$request->input("pt_id_origen").")";
        }
      
        $sql = "SELECT *
        FROM asambleas.propuestas_temas AS pt
        INNER JOIN iglesias.paises AS p on(p.pais_id=pt.pais_id)
        LEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".$request->input("tpt_idioma")."')
        WHERE pt.estado='A' {$in}
        ORDER BY tpt.tpt_titulo ASC";
        // die($sql);

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_resultados(Request $request) {


        $resultados = $this->procesar_resultados($request);

        $sql_resultados = "SELECT * FROM asambleas.resultados AS r
        INNER JOIN asambleas.votaciones AS v ON(r.votacion_id=v.votacion_id)
        WHERE r.votacion_id={$resultados[0]->votacion_id}
        ORDER BY r.resultado_total DESC";

        $resultados = DB::select($sql_resultados);

        echo json_encode($resultados);
    }

    public function guardar_resultados(Request $request) {
        // $update = array();
        // $update["resultado_id"] = $request->input("resultado_id");
        // $update["resultado_mano_alzada"] = $request->input("resultado_mano_alzada");

        $result = $this->base_model->modificar($this->preparar_datos("asambleas.resultados", $_REQUEST));
        echo json_encode($result);
 
    }

    public function guardar_ganador(Request $request) {
        $update = array();
        $update["resultado_id"] = $request->input("resultado_id");
        $update["resultado_ganador"] = $request->input("resultado_ganador");
        
        $result = $this->base_model->modificar($this->preparar_datos("asambleas.resultados", $update));
        echo json_encode($result);
 
    }
    

    public function obtener_descripcion_propuestas(Request $request) {
        if($request->input("tabla") == "asambleas.propuestas_temas") {
            $sql = "SELECT CASE WHEN tpt.tpt_titulo IS NULL THEN (SELECT tpt_titulo FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."') ELSE tpt.tpt_titulo  END AS tr_titulo_propuesta ,

            CASE WHEN tpt.tpt_propuesta IS NULL THEN (SELECT tpt_propuesta FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."') ELSE tpt.tpt_propuesta  END AS tr_propuesta 
            FROM asambleas.propuestas_temas AS pt
            
            LEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='{$request->input("tr_idioma")}')
            WHERE pt.pt_id = {$request->input("propuesta_id")}";
        }


        if($request->input("tabla") == "asambleas.propuestas_elecciones") {
            $sql = "SELECT  CASE WHEN tpe.tpe_descripcion IS NULL THEN (SELECT tpe_descripcion FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_descripcion  END AS tr_titulo_propuesta ,
            CASE WHEN tpe.tpe_detalle_propuesta IS NULL THEN (SELECT tpe_detalle_propuesta FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_detalle_propuesta  END AS tr_propuesta 
            
            FROM asambleas.propuestas_elecciones AS pe
            LEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id AND tpe.tpe_idioma='{$request->input("tr_idioma")}')
            WHERE pe.pe_id = {$request->input("propuesta_id")}";
        }
        $result = DB::select($sql);
        

        echo json_encode($result);
    }

    public function obtener_ganadores(Request $request) {
        $sql = "SELECT * FROM asambleas.resultados AS r 
        WHERE r.resolucion_id={$request->input("resolucion_id")} AND r.resultado_ganador='S'";
        $result = DB::select($sql);
        echo json_encode($result);
    }


    public function imprimir_propuestas_temas() {

        $sql = "SELECT ".formato_fecha_idioma(" pt.pt_fecha")." AS fecha, pt.pt_correlativo AS correlativo, 
        CASE WHEN tpt.tpt_titulo IS NULL THEN (SELECT tpt_titulo FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."') ELSE tpt.tpt_titulo  END AS titulo, 
        p.pais_descripcion AS pais, pt.lugar AS de, CASE 
        WHEN pt.pt_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN pt.pt_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN pt.pt_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS estado_propuesta, 
        CASE WHEN pt.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado
        FROM asambleas.propuestas_temas AS pt
        \nINNER JOIN iglesias.paises AS p on(p.pais_id=pt.pais_id)
        \nLEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".session("idioma_codigo")."')
        ORDER BY pt.pt_id DESC";
        $propuestas = DB::select($sql);

    
        $datos["propuestas"] = $propuestas;

        $datos["nivel_organizativo"] = session("nivel_organizativo"); 
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("propuestas.imprimir_propuestas_temas", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("listado_propuestas_temas.pdf"); // ver
    }


    public function imprimir_propuestas_elecciones() {

        $sql = "SELECT ".formato_fecha_idioma(" pe.pe_fecha")." AS fecha, 
        CASE WHEN tpe.tpe_descripcion IS NULL THEN (SELECT tpe_descripcion FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_descripcion  END AS descripcion, 

        CASE WHEN tpe.tpe_detalle_propuesta IS NULL THEN (SELECT tpe_detalle_propuesta FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_detalle_propuesta END  AS detalle_propuesta, 
        
        CASE 
        WHEN pe.pe_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN pe.pe_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN pe.pe_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS estado_propuesta, 
        CASE WHEN pe.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado
        FROM asambleas.propuestas_elecciones AS pe
        \nLEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id AND tpe.tpe_idioma='".trim(session("idioma_codigo"))."')
        ORDER BY pe.pe_id DESC";
        $propuestas = DB::select($sql);

    
        $datos["propuestas"] = $propuestas;

        $datos["nivel_organizativo"] = session("nivel_organizativo"); 
        // referencia: https://styde.net/genera-pdfs-en-laravel-con-el-componente-dompdf/
        $pdf = PDF::loadView("propuestas.imprimir_propuestas_elecciones", $datos);

        // return $pdf->save("ficha_asociado.pdf"); // guardar
        // return $pdf->download("ficha_asociado.pdf"); // descargar
        return $pdf->stream("listado_propuestas_elecciones.pdf"); // ver
    }
}
