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

    public function tabla() {
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
       
        $tabla->setSelect("pt.pt_id, ".formato_fecha_idioma(" pt.pt_fecha")." AS pt_fecha, pt.pt_correlativo, tpt.tpt_titulo, p.pais_descripcion AS pais, pt.lugar, CASE 
        WHEN pt.pt_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN pt.pt_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN pt.pt_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS pt_estado, 
        CASE WHEN pt.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado, pt.pt_estado AS estado_propuesta,  date_part('year', pt.pt_fecha) AS anio");
        $tabla->setFrom("asambleas.propuestas_temas AS pt
        \nINNER JOIN iglesias.paises AS p on(p.pais_id=pt.pais_id)
        \nLEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id AND tpt.tpt_idioma='".session("idioma_codigo")."')");

        return $tabla;
    }


    public function tabla_propuestas_elecciones() {
        $tabla = new Tabla();
        $tabla->asignarID("tabla-propuestas-elecciones");
        $tabla->agregarColumna("pe.pe_id", "pe_id", "Id");
        $tabla->agregarColumna("pe.pe_fecha", "pe_fecha", traducir("traductor.fecha"));
        $tabla->agregarColumna("tpe.tpe_descripcion", "tpe_descripcion", traducir("traductor.descripcion"));
        $tabla->agregarColumna("tpe.tpe_detalle_propuesta", "tpe_detalle_propuesta", traducir("asambleas.detalle_propuesta"));

       
   
       
        $tabla->agregarColumna("pe.pe_estado", "pe_estado", traducir("asambleas.estado_propuesta"));
        $tabla->agregarColumna("pe.estado", "estado", traducir("traductor.estado"));
       
        $tabla->setSelect("pe.pe_id, ".formato_fecha_idioma(" pe.pe_fecha")." AS pe_fecha, tpe.tpe_descripcion, tpe.tpe_detalle_propuesta, CASE 
        WHEN pe.pe_estado=1 THEN '".traducir("asambleas.proceso_registro")."' 
        WHEN pe.pe_estado=2 THEN '".traducir("asambleas.enviado_traduccion")."' 
        WHEN pe.pe_estado=3 THEN '".traducir("asambleas.traduccion_completa")."' 
        END AS pe_estado, 
        CASE WHEN pe.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado, pe.pe_estado AS estado_propuesta, date_part('year', pe.pe_fecha) AS anio, pe.pe_correlativo");
        $tabla->setFrom("asambleas.propuestas_elecciones AS pe
        \nLEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id AND tpe.tpe_idioma='".session("idioma_codigo")."')");

        return $tabla;
    }


  
}
