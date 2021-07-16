<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class UnionesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-uniones");
        $tabla->agregarColumna("u.idunion", "idunion", "Id");
        $tabla->agregarColumna("u.descripcion", "descripcion", traducir('traductor.descripcion'));
       // $tabla->agregarColumna("p.pais_descripcion", "pais_descripcion", traducir('traductor.pais'));
        $tabla->agregarColumna("u.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("u.idunion, u.descripcion, CASE WHEN u.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("iglesias.union AS u");

        return $tabla;
    }
}
