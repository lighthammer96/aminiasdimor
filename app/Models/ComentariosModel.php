<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class ComentariosModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-comentarios");
        $tabla->agregarColumna("c.comentario_id", "comentario_id", "Id");
        $tabla->agregarColumna("f.foro_descripcion", "foro_descripcion", traducir("asambleas.foro"));
        $tabla->agregarColumna("m.apellidos || ', ' || m.nombres)", "asociado", traducir("traductor.asociado"));
        $tabla->agregarColumna("c.comentario_descripcion", "comentario_descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("c.comentario_fecha", "comentario_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("c.comentario_hora", "comentario_hora", traducir("asambleas.hora"));
      
        $tabla->agregarColumna("c.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("c.comentario_id, f.foro_descripcion, (m.apellidos || ', ' || m.nombres) AS asociado, c.comentario_descripcion, ".formato_fecha_idioma("c.comentario_fecha")." AS comentario_fecha, c.comentario_hora,
        CASE WHEN c.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, c.estado AS state");
        $tabla->setFrom("asambleas.comentarios AS c
        \nINNER JOIN asambleas.foros AS f on(f.foro_id=c.foro_id)
        \nINNER JOIN iglesias.miembro AS m on(m.idmiembro=c.idmiembro)");


    
     
        return $tabla;
    }


  
}
