<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class DistritosModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-distritos");
        $this->tabla->agregarColumna("d.iddistrito", "iddistrito", "Id");
        $this->tabla->agregarColumna("d.descripcion", "descripcion", traducir("traductor.descripcion"));
        $this->tabla->agregarColumna("p.descripcion", "provincia", traducir("traductor.division_2"));
        $this->tabla->setSelect("d.iddistrito, d.descripcion, p.descripcion AS provincia");
        $this->tabla->setFrom("public.distrito AS d
        \nLEFT JOIN public.provincia AS p ON(d.idprovincia=p.idprovincia)");
        return $this->tabla;
    }


  
}
