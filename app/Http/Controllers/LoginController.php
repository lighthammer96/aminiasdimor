<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller
{
    //
    public function loguearse(Request $request) {
        $data = array();
        $data["response"] = "nopass";
        $user = strtolower($request->input('user'));
        $pass = $request->input('pass');
        // $clave = Hash::make('1235');
        // echo $clave; exit;
        // echo Hash::check("1235", $clave);

        $result = DB::select("SELECT u.*, p.*, m.*, ta.descripcion AS tipo_acceso FROM seguridad.usuarios AS u 
        INNER JOIN seguridad.perfiles AS p ON(u.perfil_id=p.perfil_id)
        LEFT JOIN iglesias.miembro AS m ON(u.idmiembro=m.idmiembro)
        LEFT JOIN seguridad.tipoacceso AS ta ON(ta.idtipoacceso=u.idtipoacceso)
        
        WHERE u.usuario_user='{$user}'");
        // var_dump($result[0]->idmiembro); exit;
        if(!isset($result[0]->usuario_user)) {
            $data["response"] = "nouser";
        }
        if(isset($result[0]->usuario_pass) && Hash::check($pass, $result[0]->usuario_pass)) {
            $data["response"] = "ok";
            //$request->session()->put('usuario_id', $result[0]->usuario_id);
            session(['usuario_id' => $result[0]->usuario_id]);
            session(['usuario_user' => $result[0]->usuario_user]);
            session(['perfil_id' => $result[0]->perfil_id]);
            session(['pais_id' => $result[0]->pais_id]);
            session(['perfil_descripcion' => $result[0]->perfil_descripcion]);
            session(['idtipoacceso' => $result[0]->idtipoacceso]);
            session(['foto' => $result[0]->foto]);
            session(['responsable' => $result[0]->apellidos.", ".$result[0]->nombres]);
            session(['tipo_acceso' => $result[0]->tipo_acceso]);
            
            $where_division = "";
            $where_pais = "";
            $where_union = "";
            $where_mision = "";
            $where_distrito_misionero = "";
            $array_tipos_acceso = array();
            if($result[0]->perfil_id != 1) {
                switch ($result[0]->idtipoacceso) {
                    case '1':
                        $where_division = "AND d.iddivision = ".$result[0]->iddivision;
                        $where_pais = "AND pais_id = ".$result[0]->pais_id;
                        $where_union = "AND u.idunion = ".$result[0]->idunion;
                        $where_mision = "AND idmision = ".$result[0]->idmision;
                        $where_distrito_misionero = "AND iddistritomisionero = ".$result[0]->iddistritomisionero;
                        array_push($array_tipos_acceso, array("iddivision" => $result[0]->iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $result[0]->pais_id));
                        array_push($array_tipos_acceso, array("idunion" => $result[0]->idunion));
                        array_push($array_tipos_acceso, array("idmision" => $result[0]->idmision));
                        array_push($array_tipos_acceso, array("where_distrito_misionero" => $result[0]->where_distrito_misionero));
                        break;
                    case '2':
                        $where_division = "AND d.iddivision = ".$result[0]->iddivision;
                        $where_pais = "AND pais_id = ".$result[0]->pais_id;
                        $where_union = "AND u.idunion = ".$result[0]->idunion;
                        $where_mision = "AND idmision = ".$result[0]->idmision;
                        $where_distrito_misionero = "";

                        array_push($array_tipos_acceso, array("iddivision" => $result[0]->iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $result[0]->pais_id));
                        array_push($array_tipos_acceso, array("idunion" => $result[0]->idunion));
                        array_push($array_tipos_acceso, array("idmision" => $result[0]->idmision));
                       
                        break;
                    case '3':
                        $where_division = "AND d.iddivision = ".$result[0]->iddivision;
                        $where_pais = "AND pais_id = ".$result[0]->pais_id;
                        $where_union = "AND u.idunion = ".$result[0]->idunion;
                        $where_mision = "";
                        $where_distrito_misionero = "";

                        array_push($array_tipos_acceso, array("iddivision" => $result[0]->iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $result[0]->pais_id));
                        array_push($array_tipos_acceso, array("idunion" => $result[0]->idunion));
                        
                        break;
                    case '4':
                        $where_division = "AND d.iddivision = ".$result[0]->iddivision;
                        $where_pais = "AND pais_id = ".$result[0]->pais_id;
                        $where_union = "";
                        $where_mision = "";
                        $where_distrito_misionero = "";

                        array_push($array_tipos_acceso, array("iddivision" => $result[0]->iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $result[0]->pais_id));
                       
                        break;
                    case '5':
                        $where_division = "AND d.iddivision = ".$result[0]->iddivision;
                        $where_pais = "";
                        $where_union = "";
                        $where_mision = "";
                        $where_distrito_misionero = "";
                        array_push($array_tipos_acceso, array("iddivision" => $result[0]->iddivision));
                        
                        break;
                }
            }

            // print_r($array_tipos_acceso); exit;

            session(['where_division' => $where_division]);
            session(['where_pais' => $where_pais]);
            session(['where_union' => $where_union]);
            session(['where_mision' => $where_mision]);
            session(['where_distrito_misionero' => $where_distrito_misionero]);
            session(['array_tipos_acceso' => $array_tipos_acceso]);

            $idioma = DB::select("SELECT p.*, i.idioma_codigo FROM iglesias.paises AS p 
            INNER JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
            WHERE p.pais_id={$result[0]->pais_id}");
            // print_r($idioma); exit;
            session(['idioma_id' => $idioma[0]->idioma_id]);
            session(['idioma_codigo' => $idioma[0]->idioma_codigo]);

            $sql_idioma = "SELECT * FROM public.idiomas WHERE por_defecto='S'";
            $idioma_defecto = DB::select($sql_idioma);

            session(['idioma_defecto' => $idioma_defecto[0]->idioma_codigo]);
            session(['idioma_id_defecto' => $idioma_defecto[0]->idioma_id]);

        }

        echo json_encode($data);    
        // echo $clave; // Imprime: 
       
    }

    public function logout(Request $request) {
        $request->session()->flush();
        return redirect('/');
    }
}
