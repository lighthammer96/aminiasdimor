<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class ProvinciasModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-provincias");
        $tabla->agregarColumna("p.idprovincia", "idprovincia", "Id");
        $tabla->agregarColumna("p.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("d.descripcion", "departamento", traducir("traductor.division_1"));
        $tabla->setSelect("p.idprovincia, p.descripcion, d.descripcion AS departamento");
        $tabla->setFrom("public.provincia AS p
        \nLEFT JOIN public.departamento AS d ON(d.iddepartamento=p.iddepartamento)");
        return $tabla;
    }


  
}
