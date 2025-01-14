<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class AsambleasModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-asambleas");
        $tabla->agregarColumna("a.asamblea_id", "asamblea_id", "Id");
        $tabla->agregarColumna("a.asamblea_descripcion", "asamblea_descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("a.asamblea_anio", "asamblea_anio", traducir("traductor.anio"));
        $tabla->agregarColumna("a.asamblea_fecha_inicio", "asamblea_fecha_inicio", traducir("traductor.fecha_inicio"));
        $tabla->agregarColumna("a.asamblea_fecha_fin", "asamblea_fecha_fin", traducir("traductor.fecha_fin"));
        $tabla->agregarColumna("a.tipconv_descripcion", "tipconv_descripcion", traducir("asambleas.tipo_convocatoria"));
        $tabla->agregarColumna("a.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("a.asamblea_id, a.asamblea_descripcion, a.asamblea_anio, ".formato_fecha_idioma(" a.asamblea_fecha_inicio")." AS asamblea_fecha_inicio, ".formato_fecha_idioma(" a.asamblea_fecha_fin")." AS asamblea_fecha_fin, tc.tipconv_descripcion , CASE WHEN a.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, a.estado AS state");
        $tabla->setFrom("asambleas.asambleas AS a
        \nINNER JOIN asambleas.tipo_convocatoria AS tc on(tc.tipconv_id=a.tipconv_id)");

        return $tabla;
    }

    public function obtener_anios() {
        $result = array();
        $array = array();
        for($i=date("Y"); $i < date("Y") + 10; $i++ ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        return $array;
    }

    public function obtener_tipo_convocatoria() {
        $sql = "SELECT  tc.tipconv_id  AS id, tc.tipconv_descripcion AS descripcion
        FROM asambleas.tipo_convocatoria AS tc";
        // die($sql);
        $result = DB::select($sql);
        return $result;
    }

    public function obtener_asambleas() {
        $sql = "SELECT (tc.tipconv_id  || '|'  || a.asamblea_id) AS id, a.asamblea_descripcion AS descripcion, CASE WHEN NOW() BETWEEN a.asamblea_fecha_inicio AND a.asamblea_fecha_fin THEN 'S' ELSE 'N' END AS defecto
        FROM asambleas.asambleas AS a
        INNER JOIN asambleas.tipo_convocatoria AS tc ON(tc.tipconv_id=a.tipconv_id)
        WHERE a.estado='A'";
        // die($sql);
        $result = DB::select($sql);
        return $result;
    }

}
