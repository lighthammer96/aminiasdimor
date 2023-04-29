<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

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
        $tabla->agregarColumna("c.idcargo", "idcargo", "idcargo");
        $tabla->agregarColumna("tc.descripcion", "tipo_cargo", traducir("traductor.tipo_cargo"));
        $tabla->agregarColumna("n.descripcion", "nivel", traducir("traductor.nivel"));
        $tabla->agregarColumna("c.descripcion", "descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("c.estado", "estado", traducir("traductor.estado"));
        $tabla->setSelect("c.idcargo, tc.descripcion AS tipo_cargo, n.descripcion AS nivel, c.descripcion, CASE WHEN c.estado='1' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, c.estado AS state");
        $tabla->setFrom("public.cargo AS c
        \nLEFT JOIN public.nivel AS n ON(n.idnivel=c.idnivel)
        \nLEFT JOIN public.tipocargo AS tc ON(tc.idtipocargo=n.idtipocargo)");




        return $tabla;
    }

    public function obtener_cargos($request) {
        $sql = "";
		if(isset($_REQUEST["idtipocargo"]) && !empty($_REQUEST["idtipocargo"])) {
            $sql = "SELECT idcargo as id, descripcion FROM public.cargo
            WHERE estado='1' AND idtipocargo=".$request->input("idtipocargo")."
            ORDER BY idcargo ASC";

        } elseif(isset($_REQUEST["idnivel"]) && !empty($_REQUEST["idnivel"])) {

            $sql = "SELECT idcargo as id, descripcion FROM public.cargo
            WHERE estado='1' AND idnivel=".$request->input("idnivel")."
            ORDER BY idcargo ASC";

        } else {
            $sql = "SELECT idcargo as id, descripcion FROM public.cargo
            WHERE estado='1'
            ORDER BY idcargo ASC";
        }


        $result = DB::select($sql);
        return $result;
    }

    public function obtener_cargos_para_eleccion_oficiales_union() {
        $sql = "SELECT idcargo as id, descripcion FROM public.cargo c WHERE idtipocargo=2 AND idnivel=4 AND estado='1' ORDER BY idcargo ASC";
        $result = DB::select($sql);
        return $result;
    }

    public function obtener_cargos_para_eleccion_oficiales_asociacion() {
        $sql = "SELECT idcargo as id, descripcion FROM public.cargo c WHERE idtipocargo=2 AND idnivel=5 AND estado='1' ORDER BY idcargo ASC";
        $result = DB::select($sql);
        return $result;
    }

    public function obtener_cargos_para_eleccion_oficiales_iglesia() {
        $sql = "SELECT idcargo as id, descripcion FROM public.cargo c WHERE idtipocargo=2 AND idnivel=7 AND estado='1' ORDER BY idcargo ASC";
        $result = DB::select($sql);
        return $result;
    }


}
