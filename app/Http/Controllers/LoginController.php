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
        $user = $request->input('user');
        $pass = $request->input('pass');
        // $clave = Hash::make('1235');
        // echo $clave; exit;
        // echo Hash::check("1235", $clave);

        $result = DB::select("SELECT * FROM seguridad.usuarios AS u 
        INNER JOIN seguridad.perfiles AS p ON(u.perfil_id=p.perfil_id)
        WHERE u.usuario_user='{$user}'");
       
        if(!isset($result[0]->usuario_user)) {
            $data["response"] = "nouser";
        }
        if(isset($result[0]->usuario_pass) && Hash::check($pass, $result[0]->usuario_pass)) {
            $data["response"] = "ok";
            //$request->session()->put('usuario_id', $result[0]->usuario_id);
            session(['usuario_id' => $result[0]->usuario_id]);
            session(['usuario_user' => $result[0]->usuario_user]);
            session(['perfil_id' => $result[0]->perfil_id]);
            session(['pais_id' => $request->input("pais_id")]);
            session(['perfil_descripcion' => $result[0]->perfil_descripcion]);

            $idioma = DB::select("SELECT p.*, i.idioma_codigo FROM public.paises AS p 
            INNER JOIN public.idiomas AS i ON(p.idioma_id=i.idioma_id)
            WHERE p.pais_id={$request->input("pais_id")}");
            // print_r($idioma); exit;
            session(['idioma_id' => $idioma[0]->idioma_id]);
            session(['idioma_codigo' => $idioma[0]->idioma_codigo]);
        }

        echo json_encode($data);    
        // echo $clave; // Imprime: 
       
    }

    public function logout(Request $request) {
        $request->session()->flush();
        return redirect('/');
    }
}
