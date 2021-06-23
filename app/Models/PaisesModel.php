<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class PaisesModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-paises");
        $this->tabla->agregarColumna("p.pais_id", "pais_id", "Id");
        $this->tabla->agregarColumna("p.pais_descripcion", "pais_descripcion", trans('traductor.descripcion'));
        $this->tabla->agregarColumna("p.direccion", "direccion", trans('traductor.direccion'));
        $this->tabla->agregarColumna("p.telefono", "telefono", trans('traductor.telefono'));
        $this->tabla->agregarColumna("i.idioma_descripcion", "idioma_descripcion", trans('traductor.idioma'));
        $this->tabla->agregarColumna("d.descripcion", "division", trans('traductor.division'));
        $this->tabla->agregarColumna("p.estado", "estado", trans('traductor.estado'));
        $this->tabla->setSelect("p.pais_id, p.pais_descripcion, p.direccion, p.telefono, i.idioma_descripcion, d.descripcion AS division, CASE WHEN p.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("public.paises AS p
        \nINNER JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
        \nLEFT JOIN iglesias.division AS d ON(d.iddivision=p.iddivision)");


    
     
        return $this->tabla;
    }
}
