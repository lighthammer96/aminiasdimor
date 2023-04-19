<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class MisionesModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-misiones");
        $tabla->agregarColumna("m.idmision", "idmision", "Id");
        $tabla->agregarColumna("m.idmision", "idmision", "idmision");
        $tabla->agregarColumna("m.descripcion", "descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("u.descripcion", "union", traducir('traductor.union'));
        $tabla->agregarColumna("m.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("m.idmision, m.descripcion, u.descripcion AS union, CASE WHEN m.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, m.estado AS state");
        $tabla->setFrom("iglesias.mision AS m
        \nLEFT JOIN iglesias.union AS u ON(m.idunion=u.idunion)");

        return $tabla;
    }

    public function obtener_misiones($request) {
        $sql = "";
        $all = false;
        $result = array();
        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {

			$sql = "SELECT idmision AS id, descripcion, email AS atributo1 FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"]. " ".session("where_mision").
            " ORDER BY descripcion ASC";
        } elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            $sql = "SELECT idmision AS id, descripcion, email AS atributo1
            FROM iglesias.mision WHERE estado='1' ".session("where_mision").session("where_union_padre").
            " ORDER BY descripcion ASC";
            $all = true;
		} else {
            $sql = "SELECT idmision AS id, descripcion, email AS atributo1
            FROM iglesias.mision WHERE estado='1'
            ORDER BY descripcion ASC";
        }
        // var_dump($sql);
        if($sql != "") {
            $result = DB::select($sql);
        }
        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2 && $all) {
            // print_r($result);
            $result[0]->defecto = "S";
        }


        return $result;
    }

    public function obtener_misiones_todos($request) {
        $sql = "";

        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {

			$sql = "SELECT idmision AS id, descripcion FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"].
            " ORDER BY descripcion ASC";
        } else {
            $sql = "SELECT idmision AS id, descripcion
            FROM iglesias.mision WHERE estado='1' ".
            " ORDER BY descripcion ASC";
		}

        $result = DB::select($sql);
        return $result;
    }

    public function obtener_misiones_propuestas($request) {
        $sql = "";

        $result = array();
        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {

			$sql = "SELECT idmision AS id, descripcion, email AS atributo1,
            CASE WHEN idmision=".session("idmision")." THEN 'S' ELSE 'N' END AS defecto
             FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"]. " ".session("where_mision").
            " ORDER BY descripcion ASC";

		} else {
            $sql = "SELECT idmision AS id, descripcion, email AS atributo1,
            CASE WHEN idmision=".session("idmision")." THEN 'S' ELSE 'N' END AS defecto
            FROM iglesias.mision WHERE estado='1' AND idunion=".session("idunion")."
            ORDER BY descripcion ASC";
        }
        // var_dump($sql);
        if($sql != "") {
            $result = DB::select($sql);
        }
        return $result;

    }

    public function obtener_misiones_all() {
        $array = array("id" => "-1", "descripcion" => "Todos");
        $array = (object) $array;
        $sql = "";
        $result = array();
        if(isset($_REQUEST["pais_id"])) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_REQUEST["pais_id"]}";
            $res = DB::select($sql);
            $_REQUEST["idunion"] = $res[0]->idunion;
        }

		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {

			$sql = "SELECT idmision AS id, descripcion FROM iglesias.mision WHERE estado='1' AND idunion=".$_REQUEST["idunion"]. " ".session("where_mision").
            " ORDER BY descripcion ASC";
        } elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            // $sql = "SELECT idmision AS id, descripcion FROM iglesias.mision WHERE estado='1' ".session("where_mision").
            // " ORDER BY descripcion ASC";
		}

        if($sql != "") {
            $result = DB::select($sql);
        }
        array_push($result, $array);
        return $result;
    }

}
