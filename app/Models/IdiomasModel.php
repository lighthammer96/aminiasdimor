<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class IdiomasModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-idiomas");
        $tabla->agregarColumna("idioma_id", "idioma_id", "Id");
        $tabla->agregarColumna("idioma_codigo", "idioma_codigo", traducir('traductor.codigo'));
        $tabla->agregarColumna("idioma_descripcion", "idioma_descripcion", traducir('traductor.descripcion'));
        $tabla->agregarColumna("estado", "estado", traducir('traductor.estado'));
        $tabla->setSelect("idioma_id, idioma_codigo, idioma_descripcion, CASE WHEN estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("public.idiomas");


    
     
        return $tabla;
    }
}
