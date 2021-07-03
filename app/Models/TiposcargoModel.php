<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class TiposcargoModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-tipos-cargo");
        $this->tabla->agregarColumna("tc.idtipocargo", "idtipocargo", "Id");
        $this->tabla->agregarColumna("tc.descripcion", "descripcion", traducir("traductor.descripcion"));
        // $this->tabla->agregarColumna("p.estado", "estado", "Estado");
        $this->tabla->setSelect("tc.idtipocargo, tc.descripcion");
        $this->tabla->setFrom("public.tipocargo AS tc");
        return $this->tabla;
    }


  
}
