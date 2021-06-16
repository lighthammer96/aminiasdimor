<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ModulosModel extends Model
{
    use HasFactory;

    public function __construct() {
        parent::__construct();

    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarId("tabla-modulos");
        $tabla->agregarColumna("h.modulo_id", "modulo_id", "ID");
        $tabla->agregarColumna("h.modulo_nombre", "hijo", "Modulo");
        $tabla->agregarColumna("h.modulo_icono", "modulo_icono", "Icono");
        $tabla->agregarColumna("h.modulo_controlador", "modulo_controlador", "Controlador");
        $tabla->agregarColumna("p.modulo_nombre", "padre", "Modulo Padre");
        $tabla->agregarColumna("h.estado", "estado", "Estado");
        $tabla->setSelect("h.modulo_id as modulo_id, h.modulo_nombre as hijo, p.modulo_id as idpadre, p.modulo_nombre as padre, h.modulo_icono, h.modulo_controlador, CASE WHEN h.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("seguridad.modulos as p \nINNER JOIN seguridad.modulos as h on(p.modulo_id=h.modulo_padre)");
        $tabla->setWhere("h.modulo_id > 1");

        return $tabla;
    }
}
