<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UsuariosModel extends Model
{
    use HasFactory;

    public function __construct() {
        parent::__construct();

    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-usuarios");
        $tabla->agregarColumna("u.usuario_id", "usuario_id", "Id");
        //$tabla->agregarColumna("u.usuario_nombres", "usuario_nombres", "Nombres");
        $tabla->agregarColumna("m.nombres", "responsable", "Responsable");
        $tabla->agregarColumna("u.usuario_user", "usuario_user", "Usuario");
       // $tabla->agregarColumna("u.usuario_referencia", "usuario_referencia", "Referencia");
        $tabla->agregarColumna("p.perfil_descripcion", "perfil_descripcion", "Perfil");
        $tabla->agregarColumna("ta.descripcion", "tipoacceso", "Tipo de Acceso");
        $tabla->agregarColumna("u.estado", "estado", "Estado");
        $tabla->setSelect("u.usuario_id, (m.apellidos || ', ' || m.nombres) AS responsable, u.usuario_user, p.perfil_descripcion, ta.descripcion AS tipoacceso, CASE WHEN u.estado = 'A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("seguridad.usuarios as u
        \nINNER JOIN seguridad.perfiles AS p ON(p.perfil_id=u.perfil_id)
        \nLEFT JOIN iglesias.miembro AS m ON(m.idmiembro=u.idmiembro)
        \nLEFT JOIN seguridad.tipoacceso AS ta ON(ta.idtipoacceso=u.idtipoacceso)");
        //$tabla->setWhere("u.estado='A'");
        // $tabla->setupdate("updateusuario");
        // $tabla->setdelete("eliminarusuario");

        return $tabla;
    }
}
