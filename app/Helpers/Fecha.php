<?php 
    function formato_fecha_idioma($campo_fecha) {
        $formato = "";
        if(trim(session("idioma_codigo")) == "es") {
            $formato = " to_char(".$campo_fecha.", 'DD/MM/YYYY') ";
        }

        if(trim(session("idioma_codigo")) == "en") {
            $formato = $campo_fecha;
        }

        return $formato;
    }

    function fecha_actual_idioma() {
        $formato = "";
        if(trim(session("idioma_codigo")) == "es") {
            $formato = date("d/m/Y");
        }

        if(trim(session("idioma_codigo")) == "en") {
            $formato = date("Y-m-d");
        }

        return $formato;
    }


?>