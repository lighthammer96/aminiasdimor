<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class TrasladosModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function tabla() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-traslados");
        $tabla->agregarColumna("tt.idtemptraslados", "idtemptraslados", "Id");
        $tabla->agregarColumna("tt.asociado", "asociado", traducir("traductor.nombres"));
     
        $tabla->agregarColumna("tt.tipo_documento", "tipo_documento", traducir("traductor.tipo_documento"));
        $tabla->agregarColumna("tt.nrodoc", "nrodoc", traducir("traductor.numero_documento"));
        $tabla->agregarColumna("tt.division", "division", traducir("traductor.division"));
        $tabla->agregarColumna("tt.pais", "pais", traducir("traductor.pais"));
        $tabla->agregarColumna("tt.union", "union", traducir("traductor.union"));
        $tabla->agregarColumna("tt.mision", "mision", traducir("traductor.mision"));
        $tabla->agregarColumna("tt.distritomisionero", "distritomisionero", traducir("traductor.distrito_misionero"));
        $tabla->agregarColumna("tt.iglesia", "iglesia", traducir("traductor.iglesia"));
        $tabla->agregarColumna("tt.idtemptraslados", "boton", traducir("traductor.eliminar"));

        $tabla->setSelect("tt.idtemptraslados, tt.asociado, tt.tipo_documento, tt.nrodoc, tt.division, tt.pais, tt.union, tt.mision, tt.distritomisionero, tt.iglesia, '<center><button type=\"button\" onclick=\"eliminar_temp_traslado(''' || tt.idtemptraslados || ''')\" class=\"btn btn-danger btn-xs\" ><i class=\"fa fa-trash\"></i></button></center>' AS boton");
        $tabla->setFrom("iglesias.temp_traslados AS tt");

        if(isset($_REQUEST["tipo_traslado"])) {
            $tabla->setWhere("tt.tipo_traslado=".$_REQUEST["tipo_traslado"]);
        }
        return $tabla;
    }


    public function tabla_asociados_traslados() {

        $tabla = new Tabla();
        $tabla->asignarID("tabla-asociados-traslados");
        $tabla->agregarColumna("vat.idmiembro", "idmiembro", "Id");
        $tabla->agregarColumna("vat.asociado", "asociado", traducir("traductor.nombres"));
     
        $tabla->agregarColumna("vat.tipo_documento", "tipo_documento", traducir("traductor.tipo_documento"));
        $tabla->agregarColumna("vat.nrodoc", "nrodoc", traducir("traductor.numero_documento"));
        $tabla->agregarColumna("vat.division", "division", traducir("traductor.division"));
        $tabla->agregarColumna("vat.pais", "pais", traducir("traductor.pais"));
        $tabla->agregarColumna("vat.union", "union", traducir("traductor.union"));
        $tabla->agregarColumna("vat.mision", "mision", traducir("traductor.mision"));
        $tabla->agregarColumna("vat.distritomisionero", "distritomisionero", traducir("traductor.distrito_misionero"));
        $tabla->agregarColumna("vat.iglesia", "iglesia", traducir("traductor.iglesia"));
        $tabla->agregarColumna("vat.idmiembro", "boton", traducir("traductor.agregar"));


        if(isset($_REQUEST["tipo_traslado"]) && $_REQUEST["tipo_traslado"] != "3") {
            $tabla->setSelect("vat.idmiembro, vat.asociado, vat.tipo_documento, vat.nrodoc, vat.division, vat.pais, vat.union, vat.mision, vat.distritomisionero, vat.iglesia, '<center><button type=\"button\" onclick=\"agregar_temp_traslado(''' || vat.idmiembro || ''')\" class=\"btn btn-success btn-xs\" ><i class=\"fa fa-plus\"></i></button></center>' AS boton");
            $tabla->setFrom("iglesias.vista_asociados_traslados AS vat");
        } else {
            $tabla->setSelect("vat.idmiembro, vat.asociado, vat.tipo_documento, vat.nrodoc, vat.division, vat.pais, vat.union, vat.mision, vat.distritomisionero, vat.iglesia, '<center><button type=\"button\" onclick=\"trasladar(''' || vat.idmiembro || ''', ''' || vat.idiglesia || ''')\" class=\"btn btn-primary btn-xs\" ><i class=\"fa fa-arrow-circle-o-right\"></i></button></center>' AS boton");
            $tabla->setFrom("iglesias.vista_asociados_traslados AS vat");
        }


        $array_where = array();
        $where = "";
        // var_dump(session("array_tipos_acceso")); exit;
        if(session("array_tipos_acceso") != NULL && count(session("array_tipos_acceso")) > 0) {
            foreach (session("array_tipos_acceso") as $value) {
                foreach ($value as $k => $v) {
                    array_push($array_where, " vat.".$k." = ".$v);
                }
            }
            $where = implode(' AND ', $array_where);
        }
        $tabla->setWhere($where);

     
        return $tabla;

    }


    public function tabla_control() {
        
        $tabla = new Tabla();
        $tabla->asignarID("tabla-control-traslados");
        $tabla->agregarColumna("ct.idcontrol", "idcontrol", "Id");
        $tabla->agregarColumna("(m.apellidos || ', ' || m.nombres),", "asociado", traducir("traductor.asociado"));
        $tabla->agregarColumna("(SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior)", "iglesia_anterior", traducir("traductor.iglesia_anterior"));
     
        $tabla->agregarColumna("(SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) ", "iglesia_traslado", traducir("traductor.iglesia_traslado"));
        $tabla->agregarColumna("ct.fecha", "fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("ct.estado", "estado", traducir("traductor.estado"));
        $tabla->agregarColumna("ct.idcontol", "boton", traducir("traductor.imprimir"));


        $tabla->setSelect(" 
        ct.idcontrol,
        (m.apellidos || ', ' || m.nombres) AS asociado,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior) AS iglesia_anterior,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) AS iglesia_traslado,
        ".formato_fecha_idioma("ct.fecha")." AS fecha,
        CASE WHEN ct.estado='1' THEN 'PENDIENTE' ELSE 'TRASLADADO' END AS estado, '<center><button type=\"button\" onclick=\"imprimir_carta_iglesia(''' || ct.idmiembro || ''', ''' || ct.idcontrol || ''')\" class=\"btn btn-danger btn-xs\" ><i class=\"fa fa-file-pdf-o\"></i></button></center>' AS boton");
        $tabla->setFrom("iglesias.control_traslados AS ct 
        \nINNER JOIN iglesias.miembro AS m ON(ct.idmiembro=m.idmiembro)");
        $tabla->setWhere("ct.estado='1'");

     
        return $tabla;
    }

    
    
    

}
