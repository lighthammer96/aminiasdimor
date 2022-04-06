<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class DistritosModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-distritos");
        $tabla->agregarColumna("d.iddistrito", "iddistrito", "Id");
        $tabla->agregarColumna("d.iddistrito", "iddistrito", "iddistrito");
        $tabla->agregarColumna("d.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("p.descripcion", "provincia", traducir("traductor.division_2"));
        $tabla->agregarColumna("dd.descripcion", "departamento", traducir("traductor.division_1"));
        $tabla->agregarColumna("pp.pais_descripcion", "pais", traducir("traductor.pais"));
        $tabla->setSelect("d.iddistrito, d.descripcion, p.descripcion AS provincia, dd.descripcion AS departamento, pp.pais_descripcion AS pais");
        $tabla->setFrom("public.distrito AS d
        \nLEFT JOIN public.provincia AS p ON(d.idprovincia=p.idprovincia)
        \nLEFT JOIN public.departamento AS dd ON(dd.iddepartamento=p.iddepartamento)
        \nLEFT JOIN iglesias.paises AS pp ON(pp.pais_id=dd.pais_id)");
        return $tabla;
    }


  
}
