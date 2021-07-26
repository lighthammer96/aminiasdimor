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
        $tabla = new Tabla();
        $tabla->asignarID("tabla-instituciones");
        $tabla->agregarColumna("i.idinstitucion", "idinstitucion", "Id");
        $tabla->agregarColumna("i.nombre", "nombre", traducir("traductor.nombre"));
        $tabla->agregarColumna("i.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("i.tipo", "tipo", traducir("traductor.tipo"));

        $tabla->agregarColumna("(SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=i.idiglesia)", "iglesia", traducir("traductor.iglesia"));
        $tabla->setSelect("i.idinstitucion, i.nombre, i.descripcion, i.tipo, (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=i.idiglesia) AS iglesia");
        $tabla->setFrom("iglesias.institucion AS i");


    
     
        return $tabla;
    }


  
}
