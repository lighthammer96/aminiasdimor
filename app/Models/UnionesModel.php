<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class UnionesModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        $this->tabla = new Tabla();
    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-uniones");
        $this->tabla->agregarColumna("u.idunion", "idunion", "Id");
        $this->tabla->agregarColumna("u.descripcion", "descripcion", traducir('traductor.descripcion'));
       // $this->tabla->agregarColumna("p.pais_descripcion", "pais_descripcion", traducir('traductor.pais'));
        $this->tabla->agregarColumna("u.estado", "estado", traducir('traductor.estado'));
        $this->tabla->setSelect("u.idunion, u.descripcion, CASE WHEN u.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.union AS u");

        return $this->tabla;
    }
}
