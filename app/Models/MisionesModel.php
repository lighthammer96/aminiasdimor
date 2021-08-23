<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MisionesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-misiones");
        $tabla->agregarColumna("m.idmision", "idmision", "Id");
        $tabla->agregarColumna("m.idmision", "idmision", "idmision");
        $tabla->agregarColumna("m.descripcion", "descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("u.descripcion", "union", traducir('traductor.union'));
        $tabla->agregarColumna("m.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("m.idmision, m.descripcion, u.descripcion AS union, CASE WHEN m.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("iglesias.mision AS m 
        \nLEFT JOIN iglesias.union AS u ON(m.idunion=u.idunion)");

        return $tabla;
    }

}
