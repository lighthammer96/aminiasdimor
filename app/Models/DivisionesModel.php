<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class DivisionesModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-divisiones");
        $tabla->agregarColumna("d.iddivision", "iddivision", "Id");
        $tabla->agregarColumna("d.iddivision", "iddivision", "iddivision");
        $tabla->agregarColumna("di.di_descripcion", "descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("d.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("d.iddivision, CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
        ELSE di.di_descripcion END AS descripcion,
        CASE WHEN d.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, d.estado AS state");
        $tabla->setFrom("iglesias.division AS d
        \nLEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")");

        return $tabla;
    }

    public function obtener_divisiones($request) {
        $sql = "";
        // $defecto = "";
        // if(session("perfil_id") != 1 && session("perfil_id") != 2) {
        //     $defecto = ", 'S' AS defecto";
        // }
        $all = false;
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT d.iddivision AS id, CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS descripcion
            FROM iglesias.division AS d
            LEFT JOIN iglesias.division_idiomas AS di ON(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
            WHERE d.estado='1' AND d.iddivision=".$request->input("iddivision").
            " ORDER BY di.di_descripcion ASC";
		} else {
            $sql = "SELECT d.iddivision AS id,  CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS descripcion
            FROM iglesias.division AS d
            LEFT JOIN iglesias.division_idiomas AS di ON(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
            WHERE d.estado='1' ".session("where_division").
            " ORDER BY di.di_descripcion ASC";
            $all = true;
		}
        // die($sql);
        $result = DB::select($sql);
        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2 && $all) {
            // print_r($result);
            $result[0]->defecto = "S";
        }
        return $result;
    }

    public function obtener_divisiones_todos($request) {
        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT d.iddivision AS id, CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS descripcion
            FROM iglesias.division AS d
            LEFT JOIN iglesias.division_idiomas AS di ON(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
            WHERE d.estado='1' AND d.iddivision=".$request->input("iddivision").
            " ORDER BY di.di_descripcion ASC";
		} else {
            $sql = "SELECT d.iddivision AS id,  CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS descripcion
            FROM iglesias.division AS d
            LEFT JOIN iglesias.division_idiomas AS di ON(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
            WHERE d.estado='1'
            ORDER BY di.di_descripcion ASC";
		}
        // die($sql);
        $result = DB::select($sql);
        return $result;
    }

    public function obtener_divisiones_all($request) {
        $array = array("id" => "-1", "descripcion" => "Todos");
        $array = (object) $array;


        $sql = "";
		if(isset($_REQUEST["iddivision"]) && !empty($_REQUEST["iddivision"])) {

			$sql = "SELECT d.iddivision AS id, CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS descripcion
            FROM iglesias.division AS d
            LEFT JOIN iglesias.division_idiomas AS di ON(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
            WHERE d.estado='1' AND d.iddivision=".$request->input("iddivision")." ".session("where_division").
            " ORDER BY di.di_descripcion ASC";
		} else {
            $sql = "SELECT d.iddivision AS id,  CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS descripcion
            FROM iglesias.division AS d
            LEFT JOIN iglesias.division_idiomas AS di ON(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")
            WHERE d.estado='1' ".session("where_division").
            " ORDER BY di.di_descripcion ASC";
		}
        // die($sql);

        $result = DB::select($sql);
        array_push($result, $array);
        return $result;
    }
}
