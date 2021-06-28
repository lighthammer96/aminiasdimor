<?php

use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Lang;

// referencia: https://laracasts.com/discuss/channels/laravel/determining-if-a-translation-in-specific-locale-exists
function traducir($valor){
    App::setLocale(trim(session("idioma_codigo")));
    if(Lang::has($valor)) {
        return trans($valor);
    } else {
        App::setLocale(trim(session("idioma_defecto")));
        return trans($valor);
    }
}
?>