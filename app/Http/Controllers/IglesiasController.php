<?php

namespace App\Http\Controllers;

use App\Models\BaseModel;
use App\Models\DistritosmisionerosModel;
use App\Models\DivisionesModel;
use App\Models\IglesiasModel;
use App\Models\MisionesModel;
use App\Models\PaisesModel;
use App\Models\PrincipalModel;
use App\Models\UnionesModel;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;

class IglesiasController extends Controller
{
    //

    private $base_model;
    private $iglesias_model;
    private $principal_model;
    private $divisiones_model;
    private $paises_model;
    private $uniones_model;
    private $misiones_model;
    private $distritos_misioneros_model;

    public function __construct() {
        parent:: __construct();
        $this->iglesias_model = new IglesiasModel();
        $this->principal_model = new PrincipalModel();
        $this->base_model = new BaseModel();
        $this->divisiones_model = new DivisionesModel();
        $this->paises_model = new PaisesModel();
        $this->uniones_model = new UnionesModel();
        $this->misiones_model = new MisionesModel();
        $this->distritos_misioneros_model = new DistritosmisionerosModel();
    }

    public function index() {
        $view = "iglesias.index";
        $data["title"] = traducir('traductor.titulo_iglesias');
        $data["subtitle"] = "";
        $data["tabla"] = $this->iglesias_model->tabla()->HTML();

        $botones = array();
        $botones[0] = '<button disabled="disabled" tecla_rapida="F1" style="margin-right: 5px;" class="btn btn-default btn-sm" id="nueva-iglesia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/agregar-archivo.png').'"><br>'.traducir("traductor.nuevo").' [F1]</button>';
        $botones[1] = '<button disabled="disabled" tecla_rapida="F2" style="margin-right: 5px;" class="btn btn-default btn-sm" id="modificar-iglesia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/editar-documento.png').'"><br>'.traducir("traductor.modificar").' [F2]</button>';
        $botones[2] = '<button disabled="disabled" tecla_rapida="F7" style="margin-right: 5px;" class="btn btn-default btn-sm" id="eliminar-iglesia"><img style="width: 19px; height: 20px;" src="'.URL::asset('images/iconos/delete.png').'"><br>'.traducir("traductor.eliminar").' [F7]</button>';
        $data["botones"] = $botones;
        // $data["scripts"] = $this->cargar_js(["divisiones.js", "idiomas.js", "paises.js", "uniones.js", "misiones.js", "distritos_misioneros.js", "iglesias.js"]);
        $data["scripts"] = $this->cargar_js(["iglesias.js"]);
        return parent::init($view, $data);



    }

    public function buscar_datos() {
        $json_data = $this->iglesias_model->tabla()->obtenerDatos();
        echo json_encode($json_data);
    }


    public function guardar_iglesias(Request $request) {

        $_POST = $this->toUpper($_POST, ["descripcion", "direccion"]);

        $array_pais = explode("|", $_POST["pais_id"]);
        $_POST["pais_id"] = $array_pais[0];
        if($array_pais[1] == "N" && empty($request->input("idunion"))) {
            $sql = "SELECT * FROM iglesias.union AS u
            INNER JOIN iglesias.union_paises AS up ON(u.idunion=up.idunion)
            WHERE up.pais_id={$_POST["pais_id"]}";
            $res = DB::select($sql);
            $_POST["idunion"] = $res[0]->idunion;
        }


        if ($request->input("idiglesia") == '') {
            $result = $this->base_model->insertar($this->preparar_datos("iglesias.iglesia", $_POST));
        }else{
            $result = $this->base_model->modificar($this->preparar_datos("iglesias.iglesia", $_POST));
        }

        echo json_encode($result);
    }

    public function eliminar_iglesias() {


        try {
            $sql_asociados = "SELECT * FROM iglesias.miembro WHERE idiglesia=".$_REQUEST["id"];
            $asociados = DB::select($sql_asociados);

            if(count($asociados) > 0) {
                throw new Exception(traducir("traductor.eliminar_iglesia_asociado"));
            }

            $result = $this->base_model->eliminar(["iglesias.iglesia","idiglesia"]);
            echo json_encode($result);
        } catch (Exception $e) {
            echo json_encode(array("status" => "ee", "msg" => $e->getMessage()));
        }
    }

    public function select_init(Request $request) {

        $data = array();

        $data["idcategoriaiglesia"] = $this->principal_model->obtener_categorias_iglesia();
        $data["iddepartamento"] = $this->principal_model->obtener_departamentos($request);
        $data["idprovincia"] = $this->principal_model->obtener_provincias($request);
        $data["iddistrito"] = $this->principal_model->obtener_distritos($request);
        $data["iddivision"] = $this->divisiones_model->obtener_divisiones($request);
        $data["pais_id"] = $this->divisiones_model->obtener_divisiones($request);
        $data["idunion"] = $this->uniones_model->obtener_uniones_paises($request);
        $data["idmision"] = $this->misiones_model->obtener_misiones($request);
        $data["iddistritomisionero"] = $this->distritos_misioneros_model->obtener_distritos_misioneros($request);

        echo json_encode($data);
    }


    public function get_iglesias(Request $request) {

        $sql = "SELECT i.*, (i.pais_id || '|' || p.posee_union) AS pais_id, p.posee_union FROM iglesias.iglesia AS i
        LEFT JOIN iglesias.paises AS p ON(p.pais_id=i.pais_id)
        WHERE i.idiglesia=".$request->input("id");
        $one = DB::select($sql);

        $sql_activos = "SELECT * FROM iglesias.miembro WHERE estado='1' AND idiglesia=".$request->input("id");
        $activos = DB::select($sql_activos);

        $sql_inactivos = "SELECT * FROM iglesias.miembro WHERE estado='0' AND idiglesia=".$request->input("id");
        $inactivos = DB::select($sql_inactivos);

        $one[0]->activos = count($activos);
        $one[0]->inactivos = count($inactivos);

        echo json_encode($one);
    }

    public function obtener_iglesias(Request $request) {

        $result = $this->iglesias_model->obtener_iglesias($request);
        echo json_encode($result);
    }

    public function obtener_iglesias_all(Request $request) {
        $result = $this->iglesias_model->obtener_iglesias_all($request);
        echo json_encode($result);
    }

    public function ver_activos($idiglesia) {
        $sql = "SELECT *, i.descripcion AS iglesia, td.descripcion AS tipo_documento
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.iglesia AS i ON(m.idiglesia=i.idiglesia)
        INNER JOIN public.tipodoc AS td ON(m.idtipodoc=td.idtipodoc)
        WHERE m.estado='1' AND m.idiglesia=".$idiglesia;

        $iglesias = DB::select($sql);
        return view("iglesias.activos", array("iglesias" => $iglesias));
    }


    public function ver_inactivos($idiglesia) {
        $sql = "SELECT *, i.descripcion AS iglesia, td.descripcion AS tipo_documento
        FROM iglesias.miembro AS m
        INNER JOIN iglesias.iglesia AS i ON(m.idiglesia=i.idiglesia)
        INNER JOIN public.tipodoc AS td ON(m.idtipodoc=td.idtipodoc)
        WHERE m.estado='0' AND m.idiglesia=".$idiglesia;

        $iglesias = DB::select($sql);
        return view("iglesias.inactivos", array("iglesias" => $iglesias));

    }


}
