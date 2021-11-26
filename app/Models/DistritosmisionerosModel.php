<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class DistritosmisionerosModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-distritos-misioneros");
        $tabla->agregarColumna("dm.iddistritomisionero", "iddistritomisionero", "Id");
        $tabla->agregarColumna("dm.iddistritomisionero", "iddistritomisionero", "iddistritomisionero");
        $tabla->agregarColumna("dm.descripcion", "descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("m.descripcion", "mision", traducir('traductor.mision'));
        $tabla->agregarColumna("dm.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("dm.iddistritomisionero, dm.descripcion, m.descripcion AS mision, CASE WHEN dm.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, dm.estado AS state");
        $tabla->setFrom("iglesias.distritomisionero AS dm
        \nLEFT JOIN iglesias.mision AS m ON(dm.idmision=m.idmision)");

        return $tabla;
    }

}
