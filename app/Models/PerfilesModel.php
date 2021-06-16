<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class PerfilesModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-perfiles");
        $this->tabla->agregarColumna("perfil_id", "perfil_id", "Id");
        $this->tabla->agregarColumna("perfil_descripcion", "perfil_descripcion", "Descripcion");
        $this->tabla->agregarColumna("estado", "estado", "Estado");
        $this->tabla->setSelect("perfil_id, perfil_descripcion, CASE WHEN estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("seguridad.perfiles");


    
     
        return $this->tabla;
    }


  
}
