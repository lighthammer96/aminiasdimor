<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\URL;

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
        $tabla->agregarColumna("tt.idtemptraslados", "boton", traducir("traductor.quitar"));

        $tabla->setSelect("tt.idtemptraslados, tt.asociado, tt.tipo_documento, tt.nrodoc, tt.division, tt.pais, tt.union, tt.mision, tt.distritomisionero, tt.iglesia, '<center><button type=\"button\"
        quitar=\"' || tt.idmiembro || '\"  onclick=\"eliminar_temp_traslado(' || tt.idtemptraslados || ',' || tt.idmiembro || ')\" class=\"btn btn-danger btn-xs\" ><i class=\"fa fa-minus-circle\"></i></button></center>' AS boton");
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
            $tabla->setSelect("vat.idmiembro, vat.asociado, vat.tipo_documento, vat.nrodoc, 
            CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS division,
            vat.pais, vat.union, vat.mision, vat.distritomisionero, vat.iglesia, CASE WHEN temp.idmiembro IS NULL THEN '<center><button agregar=\"' || vat.idmiembro  || '\" type=\"button\" onclick=\"agregar_temp_traslado(' || vat.idmiembro || ')\" class=\"btn btn-primary btn-xs\" ><i class=\"fa fa-plus\"></i></button></center>' ELSE 
            '<center><button agregar=\"' || vat.idmiembro  || '\" type=\"button\"  class=\"btn btn-success btn-xs\" ><i class=\"fa fa-check-circle\"></i></button></center>'
            
            END AS boton, vat.estado AS state");
            $tabla->setFrom("iglesias.vista_asociados_traslados AS vat
            LEFT JOIN iglesias.temp_traslados AS temp ON(vat.idmiembro=temp.idmiembro AND temp.tipo_traslado=".$_REQUEST["tipo_traslado"].")
            LEFT JOIN iglesias.division AS d ON(d.iddivision=vat.iddivision)
            LEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")");
        } else {
            $tabla->setSelect("vat.idmiembro, vat.asociado, vat.tipo_documento, vat.nrodoc, 
            CASE WHEN di.di_descripcion IS NULL THEN
            (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id=".session("idioma_id_defecto").")
            ELSE di.di_descripcion END AS division,
            vat.pais, vat.union, vat.mision, vat.distritomisionero, vat.iglesia, 
            CASE WHEN ct.idmiembro IS NULL THEN '<center><button type=\"button\" agregar=\"' || vat.idmiembro  || '\" onclick=\"trasladar(''' || vat.idmiembro || ''', ''' || vat.idiglesia || ''')\" class=\"btn btn-primary btn-xs\" ><i class=\"fa fa-arrow-circle-o-right\"></i></button></center>' 
            ELSE 
            '<center><button title=\"".traducir("traductor.traslado_proceso")."\" type=\"button\"  class=\"btn btn-success btn-xs\" ><i class=\"fa fa-hourglass-half\"></i></button></center>'
            
            END AS boton, vat.estado AS state");
            $tabla->setFrom("iglesias.vista_asociados_traslados AS vat
            LEFT JOIN iglesias.control_traslados AS ct ON(vat.idmiembro=ct.idmiembro AND ct.estado='1')
            LEFT JOIN iglesias.division AS d ON(d.iddivision=vat.iddivision)
            LEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id=".session("idioma_id").")");
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
        $funcion_1 = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || ct.idiglesiaanterior, ".session("idioma_id").", ".session("idioma_id_defecto").")";
        $funcion_2 = "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || ct.idiglesiaactual, ".session("idioma_id").", ".session("idioma_id_defecto").")";


        $tabla = new Tabla();
        $tabla->asignarID("tabla-control-traslados");
        $tabla->agregarColumna("ct.idcontrol", "idcontrol", "Id");
        $tabla->agregarColumna("(m.apellidos || ', ' || m.nombres),", "asociado", traducir("traductor.asociado"));
        $tabla->agregarColumna($funcion_1, "iglesia_anterior", traducir("traductor.iglesia_anterior"));
     
        $tabla->agregarColumna($funcion_2, "iglesia_traslado", traducir("traductor.iglesia_traslado"));
        $tabla->agregarColumna("ct.fecha", "fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("ct.estado", "estado", traducir("traductor.estado"));
        $tabla->agregarColumna("ct.idcontol", "boton", traducir("traductor.imprimir"));


        $tabla->setSelect(" 
        ct.idcontrol,
        (m.apellidos || ', ' || m.nombres) AS asociado,
        ".$funcion_1." AS iglesia_anterior,
        ".$funcion_2." AS iglesia_traslado,
        ".formato_fecha_idioma("ct.fecha")." AS fecha,
        CASE WHEN ct.estado='1' THEN 'PENDIENTE' ELSE 'TRASLADADO' END AS estado, '<center><button type=\"button\" onclick=\"imprimir_carta_iglesia(''' || ct.idmiembro || ''', ''' || ct.idcontrol || ''')\" class=\"btn btn-xs\" ><img style=\"width: 20px; height: 20px;\" src=\"".URL::asset('images/iconos/print.png')."\"><br></button></center>' AS boton");
        $tabla->setFrom("iglesias.control_traslados AS ct 
        \nINNER JOIN iglesias.miembro AS m ON(ct.idmiembro=m.idmiembro)");
        $tabla->setWhere("ct.estado='1'");

     
        return $tabla;
    }

    
    
    

}
