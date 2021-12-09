<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class ResolucionesModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        
        //$tabla = new Tabla();


    }

    public function FormatoFecha($fecha, $formato) {
        if($fecha != null) {
            if($formato == "user") {
                $date = explode("-", $fecha);
                if(count($date) == 3) {
                    return $date[2] . "/" . $date[1] . "/" . $date[0];
                }
            }

            if($formato == "server") {
                $date = explode("/", $fecha);
                if(count($date) == 3) {
                    return $date[2] . "-" . $date[1] . "-" . $date[0];
                }
            }
        }

        return $fecha;
    }

    public function tabla() {
        $tabla = new Tabla();
        $where = "1=1";

        
        if(isset($_REQUEST["fecha_inicio"]) && isset($_REQUEST["fecha_fin"]) && !empty($_REQUEST["fecha_inicio"]) && !empty($_REQUEST["fecha_fin"])) {
            $where .= " AND to_char(r.resolucion_fecha, 'YYYY-MM-DD') BETWEEN '".$this->FormatoFecha($_REQUEST["fecha_inicio"], "server")."' AND '".$this->FormatoFecha($_REQUEST["fecha_fin"], "server")."' ";

        } else if(isset($_REQUEST["fecha_inicio"]) && !empty($_REQUEST["fecha_inicio"])) {
            
            $where .= " AND to_char(r.resolucion_fecha, 'YYYY-MM-DD') >= '".$this->FormatoFecha($_REQUEST["fecha_inicio"], "server")."'";
        } else if(isset($_REQUEST["fecha_fin"]) && !empty($_REQUEST["fecha_fin"])) {
            
            $where .= " AND to_char(r.resolucion_fecha, 'YYYY-MM-DD') <= '".$this->FormatoFecha($_REQUEST["fecha_fin"], "server")."'";
        }


        $tabla->asignarID("tabla-resoluciones");
        $tabla->agregarColumna("r.resolucion_id", "resolucion_id", "Id");
        $tabla->agregarColumna("tr.tr_descripcion", "tr_descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("r.resolucion_fecha", "resolucion_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("CASE WHEN tr.tr_titulo_propuesta IS NULL THEN (SELECT tr_titulo_propuesta FROM asambleas.traduccion_resoluciones WHERE resolucion_id=r.resolucion_id AND tr_idioma='".trim(session("idioma_defecto"))."') ELSE tr.tr_titulo_propuesta", "propuesta", traducir("asambleas.propuesta"));
        $tabla->agregarColumna("r.resolucion_estado", "resolucion_estado", traducir("asambleas.estado_resolucion"));
        $tabla->setSelect("r.resolucion_id, 
   
        CASE WHEN tr.tr_descripcion IS NULL THEN (SELECT tr_descripcion FROM asambleas.traduccion_resoluciones WHERE resolucion_id=r.resolucion_id AND tr_idioma='".trim(session("idioma_defecto"))."') ELSE tr.tr_descripcion  END AS tr_descripcion, 

        ".formato_fecha_idioma(" r.resolucion_fecha")." AS resolucion_fecha,
        /* 
        CASE WHEN r.tabla ='asambleas.propuestas_temas' 
        THEN 
        (CASE WHEN tpt.tpt_titulo IS NULL THEN (SELECT tpt_titulo FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."') ELSE tpt.tpt_titulo  END)
        ELSE 
        (CASE WHEN tpe.tpe_descripcion IS NULL THEN (SELECT tpe_descripcion FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_descripcion  END)
        END AS propuesta, */
        CASE WHEN tr.tr_titulo_propuesta IS NULL THEN (SELECT tr_titulo_propuesta FROM asambleas.traduccion_resoluciones WHERE resolucion_id=r.resolucion_id AND tr_idioma='".trim(session("idioma_defecto"))."') ELSE tr.tr_titulo_propuesta  END AS propuesta, 

        CASE 
        WHEN r.resolucion_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN r.resolucion_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN r.resolucion_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS resolucion_estado,
        r.resolucion_estado AS estado_resolucion
        /*CASE WHEN r.estado='A' THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado*/");
        $tabla->setFrom("asambleas.resoluciones AS r
        /*\nLEFT JOIN asambleas.propuestas_temas AS pt on(pt.pt_id=r.propuesta_id AND r.tabla='asambleas.propuestas_temas')
        \nLEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".session("idioma_codigo")."')
        \nLEFT JOIN asambleas.propuestas_elecciones AS pe on(pe.pe_id=r.propuesta_id AND r.tabla='asambleas.propuestas_elecciones')
        \n LEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id AND tpe.tpe_idioma='".session("idioma_codigo")."')*/
        \nLEFT JOIN asambleas.traduccion_resoluciones AS tr ON(tr.resolucion_id=r.resolucion_id AND tr.tr_idioma='".session("idioma_codigo")."')");
        // die($where);
        $tabla->setWhere($where);

        return $tabla;
    }


  
}
