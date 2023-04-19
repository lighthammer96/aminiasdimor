<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class DistritosmisionerosModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-distritos-misioneros");
        $tabla->agregarColumna("dm.iddistritomisionero", "iddistritomisionero", "Id");
        $tabla->agregarColumna("dm.iddistritomisionero", "iddistritomisionero", "iddistritomisionero");
        $tabla->agregarColumna("dm.descripcion", "descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("m.descripcion", "mision", traducir('traductor.asociacion'));
        $tabla->agregarColumna("dm.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("dm.iddistritomisionero, dm.descripcion, m.descripcion AS mision, CASE WHEN dm.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, dm.estado AS state");
        $tabla->setFrom("iglesias.distritomisionero AS dm
        \nLEFT JOIN iglesias.mision AS m ON(dm.idmision=m.idmision)");

        return $tabla;
    }

    public function obtener_distritos_misioneros($request) {
        $sql = "";
        $all = false;
        $result = array();
		if(isset($_REQUEST["idmision"]) && !empty($_REQUEST["idmision"])) {

			$sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' AND idmision=".$request->input("idmision")." ".session("where_distrito_misionero").
            " ORDER BY descripcion ASC";
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            $sql = "SELECT iddistritomisionero AS id, descripcion
            FROM iglesias.distritomisionero WHERE estado='1' ".session("where_distrito_misionero").session("where_mision_padre").
            " ORDER BY descripcion ASC";
            $all = true;
		}

        if($sql != "") {
            $result = DB::select($sql);
        }

        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2 && $all) {
            // print_r($result);
            $result[0]->defecto = "S";
        }

        return $result;
    }

    public function obtener_distritos_misioneros_todos($request) {
        $sql = "";
		if(isset($_REQUEST["idmision"]) && !empty($_REQUEST["idmision"])) {

			$sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' AND idmision=".$request->input("idmision").
            " ORDER BY descripcion ASC";
		} else {
            $sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' ".
            " ORDER BY descripcion ASC";
		}

        $result = DB::select($sql);
        return $result;
    }

    public function obtener_distritos_misioneros_all($request) {
        $array = array("id" => "-1", "descripcion" => "Todos");
        $array = (object) $array;
        $sql = "";
        $result = array();
		if(isset($_REQUEST["idmision"]) && !empty($_REQUEST["idmision"])) {

			$sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' AND idmision=".$request->input("idmision")." ".session("where_distrito_misionero").
            " ORDER BY descripcion ASC";
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            // $sql = "SELECT iddistritomisionero AS id, descripcion FROM iglesias.distritomisionero WHERE estado='1' ".session("where_distrito_misionero").
            // " ORDER BY descripcion ASC";
		}

        if($sql != "") {
            $result = DB::select($sql);
        }
        array_push($result, $array);
        return $result;
    }

}
