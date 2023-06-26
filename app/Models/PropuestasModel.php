<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Tabla;
use Illuminate\Support\Facades\DB;

class PropuestasModel extends Model
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


    public function tabla($con_votacion = "N") {
        $where = "1=1";
        $join = "";
        if($con_votacion == "S") {
            $where = "pt.estado='A' AND r.resolucion_id IS NULL";
            $join = "INNER JOIN asambleas.votaciones AS vs ON(vs.propuesta_id = pt.pt_id AND vs.tabla='asambleas.propuestas_temas' AND vs.estado='A')
            LEFT JOIN asambleas.resultados AS r ON(r.votacion_id=vs.votacion_id)";
        }

        $and = "AND tpt.tpt_idioma='".session("idioma_codigo")."'";

        if(isset($_REQUEST["idioma_codigo"])) {
            $where .= " AND tpt.tpt_idioma='".$_REQUEST["idioma_codigo"]."'";
        }

        if(isset($_REQUEST["fecha_inicio"]) && isset($_REQUEST["fecha_fin"]) && !empty($_REQUEST["fecha_inicio"]) && !empty($_REQUEST["fecha_fin"])) {
            $where .= " AND pt.pt_fecha BETWEEN '".$this->FormatoFecha($_REQUEST["fecha_inicio"], "server")."' AND '".$this->FormatoFecha($_REQUEST["fecha_fin"], "server")."' ";

        } else if(isset($_REQUEST["fecha_inicio"]) && !empty($_REQUEST["fecha_inicio"])) {

            $where .= " AND pt.pt_fecha >= '".$this->FormatoFecha($_REQUEST["fecha_inicio"], "server")."'";
        } else if(isset($_REQUEST["fecha_fin"]) && !empty($_REQUEST["fecha_fin"])) {

            $where .= " AND pt.pt_fecha <= '".$this->FormatoFecha($_REQUEST["fecha_fin"], "server")."'";
        }


        if(isset($_REQUEST["pais_id"]) && !empty($_REQUEST["pais_id"])) {
            $pais = explode("|", $_REQUEST["pais_id"]);

            $where .= " AND pt.pais_id = {$pais[0]}";
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
        \nLEFT JOIN iglesias.paises AS p on(p.pais_id=pt.pais_id)
        \nLEFT JOIN asambleas.traduccion_propuestas_temas AS tpt ON(tpt.pt_id=pt.pt_id {$and})
        {$join}");
        // die($where);
        $tabla->setWhere($where);
        return $tabla;
    }


    public function tabla_propuestas_elecciones($con_votacion = "N") {
        $where = "1=1";
        $join = "";
        if($con_votacion == "S") {
            $where = "pe.estado='A'  AND r.resolucion_id IS NULL";
            $join = "INNER JOIN asambleas.votaciones AS vs ON(vs.propuesta_id = pe.pe_id AND vs.tabla='asambleas.propuestas_elecciones' AND vs.estado='A')
            LEFT JOIN asambleas.resultados AS r ON(r.votacion_id=vs.votacion_id)";
        }

        $and = "AND tpe.tpe_idioma='".trim(session("idioma_codigo"))."'";

        if(isset($_REQUEST["idioma_codigo"])) {
            $and = "AND tpe.tpe_idioma='".trim($_REQUEST["idioma_codigo"])."'";
        }

        if(isset($_REQUEST["fecha_inicio"]) && isset($_REQUEST["fecha_fin"]) && !empty($_REQUEST["fecha_inicio"]) && !empty($_REQUEST["fecha_fin"])) {
            $where .= " AND pe.pe_fecha BETWEEN '".$this->FormatoFecha($_REQUEST["fecha_inicio"], "server")."' AND '".$this->FormatoFecha($_REQUEST["fecha_fin"], "server")."' ";

        } else if(isset($_REQUEST["fecha_inicio"]) && !empty($_REQUEST["fecha_inicio"])) {

            $where .= " AND pe.pe_fecha >= '".$this->FormatoFecha($_REQUEST["fecha_inicio"], "server")."'";
        } else if(isset($_REQUEST["fecha_fin"]) && !empty($_REQUEST["fecha_fin"])) {

            $where .= " AND pe.pe_fecha <= '".$this->FormatoFecha($_REQUEST["fecha_fin"], "server")."'";
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
        \nLEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id {$and})
        {$join}");
        // die($where);
        $tabla->setWhere($where);

        return $tabla;
    }


    public function tabla_propuestas_elecciones_origen() {

        $and = "AND tpe.tpe_idioma='".trim(session("idioma_codigo"))."'";

        if(isset($_REQUEST["idioma_codigo"])) {
            $and = "AND tpe.tpe_idioma='".trim($_REQUEST["idioma_codigo"])."'";
        }



        $tabla = new Tabla();
        $tabla->asignarID("tabla-propuestas-elecciones-origen");
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
        CASE WHEN pe.estado='A' THEN '".traducir("traductor.estado_activo")."' ELSE '".traducir("traductor.estado_inactivo")."' END AS estado, pe.pe_estado AS estado_propuesta, date_part('year', pe.pe_fecha) AS anio, pe.pe_correlativo, pe.estado AS state, r.resolucion_id");
        $tabla->setFrom("asambleas.propuestas_elecciones AS pe
        \nLEFT JOIN asambleas.traduccion_propuestas_elecciones AS tpe ON(tpe.pe_id=pe.pe_id {$and})
        \nINNER JOIN asambleas.resoluciones AS r ON(r.propuesta_id=pe.pe_id AND r.tabla='asambleas.propuestas_elecciones')");

        $tabla->setWhere("pe.estado='A'");

        return $tabla;
    }

    public function obtener_categorias_propuestas() {
        $sql = "SELECT cp_id as id, cp_descripcion AS descripcion FROM asambleas.categorias_propuestas
        WHERE estado='A'
        ORDER BY cp_descripcion ASC";
        $result = DB::select($sql);
        return $result;
    }

    public function obtener_formas_votacion($request) {
        $sql = "SELECT fv_id as id, fv_descripcion AS descripcion FROM asambleas.formas_votacion
        WHERE estado='A' AND fv_tipo='{$request->input("fv_tipo")}'
        ORDER BY fv_descripcion ASC";
        $result = DB::select($sql);
        return $result;
    }


}
