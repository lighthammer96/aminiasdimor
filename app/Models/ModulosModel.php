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
        $tabla->agregarColumna("mi.mi_descripcion", "mi_descripcion", "Modulo");
        $tabla->agregarColumna("h.modulo_icono", "modulo_icono", "Icono");
        $tabla->agregarColumna("h.modulo_controlador", "modulo_controlador", "Controlador");
        $tabla->agregarColumna("p.modulo_nombre", "padre", "Modulo Padre");
        $tabla->agregarColumna("h.estado", "estado", "Estado");
        $tabla->setSelect("h.modulo_id as modulo_id, CASE WHEN mi.mi_descripcion IS NULL THEN 
        (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=h.modulo_id AND idioma_id=".session("idioma_id_defecto").")
        ELSE mi.mi_descripcion END AS mi_descripcion , p.modulo_id as idpadre, 

        CASE WHEN (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=p.modulo_id AND idioma_id=".session("idioma_id").") IS NULL THEN (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=p.modulo_id AND idioma_id=".session("idioma_id_defecto").") ELSE (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=p.modulo_id AND idioma_id=".session("idioma_id").") END AS padre, 
        
        h.modulo_icono, h.modulo_controlador, CASE WHEN h.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("seguridad.modulos as p 
        \nINNER JOIN seguridad.modulos as h on(p.modulo_id=h.modulo_padre)
        \nLEFT JOIN seguridad.modulos_idiomas as mi on(mi.modulo_id=h.modulo_id AND mi.idioma_id=".session("idioma_id").")");
        //$tabla->setWhere("h.modulo_id > 1");



        
        return $tabla;
    }
}
