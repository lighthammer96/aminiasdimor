<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class EleccionModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {

        // $funcion = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'e.idiglesia=' || e.idiglesia, ".session("idioma_id").", ".session("idioma_id_defecto").")";


        $tabla = new Tabla();
        $tabla->asignarID("tabla-eleccion");
        $tabla->agregarColumna("e.ideleccion", "ideleccion", "Id");
        $tabla->agregarColumna("e.fecha", "fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("e.supervisor", "supervisor", traducir("traductor.supervisor"));
        $tabla->agregarColumna("e.tiporeunion", "tiporeunion", traducir("traductor.tipo_reunion"));
        $tabla->agregarColumna("e.comentarios", "comentarios", traducir("traductor.comentarios_"));
        $tabla->agregarColumna("m.descripcion", "mision", traducir("traductor.asociacion"));

        $tabla->setSelect("e.ideleccion, e.fecha, e.supervisor, CASE WHEN e.tiporeunion ='O' THEN 'Reunion Ordinaria' ELSE 'Reunión Extraordinaria' END AS tiporeunion, e.comentarios, m.descripcion AS mision");
        $tabla->setFrom("iglesias.eleccion AS e
        \nINNER JOIN iglesias.mision AS m ON(e.idmision=m.idmision)");
        $tabla->setWhere("e.tipo='A'");



        return $tabla;
    }

    public function tabla_union() {




        $tabla = new Tabla();
        $tabla->asignarID("tabla-eleccion_union");
        $tabla->agregarColumna("e.ideleccion", "ideleccion", "Id");
        $tabla->agregarColumna("e.fecha", "fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("e.supervisor", "supervisor", traducir("traductor.supervisor"));
        $tabla->agregarColumna("e.tiporeunion", "tiporeunion", traducir("traductor.tipo_reunion"));
        $tabla->agregarColumna("e.comentarios", "comentarios", traducir("traductor.comentarios_"));
        $tabla->agregarColumna("u.descripcion", "union", traducir("traductor.union"));


        $tabla->setSelect("e.ideleccion, e.fecha, e.supervisor, CASE WHEN e.tiporeunion ='O' THEN 'Reunion Ordinaria' ELSE 'Reunión Extraordinaria' END AS tiporeunion, e.comentarios, u.descripcion AS union");
        $tabla->setFrom("iglesias.eleccion AS e
        \nINNER JOIN iglesias.union AS u ON(e.idunion=u.idunion)");
        $tabla->setWhere("e.tipo='U'");




        return $tabla;
    }


    public function tabla_iglesia() {

        $tabla = new Tabla();
        $tabla->asignarID("tabla-eleccion_iglesia");
        $tabla->agregarColumna("e.ideleccion", "ideleccion", "Id");
        $tabla->agregarColumna("e.fecha", "fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("e.supervisor", "supervisor", traducir("traductor.supervisor"));
        $tabla->agregarColumna("e.tiporeunion", "tiporeunion", traducir("traductor.tipo_reunion"));
        $tabla->agregarColumna("e.comentarios", "comentarios", traducir("traductor.comentarios_"));
        $tabla->agregarColumna("i.descripcion", "iglesia", traducir("traductor.iglesia"));


        $tabla->setSelect("e.ideleccion, e.fecha, e.supervisor, CASE WHEN e.tiporeunion ='O' THEN 'Reunion Ordinaria' ELSE 'Reunión Extraordinaria' END AS tiporeunion, e.comentarios, i.descripcion AS iglesia");
        $tabla->setFrom("iglesias.eleccion AS e
        \nINNER JOIN iglesias.iglesia AS i ON(e.idiglesia=i.idiglesia)");
        $tabla->setWhere("e.tipo='I'");

        return $tabla;
    }
}
