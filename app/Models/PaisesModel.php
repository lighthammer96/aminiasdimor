<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class PaisesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-paises");
        $tabla->agregarColumna("p.pais_id", "pais_id", "Id");
        $tabla->agregarColumna("p.pais_id", "pais_id", "pais_id");
        $tabla->agregarColumna("p.pais_descripcion", "pais_descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("p.direccion", "direccion", traducir('traductor.direccion'));
        $tabla->agregarColumna("p.telefono", "telefono", traducir('traductor.telefono'));
        $tabla->agregarColumna("i.idioma_descripcion", "idioma_descripcion", traducir('traductor.idioma'));
        $tabla->agregarColumna("d.descripcion", "division", traducir('traductor.division'));
        $tabla->agregarColumna("p.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("p.pais_id, p.pais_descripcion, p.direccion, p.telefono, i.idioma_descripcion, d.descripcion AS division, CASE WHEN p.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("iglesias.paises AS p
        \nLEFT JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
        \nLEFT JOIN iglesias.division AS d ON(d.iddivision=p.iddivision)");


    
     
        return $tabla;
    }
}
