<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class CargosModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-cargos");
        $this->tabla->agregarColumna("c.idcargo", "idcargo", "Id");
        $this->tabla->agregarColumna("c.descripcion", "descripcion", traducir("traductor.descripcion"));
        $this->tabla->agregarColumna("n.descripcion", "nivel", traducir("traductor.nivel"));
        $this->tabla->agregarColumna("c.estado", "estado", traducir("traductor.estado"));
        $this->tabla->setSelect("c.idcargo, c.descripcion, n.descripcion AS nivel, CASE WHEN c.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("public.cargo AS c
        \nLEFT JOIN public.nivel AS n ON(n.idnivel=c.idnivel)");


    
     
        return $this->tabla;
    }


  
}
