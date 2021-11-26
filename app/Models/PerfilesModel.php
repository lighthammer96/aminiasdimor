<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class PerfilesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-perfiles");
        $tabla->agregarColumna("p.perfil_id", "perfil_id", "Id");
        $tabla->agregarColumna("pi.pi_descripcion", "pi_descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("p.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("p.perfil_id, CASE WHEN pi.pi_descripcion IS NULL THEN 
        (SELECT pi_descripcion FROM seguridad.perfiles_idiomas WHERE perfil_id=p.perfil_id AND idioma_id=".session("idioma_id_defecto").")
        ELSE pi.pi_descripcion END AS pi_descripcion , CASE WHEN p.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, p.estado AS state");
        $tabla->setFrom("seguridad.perfiles AS p
        \nLEFT JOIN seguridad.perfiles_idiomas AS pi on(pi.perfil_id=p.perfil_id AND pi.idioma_id=".session("idioma_id").")");


    
     
        return $tabla;
    }


  
}
