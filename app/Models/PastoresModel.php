<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class PastoresModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-pastores");
        $this->tabla->agregarColumna("ot.idotrospastores", "idotrospastores", "Id");
        $this->tabla->agregarColumna("td.descripcion", "tipo_documento", traducir('traductor.tipo_documento'));
        $this->tabla->agregarColumna("ot.nrodoc", "nrodoc", traducir('traductor.numero_documento'));
        $this->tabla->agregarColumna("ot.nombrecompleto", "nombrecompleto", traducir('traductor.nombre_completo'));
        $this->tabla->agregarColumna("c.descripcion", "cargo", traducir('traductor.cargo'));
        $this->tabla->agregarColumna("ot.estado", "estado", traducir('traductor.estado'));
        $this->tabla->setSelect("ot.idotrospastores, td.descripcion AS tipo_documento, ot.nrodoc, ot.nombrecompleto, c.descripcion AS cargo, CASE WHEN ot.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado");
        $this->tabla->setFrom("iglesias.otrospastores AS ot
        \nINNER JOIN public.cargo AS c on(c.idcargo=ot.idcargo)
        \nINNER JOIN public.tipodoc AS td on(td.idtipodoc=ot.idtipodoc)");


    
     
        return $this->tabla;
    }


  
}
