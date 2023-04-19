<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class NivelesModel extends Model
{
    use HasFactory;



    public function __construct() {
        parent::__construct();

        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-niveles");
        $tabla->agregarColumna("n.idnivel", "idnivel", "Id");
        $tabla->agregarColumna("n.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("tc.descripcion", "tipo_cargo", traducir("traductor.tipo_cargo"));
        $tabla->agregarColumna("n.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("n.idnivel, n.descripcion, tc.descripcion AS tipo_cargo, CASE WHEN n.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, n.estado AS state");
        $tabla->setFrom("public.nivel AS n
        \nLEFT JOIN public.tipocargo AS tc ON(n.idtipocargo=tc.idtipocargo)");




        return $tabla;
    }

    public function obtener_niveles($request) {
        $sql = "";
        $result = array();
		if(isset($_REQUEST["idtipocargo"]) && !empty($_REQUEST["idtipocargo"])) {
            $sql = "SELECT n.idnivel AS id, n.descripcion
            FROM public.nivel AS n
            WHERE n.estado='1' AND n.idtipocargo=".$request->input("idtipocargo")."
            ORDER BY n.descripcion ASC";


        } else {
            // $sql = "SELECT n.idnivel AS id, n.descripcion FROM public.nivel AS n
            // WHERE n.estado='1'
            // ORDER BY n.descripcion ASC";
        }

        if($sql != "") {
            $result = DB::select($sql);
        }
        return $result;
    }


}
