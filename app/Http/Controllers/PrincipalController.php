<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;

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

    public function obtener_departamentos() {
        $sql = "SELECT iddepartamento as id, descripcion FROM public.departamento";
        $result = DB::select($sql);
        echo json_encode($result);
    }


    public function obtener_provincias(Request $request) {
        $sql = "";
		if(isset($_REQUEST["iddepartamento"]) && !empty($_REQUEST["iddepartamento"])) {
	
			$sql = "SELECT idprovincia as id,  descripcion FROM public.provincia WHERE iddepartamento=".$request->input("iddepartamento");
		} else {
			$sql = "SELECT idprovincia as id, descripcion FROM public.provincia";
		}

        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_distritos(Request $request) {
        $sql = "";
		if(isset($_REQUEST["idprovincia"]) && !empty($_REQUEST["idprovincia"])) {
            $sql = "SELECT iddistrito as id, descripcion FROM public.distrito WHERE idprovincia=".$request->input("idprovincia");
			$result = DB::select($sql);
		} else {
	
            $sql = "SELECT iddistrito as id, descripcion FROM public.distrito";
            $result = DB::select($sql);
		}

        echo json_encode($result);
	}

    public function obtener_divisiones() {
        $sql = "SELECT iddivision as id, descripcion FROM iglesias.division";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_tipos_documento() {
        $sql = "SELECT idtipodoc as id, descripcion FROM public.tipodoc ORDER BY idtipodoc ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_tipos_acceso() {
        $sql = "SELECT idtipoacceso as id, descripcion FROM seguridad.tipoacceso 
        ORDER BY idtipoacceso ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_categorias_iglesia() {
        $sql = "SELECT idcategoriaiglesia as id, descripcion FROM iglesias.categoriaiglesia 
        ORDER BY idcategoriaiglesia ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_tipos_construccion() {
        $sql = "SELECT idtipoconstruccion as id, descripcion FROM public.tipoconstruccion 
        ORDER BY idtipoconstruccion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_tipos_documentacion() {
        $sql = "SELECT idtipodocumentacion as id, descripcion FROM public.tipodocumentacion 
        ORDER BY idtipodocumentacion ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_tipos_inmueble() {
        $sql = "SELECT idtipoinmueble as id, descripcion FROM public.tipoinmueble 
        ORDER BY idtipoinmueble ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }

    public function obtener_condicion_inmueble() {
        $sql = "SELECT idcondicioninmueble as id, descripcion FROM public.condicioninmueble 
        ORDER BY idcondicioninmueble ASC";
        $result = DB::select($sql);
        echo json_encode($result);
    }
}
