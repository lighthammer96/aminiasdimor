<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


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


  
}
