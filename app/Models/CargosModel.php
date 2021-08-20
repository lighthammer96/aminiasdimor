<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class CargosModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-cargos");
        $tabla->agregarColumna("c.idcargo", "idcargo", "Id");
        $tabla->agregarColumna("tc.descripcion", "tipo_cargo", traducir("traductor.tipo_cargo"));
        $tabla->agregarColumna("n.descripcion", "nivel", traducir("traductor.nivel"));
        $tabla->agregarColumna("c.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("c.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("c.idcargo, tc.descripcion AS tipo_cargo, n.descripcion AS nivel, c.descripcion, CASE WHEN c.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $tabla->setFrom("public.cargo AS c
        \nLEFT JOIN public.nivel AS n ON(n.idnivel=c.idnivel)
        \nLEFT JOIN public.tipocargo AS tc ON(tc.idtipocargo=n.idtipocargo)");


    
     
        return $tabla;
    }


  
}
