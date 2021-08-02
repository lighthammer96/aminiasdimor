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

        // $funcion = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision  || '' / '' || s.iglesia', 'e.idiglesia=' || e.idiglesia, ".session("idioma_id").", ".session("idioma_id_defecto").")";


        $tabla = new Tabla();
        $tabla->asignarID("tabla-eleccion");
        $tabla->agregarColumna("e.ideleccion", "ideleccion", "Id");
        $tabla->agregarColumna("e.fecha", "fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("e.supervisor", "supervisor", traducir("traductor.supervisor"));
        $tabla->agregarColumna("e.tiporeunion", "tiporeunion", traducir("traductor.tipo_reunion"));
        $tabla->agregarColumna("e.comentarios", "comentarios", traducir("traductor.comentarios_"));

       
        $tabla->setSelect("e.ideleccion, e.fecha, e.supervisor, CASE WHEN e.tiporeunion ='O' THEN 'Reunion Ordinaria' ELSE 'Reunión Extraordinaria' END AS tiporeunion, e.comentarios");
        $tabla->setFrom("iglesias.eleccion AS e");


    
     
        return $tabla;
    }


  
}
