<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class ProvinciasModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-provincias");
        $this->tabla->agregarColumna("p.idprovincia", "idprovincia", "Id");
        $this->tabla->agregarColumna("p.descripcion", "descripcion", traducir("traductor.descripcion"));
        $this->tabla->agregarColumna("d.descripcion", "departamento", traducir("traductor.departamento"));
        $this->tabla->setSelect("p.idprovincia, p.descripcion, d.descripcion AS departamento");
        $this->tabla->setFrom("public.provincia AS p
        \nLEFT JOIN public.departamento AS d ON(d.iddepartamento=p.iddepartamento)");
        return $this->tabla;
    }


  
}
