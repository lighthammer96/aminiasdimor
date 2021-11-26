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
        $tabla->agregarColumna("di.di_descripcion", "division", traducir('traductor.division'));
        $tabla->agregarColumna("p.estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("p.pais_id, p.pais_descripcion, p.direccion, p.telefono, i.idioma_descripcion, 
        CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
        ELSE di.di_descripcion END AS division
        , CASE WHEN p.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, p.estado AS state");
        $tabla->setFrom("iglesias.paises AS p
        \nLEFT JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
        \nLEFT JOIN iglesias.division AS d ON(d.iddivision=p.iddivision)
        \nLEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")");


    
     
        return $tabla;
    }
}
