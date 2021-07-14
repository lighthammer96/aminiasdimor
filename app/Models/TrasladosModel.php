<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class TrasladosModel extends Model
{
    use HasFactory;

    private $tabla;

    public function __construct() {
        parent::__construct();
        
        $this->tabla = new Tabla();


    }

    public function tabla() {
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-traslados");
        $this->tabla->agregarColumna("tt.idtemptraslados", "idtemptraslados", "Id");
        $this->tabla->agregarColumna("tt.asociado", "asociado", traducir("traductor.nombres"));
     
        $this->tabla->agregarColumna("tt.tipo_documento", "tipo_documento", traducir("traductor.tipo_documento"));
        $this->tabla->agregarColumna("tt.nrodoc", "nrodoc", traducir("traductor.numero_documento"));
        $this->tabla->agregarColumna("tt.division", "division", traducir("traductor.division"));
        $this->tabla->agregarColumna("tt.pais", "pais", traducir("traductor.pais"));
        $this->tabla->agregarColumna("tt.union", "union", traducir("traductor.union"));
        $this->tabla->agregarColumna("tt.mision", "mision", traducir("traductor.mision"));
        $this->tabla->agregarColumna("tt.distritomisionero", "distritomisionero", traducir("traductor.distrito_misionero"));
        $this->tabla->agregarColumna("tt.iglesia", "iglesia", traducir("traductor.iglesia"));
        $this->tabla->agregarColumna("tt.idtemptraslados", "boton", traducir("traductor.eliminar"));

        $this->tabla->setSelect("tt.idtemptraslados, tt.asociado, tt.tipo_documento, tt.nrodoc, tt.division, tt.pais, tt.union, tt.mision, tt.distritomisionero, tt.iglesia, '<center><button type=\"button\" onclick=\"eliminar_temp_traslado(''' || tt.idtemptraslados || ''')\" class=\"btn btn-danger btn-xs\" ><i class=\"fa fa-trash\"></i></button></center>' AS boton");
        $this->tabla->setFrom("iglesias.temp_traslados AS tt");

        if(isset($_REQUEST["tipo_traslado"])) {
            $this->tabla->setWhere("tt.tipo_traslado=".$_REQUEST["tipo_traslado"]);
        }
        return $this->tabla;
    }


    public function tabla_asociados_traslados() {

        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-asociados-traslados");
        $this->tabla->agregarColumna("vat.idmiembro", "idmiembro", "Id");
        $this->tabla->agregarColumna("vat.asociado", "asociado", traducir("traductor.nombres"));
     
        $this->tabla->agregarColumna("vat.tipo_documento", "tipo_documento", traducir("traductor.tipo_documento"));
        $this->tabla->agregarColumna("vat.nrodoc", "nrodoc", traducir("traductor.numero_documento"));
        $this->tabla->agregarColumna("vat.division", "division", traducir("traductor.division"));
        $this->tabla->agregarColumna("vat.pais", "pais", traducir("traductor.pais"));
        $this->tabla->agregarColumna("vat.union", "union", traducir("traductor.union"));
        $this->tabla->agregarColumna("vat.mision", "mision", traducir("traductor.mision"));
        $this->tabla->agregarColumna("vat.distritomisionero", "distritomisionero", traducir("traductor.distrito_misionero"));
        $this->tabla->agregarColumna("vat.iglesia", "iglesia", traducir("traductor.iglesia"));
        $this->tabla->agregarColumna("vat.idmiembro", "boton", traducir("traductor.agregar"));


        if(isset($_REQUEST["tipo_traslado"]) && $_REQUEST["tipo_traslado"] != "3") {
            $this->tabla->setSelect("vat.idmiembro, vat.asociado, vat.tipo_documento, vat.nrodoc, vat.division, vat.pais, vat.union, vat.mision, vat.distritomisionero, vat.iglesia, '<center><button type=\"button\" onclick=\"agregar_temp_traslado(''' || vat.idmiembro || ''')\" class=\"btn btn-success btn-xs\" ><i class=\"fa fa-plus\"></i></button></center>' AS boton");
            $this->tabla->setFrom("iglesias.vista_asociados_traslados AS vat");
        } else {
            $this->tabla->setSelect("vat.idmiembro, vat.asociado, vat.tipo_documento, vat.nrodoc, vat.division, vat.pais, vat.union, vat.mision, vat.distritomisionero, vat.iglesia, '<center><button type=\"button\" onclick=\"trasladar(''' || vat.idmiembro || ''')\" class=\"btn btn-primary btn-xs\" ><i class=\"fa fa-arrow-circle-o-right\"></i></button></center>' AS boton");
            $this->tabla->setFrom("iglesias.vista_asociados_traslados AS vat");
        }
       

     
        return $this->tabla;

    }


    public function tabla_control() {
        
        $this->tabla = new Tabla();
        $this->tabla->asignarID("tabla-control-traslados");
        $this->tabla->agregarColumna("ct.idcontrol", "idcontrol", "Id");
        $this->tabla->agregarColumna("(m.apellidos || ', ' || m.nombres),", "asociado", traducir("traductor.asociado"));
        $this->tabla->agregarColumna("(SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior)", "iglesia_anterior", traducir("traductor.iglesia_anterior"));
     
        $this->tabla->agregarColumna("(SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) ", "iglesia_traslado", traducir("traductor.iglesia_traslado"));
        $this->tabla->agregarColumna("ct.fecha", "fecha", traducir("traductor.fecha"));
        $this->tabla->agregarColumna("ct.estado", "estado", traducir("traductor.estado"));
        $this->tabla->agregarColumna("ct.idcontol", "boton", traducir("traductor.imprimir"));


        $this->tabla->setSelect(" 
        ct.idcontrol,
        (m.apellidos || ', ' || m.nombres) AS asociado,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaanterior) AS iglesia_anterior,
        (SELECT v.division || ' / ' || v.pais  || ' / ' ||  v.union || ' / ' || v.mision  || ' / ' || v.iglesia FROM iglesias.vista_jerarquia AS v WHERE v.idiglesia=ct.idiglesiaactual) AS iglesia_traslado,
        to_char(ct.fecha, 'DD/MM/YYYY') AS fecha,
        CASE WHEN ct.estado='1' THEN 'PENDIENTE' ELSE 'TRASLADADO' END AS estado, '<center><button type=\"button\" onclick=\"imprimir_respuesta_carta_iglesia(''' || ct.idcontrol || ''')\" class=\"btn btn-danger btn-xs\" ><i class=\"fa fa-file-pdf-o\"></i></button></center>' AS boton");
        $this->tabla->setFrom("iglesias.control_traslados AS ct 
        \nINNER JOIN iglesias.miembro AS m ON(ct.idmiembro=m.idmiembro)");
        $this->tabla->setWhere("ct.estado='1'");

     
        return $this->tabla;
    }

    
    
    

}
