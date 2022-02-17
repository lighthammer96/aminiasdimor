<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller
{
    //
    public function loguearse(Request $request) {
        $nivel_organizativo = "";
        $data = array();
        $data["response"] = "nopass";
        $user = strtolower($request->input('user'));
        $pass = $request->input('pass');
        // $clave = Hash::make('1235');
        // echo $clave; exit;
        // echo Hash::check("1235", $clave);
        $sql_login = "SELECT u.*, p.*, m.*, ta.descripcion AS tipo_acceso FROM seguridad.usuarios AS u 
        INNER JOIN seguridad.perfiles AS p ON(u.perfil_id=p.perfil_id)
        LEFT JOIN iglesias.miembro AS m ON(u.idmiembro=m.idmiembro)
        LEFT JOIN seguridad.tipoacceso AS ta ON(ta.idtipoacceso=u.idtipoacceso)
        
        WHERE lower(u.usuario_user)='{$user}'";
        // die($sql_login);
        $result = DB::select($sql_login);
       
        if(!isset($result[0]->usuario_user) || !isset($result[0]->idmiembro) || !isset($result[0]->perfil_id)) {
            $data["response"] = "nouser";
        }

        if($result[0]->idmiembro == NULL && $result[0]->perfil_id != 1 && $result[0]->perfil_id != 2) {
            $data["response"] = "nouser";
        }
        
        // print_r($result); exit;
        if(isset($result[0]->usuario_pass) && Hash::check($pass, $result[0]->usuario_pass)) {
            $data["response"] = "ok";
            //$request->session()->put('usuario_id', $result[0]->usuario_id);
            $usuario_id = (isset($result[0]->usuario_id)) ? $result[0]->usuario_id : '';
            $idmiembro = (isset($result[0]->idmiembro)) ? $result[0]->idmiembro : '';
            $usuario_user = (isset($result[0]->usuario_user)) ? $result[0]->usuario_user : '';
            $perfil_id = (isset($result[0]->perfil_id)) ? $result[0]->perfil_id : '';
            $pais_id = (isset($result[0]->pais_id) && !empty($result[0]->pais_id)) ? $result[0]->pais_id : 1;
            $idtipoacceso = (isset($result[0]->idtipoacceso)) ? $result[0]->idtipoacceso : '';
            $foto = (isset($result[0]->foto)) ? $result[0]->foto : '';
            $responsable = (isset($result[0]) && (!empty($result[0]->apellidos) || !empty($result[0]->nombres))) ? $result[0]->apellidos.", ".$result[0]->nombres : $usuario_user;
            $tipo_acceso = (isset($result[0]->tipo_acceso)) ? $result[0]->tipo_acceso : '';
            $iddivision = (isset($result[0]->iddivision)) ? $result[0]->iddivision : '';
          
            $idunion = (isset($result[0]->idunion)) ? $result[0]->idunion : '';
            $idmision = (isset($result[0]->idmision)) ? $result[0]->idmision : '';
            $iddistritomisionero = (isset($result[0]->iddistritomisionero)) ? $result[0]->iddistritomisionero : '';
            $idiglesia = (isset($result[0]->idiglesia)) ? $result[0]->idiglesia : '';

            // var_dump($pais_id); exit;
           
            session(['usuario_id' => $usuario_id]);
            session(['idmiembro' => $idmiembro]);
            session(['usuario_user' => $usuario_user]);
            session(['perfil_id' => $perfil_id]);
            session(['pais_id' => $pais_id]);
           
            session(['idtipoacceso' => $idtipoacceso]);

            if(empty($foto)) {
                if($result[0]->sexo == "M") {
                    $foto = "hombre.png";
                } else {
                    $foto = "mujer.png";
                }
            }

            session(['foto' => $foto]);
            session(['responsable' => $responsable]);
            session(['tipo_acceso' => $tipo_acceso]);
            session(['iddivision' => $iddivision]);
            session(['pais_id' => $pais_id]);
            session(['idunion' => $idunion]);
            session(['idmision' => $idmision]);
            session(['iddistritomisionero' => $iddistritomisionero]);
            session(['idiglesia' => $idiglesia]);
            
            $where_division = "";
            $where_pais = "";
            $where_union = "";
            $where_mision = "";
            $where_distrito_misionero = "";

            $where_division_padre = "";
            $where_pais_padre = "";
            $where_union_padre = "";
            $where_mision_padre = "";
            $where_distrito_misionero_padre = "";
            $array_tipos_acceso = array();
            if($perfil_id != 1 && $perfil_id != 2) {
                switch ($idtipoacceso) {
                    case '1':
                        $where_division = " AND d.iddivision = ".$iddivision;
                        $where_pais = " AND pais_id = ".$pais_id;
                        $where_union = " AND u.idunion = ".$idunion;
                        $where_mision = " AND idmision = ".$idmision;
                        $where_distrito_misionero = " AND iddistritomisionero = ".$iddistritomisionero;

                        $where_division_padre = " AND iddivision = ".$iddivision;
                        $where_pais_padre = " AND u.pais_id = ".$pais_id;
                        $where_union_padre = " AND idunion = ".$idunion;
                        $where_mision_padre = " AND idmision = ".$idmision;
                        $where_distrito_misionero_padre = " AND iddistritomisionero = ".$iddistritomisionero;

                        array_push($array_tipos_acceso, array("iddivision" => $iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $pais_id));
                        array_push($array_tipos_acceso, array("idunion" => $idunion));
                        array_push($array_tipos_acceso, array("idmision" => $idmision));
                        array_push($array_tipos_acceso, array("iddistritomisionero" => $iddistritomisionero));

                        $sql = "SELECT * FROM iglesias.distritomisionero WHERE iddistritomisionero=".$iddistritomisionero;
                        $nivel = DB::select($sql);
                        $nivel_organizativo = $nivel[0]->descripcion;
                        break;
                    case '2':
                        $where_division = " AND d.iddivision = ".$iddivision;
                        $where_pais = " AND pais_id = ".$pais_id;
                        $where_union = " AND u.idunion = ".$idunion;
                        $where_mision = " AND idmision = ".$idmision;
                        $where_distrito_misionero = "";

                        $where_division_padre = " AND iddivision = ".$iddivision;
                        $where_pais_padre = " AND u.pais_id = ".$pais_id;
                        $where_union_padre = " AND idunion = ".$idunion;
                        $where_mision_padre = " AND idmision = ".$idmision;
                        $where_distrito_misionero_padre = "";

                        array_push($array_tipos_acceso, array("iddivision" => $iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $pais_id));
                        array_push($array_tipos_acceso, array("idunion" => $idunion));
                        array_push($array_tipos_acceso, array("idmision" => $idmision));
                        
                        $sql = "SELECT * FROM iglesias.mision WHERE idmision=".$idmision;
                        $nivel = DB::select($sql);
                        $nivel_organizativo = $nivel[0]->descripcion;
                        break;
                    case '3':
                        $where_division = " AND d.iddivision = ".$iddivision;
                        $where_pais = " AND pais_id = ".$pais_id;
                        $where_union = " AND u.idunion = ".$idunion;
                        $where_mision = "";
                        $where_distrito_misionero = "";

                        $where_division_padre = " AND iddivision = ".$iddivision;
                        $where_pais_padre = " AND u.pais_id = ".$pais_id;
                        $where_union_padre = " AND idunion = ".$idunion;
                        $where_mision_padre = "";
                        $where_distrito_misionero_padre = "";

                        array_push($array_tipos_acceso, array("iddivision" => $iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $pais_id));
                        array_push($array_tipos_acceso, array("idunion" => $idunion));
                        
                        $sql = "SELECT * FROM iglesias.union WHERE idunion=".$idunion;
                        $nivel = DB::select($sql);
                        $nivel_organizativo = $nivel[0]->descripcion;

                        break;
                    case '4':
                        $where_division = " AND d.iddivision = ".$iddivision;
                        $where_pais = " AND pais_id = ".$pais_id;
                        $where_union = "";
                        $where_mision = "";
                        $where_distrito_misionero = "";


                        $where_division_padre = " AND iddivision = ".$iddivision;
                        $where_pais_padre = " AND u.pais_id = ".$pais_id;
                        $where_union_padre = "";
                        $where_mision_padre = "";
                        $where_distrito_misionero_padre = "";

                        array_push($array_tipos_acceso, array("iddivision" => $iddivision));
                        array_push($array_tipos_acceso, array("pais_id" => $pais_id));
                        
                        $sql = "SELECT * FROM iglesias.paises WHERE pais_id=".$pais_id;
                        $nivel = DB::select($sql);
                        $nivel_organizativo = $nivel[0]->pais_descripcion;
                        break;
                    case '5':
                        $where_division = " AND d.iddivision = ".$iddivision;
                        $where_pais = "";
                        $where_union = "";
                        $where_mision = "";
                        $where_distrito_misionero = "";


                        $where_division_padre = " AND iddivision = ".$iddivision;
                        $where_pais_padre = "";
                        $where_union_padre = "";
                        $where_mision_padre = "";
                        $where_distrito_misionero_padre = "";
                        array_push($array_tipos_acceso, array("iddivision" => $iddivision));
                        $sql = "SELECT * FROM iglesias.division WHERE iddivision=".$iddivision;
                        $nivel = DB::select($sql);
                        $nivel_organizativo = $nivel[0]->descripcion;
                        break;
                }
            }

            // print_r($array_tipos_acceso); exit;

            session(['where_division' => $where_division]);
            session(['where_pais' => $where_pais]);
            session(['where_union' => $where_union]);
            session(['where_mision' => $where_mision]);
            session(['where_distrito_misionero' => $where_distrito_misionero]);

            session(['where_division_padre' => $where_division_padre]);
            session(['where_pais_padre' => $where_pais_padre]);
            session(['where_union_padre' => $where_union_padre]);
            session(['where_mision_padre' => $where_mision_padre]);
            session(['where_distrito_misionero_padre' => $where_distrito_misionero_padre]);

            session(['array_tipos_acceso' => $array_tipos_acceso]);

            $idioma = DB::select("SELECT p.*, i.idioma_codigo FROM iglesias.paises AS p 
            INNER JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
            WHERE p.pais_id={$pais_id}");
            // print_r($idioma); exit;
            session(['idioma_id' => $idioma[0]->idioma_id]);
            session(['idioma_codigo' => $idioma[0]->idioma_codigo]);

            $sql_idioma = "SELECT * FROM public.idiomas WHERE por_defecto='S'";
            $idioma_defecto = DB::select($sql_idioma);
            
            session(['idioma_defecto' => $idioma_defecto[0]->idioma_codigo]);
            session(['idioma_id_defecto' => $idioma_defecto[0]->idioma_id]);

            $sql_perfil = "SELECT * FROM seguridad.perfiles_idiomas WHERE perfil_id={$perfil_id} AND (idioma_id={$idioma[0]->idioma_id} OR idioma_id={$idioma_defecto[0]->idioma_id})";
            //die($sql_perfil);
            $perfil = DB::select($sql_perfil);
            
            session(['perfil_descripcion' => (isset($perfil[0]->pi_descripcion)) ? $perfil[0]->pi_descripcion : "" ]);
            session(['nivel_organizativo' => $nivel_organizativo]);
        }

        echo json_encode($data);    
        // echo $clave; // Imprime: 
       
    }

    public function logout(Request $request) {
        $request->session()->flush();
        return redirect('/');
    }
}
