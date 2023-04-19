<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class ActividadmisioneraModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function obtener_trimestres() {
        $sql = "SELECT idtrimestre AS id, descripcion FROM public.trimestre
        ORDER BY idtrimestre ASC";
        $result = DB::select($sql);
        return $result;
    }

    public function obtener_anios() {
        $result = array();
        $array = array();
        for($i=date("Y"); $i>=2021; $i-- ) {
            $result["id"] = $i;
            $result["descripcion"] = $i;
            array_push($array, $result);
        }

        return $array;
    }

}
