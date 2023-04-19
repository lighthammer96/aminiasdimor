<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class DepartamentosModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-departamentos");
        $tabla->agregarColumna("d.iddepartamento", "iddepartamento", "Id");
        $tabla->agregarColumna("d.iddepartamento", "iddepartamento", "iddepartamento");
        $tabla->agregarColumna("d.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("p.pais_descripcion", "pais", traducir("traductor.pais"));
        $tabla->setSelect("d.iddepartamento, d.descripcion, p.pais_descripcion AS pais");
        $tabla->setFrom("public.departamento AS d
        \nLEFT JOIN iglesias.paises AS p ON(d.pais_id=p.pais_id)");
        return $tabla;
    }

    public function obtener_departamentos() {
        $sql = "SELECT iddepartamento as id, descripcion FROM public.departamento";
        $result = DB::select($sql);
        return $result;
    }

}
