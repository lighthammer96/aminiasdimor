<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class IglesiasModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-iglesias");
        $tabla->agregarColumna("i.idiglesia", "idiglesia", "Id");
        $tabla->agregarColumna("i.descripcion", "descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("i.direccion", "direccion", traducir('traductor.direccion'));
        $tabla->agregarColumna("i.telefono", "telefono", traducir('traductor.telefono'));
        $tabla->agregarColumna("dm.descripcion", "distrito_misionero", traducir('traductor.distrito_misionero'));
        $tabla->agregarColumna("i.estado", "estado", traducir('traductor.estado'));

        $tabla->setSelect("i.idiglesia, i.descripcion, i.direccion, i.telefono, dm.descripcion AS distrito_misionero, CASE WHEN i.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("iglesias.iglesia AS i
        \nLEFT JOIN iglesias.distritomisionero AS dm ON(dm.iddistritomisionero=i.iddistritomisionero)");


        $array_where = array();
        $where = "";
        // var_dump(session("array_tipos_acceso")); exit;
        if(session("array_tipos_acceso") != NULL && count(session("array_tipos_acceso")) > 0) {
            foreach (session("array_tipos_acceso") as $value) {
                foreach ($value as $k => $v) {
                    array_push($array_where, " i.".$k." = ".$v);
                }
            }
            $where = implode(' AND ', $array_where);
        }
        $tabla->setWhere($where);

        return $tabla;
    }
}
