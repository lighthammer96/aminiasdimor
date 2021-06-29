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
        $this->tabla->agregarColumna("di.di_descripcion", "descripcion", traducir('traductor.descripcion'));
        $this->tabla->agregarColumna("d.estado", "estado", traducir('traductor.estado'));
        $this->tabla->setSelect("d.iddivision, CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
        ELSE di.di_descripcion END AS descripcion, 
        CASE WHEN d.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.division AS d
        \nLEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")");

        return $this->tabla;
    }
}
