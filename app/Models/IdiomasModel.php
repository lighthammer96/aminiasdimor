<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;

class IdiomasModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-idiomas");
        $this->tabla->agregarColumna("idioma_id", "idioma_id", "Id");
        $this->tabla->agregarColumna("idioma_codigo", "idioma_codigo", traducir('traductor.codigo'));
        $this->tabla->agregarColumna("idioma_descripcion", "idioma_descripcion", traducir('traductor.descripcion'));
        $this->tabla->agregarColumna("estado", "estado", traducir('traductor.estado'));
        $this->tabla->setSelect("idioma_id, idioma_codigo, idioma_descripcion, CASE WHEN estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("public.idiomas");


    
     
        return $this->tabla;
    }
}
