<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class NivelesModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-niveles");
        $this->tabla->agregarColumna("n.idnivel", "idnivel", "Id");
        $this->tabla->agregarColumna("n.descripcion", "descripcion", traducir("traductor.descripcion"));
        $this->tabla->agregarColumna("tc.descripcion", "tipo_cargo", traducir("traductor.tipo_cargo"));
        $this->tabla->setSelect("n.idnivel, n.descripcion, tc.descripcion AS tipo_cargo");
        $this->tabla->setFrom("public.nivel AS n
        \nLEFT JOIN public.tipocargo AS tc ON(n.idtipocargo=tc.idtipocargo)");


    
     
        return $this->tabla;
    }


  
}
