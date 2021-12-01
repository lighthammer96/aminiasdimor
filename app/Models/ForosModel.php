<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class ForosModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-foros");
        $tabla->agregarColumna("f.foro_id", "foro_id", "Id");
        $tabla->agregarColumna("f.foro_descripcion", "foro_descripcion", traducir("asambleas.foro"));
        $tabla->agregarColumna("a.asamblea_descripcion", "asamblea_descripcion", traducir("asambleas.convocatoria"));
        $tabla->agregarColumna("f.foro_fecha", "foro_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("f.foro_hora", "foro_hora", traducir("asambleas.hora"));
      
        $tabla->agregarColumna("f.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("f.foro_id, f.foro_descripcion, a.asamblea_descripcion, ".formato_fecha_idioma("f.foro_fecha")." AS foro_fecha, f.foro_hora,
        CASE WHEN f.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, f.estado AS state");
        $tabla->setFrom("asambleas.foros AS f
        \nINNER JOIN asambleas.asambleas AS a on(a.asamblea_id=f.asamblea_id)");


    
     
        return $tabla;
    }


  
}
