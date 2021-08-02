<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class OtraspropiedadesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $funcion = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || ot.idiglesia, ".session("idioma_id").", ".session("idioma_id_defecto").")";


        $tabla = new Tabla();
        $tabla->asignarID("tabla-otras-propiedades");
        $tabla->agregarColumna("ot.idotrapropiedad", "idotrapropiedad", "Id");
        // $tabla->agregarColumna("ot.nombre", "nombre", traducir("traductor.nombre"));
        $tabla->agregarColumna("ot.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("ot.cantidad", "cantidad", traducir("traductor.cantidad"));
        $tabla->agregarColumna("ot.tipo", "tipo", traducir("traductor.tipo"));

        $tabla->agregarColumna($funcion, "iglesia", traducir("traductor.iglesia"));
        $tabla->setSelect("ot.idotrapropiedad, ot.descripcion, ot.cantidad, ot.tipo, ".$funcion." AS iglesia");
        $tabla->setFrom("iglesias.otras_propiedades AS ot");


    
     
        return $tabla;
    }


  
}
