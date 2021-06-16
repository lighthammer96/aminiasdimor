<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
// use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;


    private $base_model;

    public function __construct() {
        $this->base_model = new BaseModel();    
       
       
    }

    public function getDate() {
        return date("Y-m-d");
    }

    public function init($view, $datos = array()) {
      
        // App::setLocale(trim(session("idioma_codigo")));
        // var_dump(session('usuario_id')); exit;
        if (session('usuario_id')) {

            $datos["modulos"]   = $this->base_model->getPermisos(true);
            return view($view, $datos);
        } else {
            // echo "ola";
            return redirect('/');
        }
    }


    public function cargar_css($css_array) {
        for ($i = 0; $i < count($css_array); $i++) {
            // $this->css[] = '<link href="' . URL::asset('app/css/' . $css_array[$i]) . '" rel="stylesheet" />';
            $this->css[] = URL::asset('app/css/' . $css_array[$i]);
        }
        return $this->css;
    }

    public function cargar_js($js_array) {
        for ($i = 0; $i < count($js_array); $i++) {
            //$this->js[] = '<script src="' . URL::asset('app/js/' . $js_array[$i]) . '"></script>';
            $this->js[] =  URL::asset('app/js/' . $js_array[$i]);
        }
        return $this->js;
    }

    public function listar_campos($tabla) {

        $campos = array();
        $tabla = explode(".", $tabla);
        $schema = $tabla[0];
        $table = $tabla[1];

        $sql = "SELECT cols.column_name, cols.data_type
        FROM information_schema.columns cols
        WHERE cols.table_schema='{$schema}' AND cols.table_name= '{$table}'";

        $result = DB::select($sql);

        foreach ($result as $key => $value) {
            array_push($campos, $value->column_name);
        }

        return $campos;
    }

    public function toUpper($fields, $excluidos = array()) {
        foreach ($fields as $key => $value) {

            if (!in_array($key, $excluidos)) {
                if (gettype($value) == 'string') {
                    $fields[$key] = strtr(strtoupper($value), "àèìòùáéíóúçñäëïöü", "ÀÈÌÒÙÁÉÍÓÚÇÑÄËÏÖÜ");
                }
            }
        }
        return $fields;
    }


    /**
    * [preparar_datos description]
    * @param  [type]  $table [la tabla donde se va insertar]
    * @param  [type]  $data  [los request de datos]
    * @param  [type]  $tipoTabla  [N -> si un tabla normal, D -> si un detalle]
    * @return [type]         [array de campo de la respectivaa tabla con su valor del request]
    */
    public function preparar_datos($table, $data, $tipoTabla = 'N') {
        #print_r($data); exit;
        $parametros = array();

        // $tabla  = $this->sinSchema($table);
        //$fields = $this->db->list_fields($tabla);
        $fields = $this->listar_campos($table);
        //print_r(count($data)); exit;
        $datos = array();
        //ordenamos los campos de acuerdo a la tabla que corresponde
        for ($i = 0; $i < count($fields); $i++) {
            if (isset($data[$fields[$i]])) {
                $datos[$fields[$i]] = $data[$fields[$i]];
            }
        }
        // echo $table."\n";
        // echo gettype(array_values($datos)[1])."\n";
        //PONEMOS EN EL PRIMER ELEMENTO A LA CLAVE SE REPITE EN RESTO DE REGISTRO EN EL CASO DE SER UN DETALLE
        if ($tipoTabla == "D") {
            $cantElementos = (is_array(array_values($datos)[1])) ? count(array_values($datos)[1]) : 0;
            $primer_key    = array_keys($datos)[0];
            $primer_value  = array_values($datos)[0];
            for ($i = 0; $i < $cantElementos; $i++) {
                $parametros["datos"][$i][$primer_key] = $primer_value;
            }
        }
        #print_r($datos); exit;

        // cuando es detalle
        if ($tipoTabla == "D") {

            for ($i = 0; $i < $cantElementos; $i++) {
                foreach ($datos as $key => $value) {
                    if ($primer_key != $key) {
                        // para que inserte solo los campos que tiene dicha tabla
                        if (in_array($key, $fields)) {
                            // echo $primer_key." ".$key."\n";
                            @$parametros["datos"][$i][$key] = $value[$i];
                        }
                    }
                }

            }
        } elseif ($tipoTabla == "N") {
            foreach ($datos as $key => $value) {
                if (in_array($key, $fields)) {
                    if ($value != "") {
                        $parametros["datos"][0][$key] = $value;

                    }
                }

            }

        }

        //  $parametros["data"][0] = (object) $parametros["data"][0];
        $parametros["tabla"] = $table;

        return $parametros;
    }

    public function sinSchema($table) {
        $schema = explode(".", $table);
        if (count($schema) > 1) {
            $tabla = $schema[1];
        } else {
            $tabla = $table;
        }
        return $tabla;
    }

    /**
     * [exploderequest lo utilice para el extends de modulos padres]
     * @param  [type] $fields [description]
     * @return [type]         [description]
     */
    public function explode_request($fields) {
        $array = array();
        $cont  = 0;
        foreach ($fields as $key => $value) {
            $arr = explode("|", $key);
            if (count($arr) > 1) {
                $cont++;
                $array[$arr[0]] = $value;
            }
        }

        if ($cont > 0) {
            return $array;
        } else {
            return $fields;
        }

    }

}
