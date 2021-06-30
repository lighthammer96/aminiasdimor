<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class DepartamentosModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-departamentos");
        $this->tabla->agregarColumna("d.iddepartamento", "iddepartamento", "Id");
        $this->tabla->agregarColumna("d.descripcion", "descripcion", traducir("traductor.descripcion"));
        $this->tabla->agregarColumna("p.pais_descripcion", "pais", traducir("traductor.pais"));
        $this->tabla->setSelect("d.iddepartamento, d.descripcion, p.pais_descripcion AS pais");
        $this->tabla->setFrom("public.departamento AS d
        \nLEFT JOIN iglesias.paises AS p ON(d.pais_id=p.pais_id)");
        return $this->tabla;
    }


  
}
