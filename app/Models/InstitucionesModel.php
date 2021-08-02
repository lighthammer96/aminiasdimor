<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class InstitucionesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {

        $funcion = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || i.idiglesia, ".session("idioma_id").", ".session("idioma_id_defecto").")";
        

        $tabla = new Tabla();
        $tabla->asignarID("tabla-instituciones");
        $tabla->agregarColumna("i.idinstitucion", "idinstitucion", "Id");
        $tabla->agregarColumna("i.nombre", "nombre", traducir("traductor.nombre"));
        $tabla->agregarColumna("i.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("i.tipo", "tipo", traducir("traductor.tipo"));

        $tabla->agregarColumna($funcion, "iglesia", traducir("traductor.iglesia"));
        $tabla->setSelect("i.idinstitucion, i.nombre, i.descripcion, i.tipo, ".$funcion." AS iglesia");
        $tabla->setFrom("iglesias.institucion AS i");


    
     
        return $tabla;
    }


  
}
