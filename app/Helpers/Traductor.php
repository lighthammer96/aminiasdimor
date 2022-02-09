<?php

use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Lang;

// referencia: https://laracasts.com/discuss/channels/laravel/determining-if-a-translation-in-specific-locale-exists

function traducir($valor){
    App::setLocale(trim(session("idioma_codigo")));
    // dd(Lang::hasForLocale('traductor.item', 'es'));
    // if(Lang::has($valor)) {
    if(Lang::hasForLocale($valor, trim(session("idioma_codigo")))) {
        return trans($valor);
    } else {
        App::setLocale(trim(session("idioma_defecto")));
        return trans($valor);
    }
}


// referencia: https://github.com/laravel/framework/commit/3c4ec8112daee69bd50c5a5fa174642924a151ea
?>