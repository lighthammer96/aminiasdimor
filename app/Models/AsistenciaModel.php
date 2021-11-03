<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class AsistenciaModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-asistencia");
        $tabla->agregarColumna("a.asistencia_id", "asistencia_id", "Id");
        $tabla->agregarColumna("aa.asamblea_descripcion", "asamblea_descripcion", traducir("asambleas.convocatoria"));
        $tabla->agregarColumna("a.asistencia_fecha", "asistencia_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("a.asistencia_hora", "asistencia_hora", traducir("asambleas.hora"));
      
        $tabla->agregarColumna("a.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("a.asistencia_id, aa.asamblea_descripcion , ".formato_fecha_idioma("a.asistencia_fecha")." AS asistencia_fecha, a.asistencia_hora,
        CASE WHEN a.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("asambleas.asistencia AS a
        \nINNER JOIN asambleas.asambleas AS aa on(aa.asamblea_id=a.asamblea_id)");


    
     
        return $tabla;
    }


  
}
