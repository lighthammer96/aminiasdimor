<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class DistritosmisionerosModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        $this->tabla = new Tabla();
    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-distritos-misioneros");
        $this->tabla->agregarColumna("dm.iddistritomisionero", "iddistritomisionero", "Id");
        $this->tabla->agregarColumna("dm.descripcion", "descripcion", trans('traductor.descripcion'));
        $this->tabla->agregarColumna("m.descripcion", "mision", trans('traductor.mision'));
        $this->tabla->agregarColumna("dm.estado", "estado", trans('traductor.estado'));
        $this->tabla->setSelect("dm.iddistritomisionero, dm.descripcion, m.descripcion AS mision, CASE WHEN dm.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.distritomisionero AS dm
        \nLEFT JOIN iglesias.mision AS m ON(dm.idmision=m.idmision)");

        return $this->tabla;
    }

}
