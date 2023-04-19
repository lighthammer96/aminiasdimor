<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class PaisesModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-paises");
        $tabla->agregarColumna("p.pais_id", "pais_id", "Id");
        $tabla->agregarColumna("p.pais_id", "pais_id", "pais_id");
        $tabla->agregarColumna("p.pais_descripcion", "pais_descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("p.direccion", "direccion", traducir('traductor.direccion'));
        $tabla->agregarColumna("p.telefono", "telefono", traducir('traductor.telefono'));
        $tabla->agregarColumna("i.idioma_descripcion", "idioma_descripcion", traducir('traductor.idioma'));
        $tabla->agregarColumna("di.di_descripcion", "division", traducir('traductor.division'));
        $tabla->agregarColumna("p.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("p.pais_id, p.pais_descripcion, p.direccion, p.telefono, i.idioma_descripcion,
        CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
        ELSE di.di_descripcion END AS division
        , CASE WHEN p.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, p.estado AS state");
        $tabla->setFrom("iglesias.paises AS p
        \nLEFT JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
        \nLEFT JOIN iglesias.division AS d ON(d.iddivision=p.iddivision)
        \nLEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")");




        return $tabla;
    }

    public function obtener_paises_asociados($request) {
        $sql = "";
        $all = false;
        $result = array();
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision")." ".session("where_pais").
            " ORDER BY pais_descripcion ASC";
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion
            FROM iglesias.paises
            WHERE estado='A' ".session("where_pais").session("where_division_padre").
            " ORDER BY pais_descripcion ASC";
            $all = true;
		}
        // die($sql);
        if($sql != "") {
            $result = DB::select($sql);
        }
        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2 && $all) {
            // print_r($result);
            $result[0]->defecto = "S";
        }
        return $result;
    }

    public function obtener_todos_paises() {
        $sql = "SELECT idpais AS id, descripcion FROM public.pais
        ORDER BY descripcion ASC";


        $result = DB::select($sql);
        return $result;
    }

    public function obtener_paises($request) {
        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT pais_id  AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision").
            " ORDER BY pais_descripcion ASC";;
		} else {
            $sql = "SELECT pais_id AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A'
            ORDER BY pais_descripcion ASC";
		}

        $result = DB::select($sql);
        return $result;
    }

    public function obtener_paises_asociados_todos($request) {
        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision").
            " ORDER BY pais_descripcion ASC";
		} else {
            $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A'
            ORDER BY pais_descripcion ASC";
		}
        // die($sql);
        $result = DB::select($sql);

        return $result;
    }

    public function obtener_paises_propuestas() {
        $sql = "";
        // var_dump(session("where_pais"));
        $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion,
        CASE WHEN pais_id=".session("pais_id")." THEN 'S' ELSE 'N' END AS defecto
         FROM iglesias.paises WHERE estado='A'
        ORDER BY pais_descripcion ASC";


        $result = DB::select($sql);
        return $result;
    }

    public function obtener_paises_asociados_all($request) {
        $array = array("id" => "-1", "descripcion" => "Todos");
        $array = (object) $array;
        $result = array();
        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' AND iddivision=".$request->input("iddivision")." ".session("where_pais").
            " ORDER BY pais_descripcion ASC";;
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            // $sql = "SELECT pais_id || '|' || posee_union AS id, pais_descripcion AS descripcion FROM iglesias.paises WHERE estado='A' ".session("where_pais").
            // " ORDER BY pais_descripcion ASC";;
		}
        // die($sql);
        if($sql != "") {
            $result = DB::select($sql);
        }
        array_push($result, $array);
        return $result;
    }
}
