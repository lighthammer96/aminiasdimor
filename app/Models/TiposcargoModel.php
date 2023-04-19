<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class TiposcargoModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-tipos-cargo");
        $tabla->agregarColumna("tc.idtipocargo", "idtipocargo", "Id");
        $tabla->agregarColumna("tc.descripcion", "descripcion", traducir("traductor.descripcion"));
        // $tabla->agregarColumna("p.estado", "estado", "Estado");
        $tabla->setSelect("tc.idtipocargo, tc.descripcion");
        $tabla->setFrom("public.tipocargo AS tc");
        return $tabla;
    }

    public function obtener_tipos_cargo() {
        $sql = "SELECT /*(p.idtipocargo || '|' || p.posee_nivel)*/ p.idtipocargo  AS id, p.descripcion
        FROM public.tipocargo AS p";
        // die($sql);
        $result = DB::select($sql);
        return $result;
    }

}
