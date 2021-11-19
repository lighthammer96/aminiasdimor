<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;


class PropuestasModel extends Model
{
    use HasFactory;

    

    public function __construct() {
        parent::__construct();
        //$tabla = new Tabla();
    }

    public function tabla($con_votacion = "N") {
        $where = "1=1";
        if($con_votacion == "S") {
            $where = "pt.estado='A'";
        }

        $and = "AND tpt.tpt_idioma='".session("idioma_codigo")."'";

        if(isset($_REQUEST["idioma_codigo"])) {
            $and = "AND tpt.tpt_idioma='".$_REQUEST["idioma_codigo"]."'";
        }


        $tabla = new Tabla();
        $tabla->asignarID("tabla-propuestas-temas");
        $tabla->agregarColumna("pt.pt_id", "pt_id", "Id");
        $tabla->agregarColumna("pt.pt_fecha", "pt_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("pt.pt_correlativo", "pt_correlativo", traducir("asambleas.correlativo"));
        $tabla->agregarColumna("pt.tpt_titulo", "tpt_titulo", traducir("asambleas.titulo"));
       
        $tabla->agregarColumna("pt.pais_descripcion", "pais", traducir("traductor.pais"));
        $tabla->agregarColumna("pt.lugar", "lugar", traducir("asambleas.de"));
        $tabla->agregarColumna("pt.pt_estado", "pt_estado", traducir("asambleas.estado_propuesta"));
        $tabla->agregarColumna("pt.estado", "estado", traducir("traductor.estado"));
       
        $tabla->setSelect("pt.pt_id, ".formato_fecha_idioma(" pt.pt_fecha")." AS pt_fecha, pt.pt_correlativo, 
        CASE WHEN tpt.tpt_titulo IS NULL THEN (SELECT tpt_titulo FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."') ELSE tpt.tpt_titulo  END AS tpt_titulo, 

        
        p.pais_descripcion AS pais, pt.lugar, CASE 
        WHEN pt.pt_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN pt.pt_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN pt.pt_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS pt_estado, 
        CASE WHEN pt.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado, pt.pt_estado AS estado_propuesta,  date_part('year', pt.pt_fecha) AS anio, pt.estado AS state,
        CASE WHEN tpt.tpt_propuesta IS NULL THEN (SELECT tpt_propuesta FROM asambleas.traduccion_propuestas_temas WHERE pt_id=pt.pt_id AND tpt_idioma='".trim(session("idioma_defecto"))."') ELSE tpt.tpt_propuesta  END AS tpt_propuesta");
        $tabla->setFrom("asambleas.propuestas_temas AS pt
        \nINNER JOIN iglesias.paises AS p on(p.pais_id=pt.pais_id)
        \nLEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id {$and})");
        $tabla->setWhere($where);
        return $tabla;
    }


    public function tabla_propuestas_elecciones($con_votacion = "N") {
        $where = "1=1";
        if($con_votacion == "S") {
            $where = "pe.estado='A'";
        }

        $and = "AND tpe.tpe_idioma='".trim(session("idioma_codigo"))."'";

        if(isset($_REQUEST["idioma_codigo"])) {
            $and = "AND tpe.tpe_idioma='".trim($_REQUEST["idioma_codigo"])."'";
        }

        $tabla = new Tabla();
        $tabla->asignarID("tabla-propuestas-elecciones");
        $tabla->agregarColumna("pe.pe_id", "pe_id", "Id");
        $tabla->agregarColumna("pe.pe_fecha", "pe_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("tpe.tpe_descripcion", "tpe_descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("tpe.tpe_detalle_propuesta", "tpe_detalle_propuesta", traducir("asambleas.detalle_propuesta"));

       
        $tabla->agregarColumna("pe.pe_estado", "pe_estado", traducir("asambleas.estado_propuesta"));
        $tabla->agregarColumna("pe.estado", "estado", traducir("traductor.estado"));
       
        $tabla->setSelect("pe.pe_id, ".formato_fecha_idioma(" pe.pe_fecha")." AS pe_fecha, 
        CASE WHEN tpe.tpe_descripcion IS NULL THEN (SELECT tpe_descripcion FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_descripcion  END AS tpe_descripcion, 

        CASE WHEN tpe.tpe_detalle_propuesta IS NULL THEN (SELECT tpe_detalle_propuesta FROM asambleas.traduccion_propuestas_elecciones WHERE pe_id=pe.pe_id AND tpe_idioma='".trim(session("idioma_defecto"))."') ELSE tpe.tpe_detalle_propuesta END  AS tpe_detalle_propuesta, 
        
        CASE 
        WHEN pe.pe_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN pe.pe_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN pe.pe_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS pe_estado, 
        CASE WHEN pe.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado, pe.pe_estado AS estado_propuesta, date_part('year', pe.pe_fecha) AS anio, pe.pe_correlativo, pe.estado AS state");
        $tabla->setFrom("asambleas.propuestas_elecciones AS pe
        \nLEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id {$and})");

        $tabla->setWhere($where);

        return $tabla;
    }


  
} 
