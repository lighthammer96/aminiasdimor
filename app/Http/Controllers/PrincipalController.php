<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;

class PrincipalController extends Controller
{
    //


    public function __construct() {
        parent::__construct();
    }

    public function index() {
        App::setLocale(trim(session("idioma_codigo")));
        $view = "principal.index";
        $datos = array();
        $datos["subtitle"] = trans('traductor.sistema');
        $datos["title"] = trans('traductor.welcome');

        $datos["scripts"] = $this->cargar_js(["principal.js"]);
        
        return parent::init($view, $datos);
        // return view($view, $datos);
    }
}
