<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class PastoresModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-pastores");
        $tabla->agregarColumna("ot.idotrospastores", "idotrospastores", "Id");
        $tabla->agregarColumna("td.descripcion", "tipo_documento", traducir('traductor.tipo_documento'));
        $tabla->agregarColumna("ot.nrodoc", "nrodoc", traducir('traductor.numero_documento'));
        $tabla->agregarColumna("ot.nombrecompleto", "nombrecompleto", traducir('traductor.nombre_completo'));
        $tabla->agregarColumna("c.descripcion", "cargo", traducir('traductor.cargo'));
        $tabla->agregarColumna("p.descripcion", "pais", traducir('traductor.pais'));
        $tabla->agregarColumna("ot.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("ot.idotrospastores, td.descripcion AS tipo_documento, ot.nrodoc, ot.nombrecompleto, c.descripcion AS cargo, CASE WHEN ot.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, p.descripcion AS pais, ot.estado AS state");
        $tabla->setFrom("iglesias.otrospastores AS ot
        \nINNER JOIN public.cargo AS c on(c.idcargo=ot.idcargo)
        \nINNER JOIN public.tipodoc AS td on(td.idtipodoc=ot.idtipodoc)
        \nLEFT JOIN public.pais AS p on(p.idpais=ot.idpais)");




        return $tabla;
    }

    public function obtener_cargos() {
        $sql = "SELECT idcargo as id, descripcion FROM public.cargo
        WHERE idcargo=1 OR idcargo=4
        ORDER BY idcargo ASC";

        $result = DB::select($sql);
        return $result;
    }


}
