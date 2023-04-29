<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class UnionesModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-uniones");
        $tabla->agregarColumna("u.idunion", "idunion", "Id");
        $tabla->agregarColumna("u.idunion", "idunion", "idunion");
        $tabla->agregarColumna("u.descripcion", "descripcion", traducir('traductor.descripcion'));
       // $tabla->agregarColumna("p.pais_descripcion", "pais_descripcion", traducir('traductor.pais'));
        $tabla->agregarColumna("u.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("u.idunion, u.descripcion, CASE WHEN u.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, u.estado AS state");
        $tabla->setFrom("iglesias.union AS u");

        return $tabla;
    }

    public function obtener_uniones($request) {
        $sql = "";
		if(isset($_REQUEST["idunion"]) && !empty($_REQUEST["idunion"])) {

			$sql = "SELECT idunion AS id, descripcion FROM iglesias.union WHERE estado='1' AND idunion=".$request->input("idunion").
            " ORDER BY descripcion ASC";
		} else {
            $sql = "SELECT idunion AS id, descripcion FROM iglesias.union WHERE estado='1'
            ORDER BY descripcion ASC";
		}

        $result = DB::select($sql);
        return $result;
    }

    public function obtener_uniones_paises($request) {
        $sql = "";
        $all = false;
        $result = array();
		if(isset($_REQUEST["pais_id"]) && !empty($_REQUEST["pais_id"])) {

			$sql = "SELECT u.idunion AS id, u.descripcion, u.email AS atributo1 FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' AND up.pais_id=".$request->input("pais_id")." ".session("where_union").
            " ORDER BY u.descripcion ASC";
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            $sql = "SELECT u.idunion AS id, u.descripcion , u.email AS atributo1
            FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' ".session("where_union").session("where_pais_padre").
            " ORDER BY u.descripcion ASC";
            $all = true;
		}

        if($sql != "") {
            $result = DB::select($sql);
        }

        if(count($result) == 1 && session("perfil_id") != 1 && session("perfil_id") != 2) {
            // print_r($result);
            $result[0]->defecto = "S";
        }
        return $result;
    }

    public function obtener_uniones_paises_todos($request) {
        $sql = "";
		if(isset($_REQUEST["pais_id"]) && !empty($_REQUEST["pais_id"])) {

			$sql = "SELECT u.idunion AS id, u.descripcion FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' AND up.pais_id=".$request->input("pais_id").
            " ORDER BY u.descripcion ASC";
		} else {
            $sql = "SELECT u.idunion AS id, u.descripcion FROM iglesias.union AS u
            WHERE estado='1'
            ORDER BY u.descripcion ASC";
		}

        $result = DB::select($sql);
        return $result;
    }

    public function obtener_uniones_paises_propuestas($request) {
        $sql = "";

        $result = array();
		if(isset($_REQUEST["pais_id"]) && !empty($_REQUEST["pais_id"])) {

			$sql = "SELECT u.idunion AS id, u.descripcion, u.email AS atributo1 ,
             CASE WHEN u.idunion=".session("idunion")." THEN 'S' ELSE 'N' END AS defecto

            FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' AND up.pais_id=".$request->input("pais_id").
            " ORDER BY u.descripcion ASC";
		} else {
            $sql = "SELECT u.idunion AS id, u.descripcion , u.email AS atributo1,
             CASE WHEN u.idunion=".session("idunion")." THEN 'S' ELSE 'N' END AS defecto
            FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' AND up.pais_id=".session("pais_id")."
            ORDER BY u.descripcion ASC";

		}

        if($sql != "") {
            $result = DB::select($sql);
        }
        return $result;
    }

    public function obtener_uniones_paises_all($request) {
        $array = array("id" => "-1", "descripcion" => "Todos");
        $array = (object) $array;
        $sql = "";
        $result = array();
		if(isset($_REQUEST["pais_id"]) && !empty($_REQUEST["pais_id"])) {

			$sql = "SELECT u.idunion AS id, u.descripcion FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(up.idunion=u.idunion)
            WHERE u.estado='1' AND up.pais_id=".$request->input("pais_id")." ".session("where_union").
            " ORDER BY u.descripcion ASC";
		} elseif(session("perfil_id") != 1 && session("perfil_id") != 2) {
            // $sql = "SELECT u.idunion AS id, u.descripcion FROM iglesias.union AS u
            // WHERE estado='1' ".session("where_union").
            // " ORDER BY u.descripcion ASC";
		}

        if($sql != "") {
            $result = DB::select($sql);
        }
        array_push($result, $array);
        return $result;
    }
}
