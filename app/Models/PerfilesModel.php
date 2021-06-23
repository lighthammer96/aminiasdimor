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
        $this->tabla->agregarColumna("p.perfil_id", "perfil_id", "Id");
        $this->tabla->agregarColumna("pe.pi_descripcion", "pi_descripcion", "Descripcion");
        $this->tabla->agregarColumna("p.estado", "estado", "Estado");
        $this->tabla->setSelect("p.perfil_id, CASE WHEN pi.pi_descripcion IS NULL THEN 'NO TRADUCCION' ELSE pi.pi_descripcion END AS pi_descripcion , CASE WHEN p.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("seguridad.perfiles AS p
        \nLEFT JOIN seguridad.perfiles_idiomas AS pi on(pi.perfil_id=p.perfil_id AND pi.idioma_id=".session("idioma_id").")");


    
     
        return $this->tabla;
    }


  
}
