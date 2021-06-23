<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class DivisionesModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        $this->tabla = new Tabla();
    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-divisiones");
        $this->tabla->agregarColumna("d.iddivision", "iddivision", "Id");
        $this->tabla->agregarColumna("d.descripcion", "descripcion", trans('traductor.descripcion'));
        $this->tabla->agregarColumna("d.estado", "estado", trans('traductor.estado'));
        $this->tabla->setSelect("d.iddivision, d.descripcion, CASE WHEN d.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.division AS d");

        return $this->tabla;
    }
}
