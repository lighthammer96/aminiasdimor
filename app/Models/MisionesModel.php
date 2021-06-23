<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MisionesModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        $this->tabla = new Tabla();
    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-misiones");
        $this->tabla->agregarColumna("m.idmision", "idmision", "Id");
        $this->tabla->agregarColumna("m.descripcion", "descripcion", trans('traductor.descripcion'));
        $this->tabla->agregarColumna("u.descripcion", "union", trans('traductor.union'));
        $this->tabla->agregarColumna("m.estado", "estado", trans('traductor.estado'));
        $this->tabla->setSelect("m.idmision, m.descripcion, u.descripcion AS union, CASE WHEN m.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.mision AS m 
        \nLEFT JOIN iglesias.union AS u ON(m.idunion=u.idunion)");

        return $this->tabla;
    }

}
