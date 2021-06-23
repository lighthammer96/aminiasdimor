<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class IglesiasModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        $this->tabla = new Tabla();
    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-iglesias");
        $this->tabla->agregarColumna("i.idiglesia", "idiglesia", "Id");
        $this->tabla->agregarColumna("i.descripcion", "descripcion", trans('traductor.descripcion'));
        $this->tabla->agregarColumna("i.direccion", "direccion", trans('traductor.direccion'));
        $this->tabla->agregarColumna("i.telefono", "telefono", trans('traductor.telefono'));
        $this->tabla->agregarColumna("dm.descripcion", "distrito_misionero", trans('traductor.distrito_misionero'));
        $this->tabla->agregarColumna("i.estado", "estado", trans('traductor.estado'));

        $this->tabla->setSelect("i.idiglesia, i.descripcion, i.direccion, i.telefono, dm.descripcion AS distrito_misionero, CASE WHEN i.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.iglesia AS i
        \nLEFT JOIN iglesias.distritomisionero AS dm ON(dm.iddistritomisionero=i.iddistritomisionero)");

        return $this->tabla;
    }
}
