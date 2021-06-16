<?php

use App\Http\Controllers\IdiomasController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\ModulosController;
use App\Http\Controllers\PaisesController;
use App\Http\Controllers\PerfilesController;
use App\Http\Controllers\PermisosController;
use App\Http\Controllers\PrincipalController;
use App\Http\Controllers\UsuariosController;
use Illuminate\Support\Facades\Route;



/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    // return "hola";
    return view('login');
});

// LOGIN
Route::post('login/loguearse', [LoginController::class, "loguearse"]);
Route::get('login/logout', [LoginController::class, "logout"]);

//PRINCIPAL
Route::get('principal/index', [PrincipalController::class, "index"]);

/*************
 * MODULO SEGURIDAD *
 *************/
// PERFILES
Route::get('perfiles/index', [PerfilesController::class, "index"]);
Route::post('perfiles/buscar_datos', [PerfilesController::class, "buscar_datos"]);
Route::post('perfiles/guardar_perfiles', [PerfilesController::class, "guardar_perfiles"]);
Route::post('perfiles/get', [PerfilesController::class, "get"]);
Route::post('perfiles/eliminar_perfiles', [PerfilesController::class, "eliminar_perfiles"]);
Route::post('perfiles/obtener_perfiles', [PerfilesController::class, "obtener_perfiles"]);


// MODULOS
Route::get('modulos/index', [ModulosController::class, "index"]);
Route::post('modulos/buscar_datos', [ModulosController::class, "buscar_datos"]);
Route::post('modulos/guardar_modulos', [ModulosController::class, "guardar_modulos"]);
Route::post('modulos/guardar_padres', [ModulosController::class, "guardar_padres"]);
Route::post('modulos/get', [ModulosController::class, "get"]);
Route::post('modulos/eliminar_modulos', [ModulosController::class, "eliminar_modulos"]);
Route::post('modulos/obtener_padres', [ModulosController::class, "obtener_padres"]);
Route::post('modulos/obtener_modulos', [ModulosController::class, "obtener_modulos"]);
Route::post('modulos/obtener_traducciones', [ModulosController::class, "obtener_traducciones"]);

//USUARIOS
Route::get('usuarios/index', [UsuariosController::class, "index"]);
Route::post('usuarios/buscar_datos', [UsuariosController::class, "buscar_datos"]);
Route::post('usuarios/guardar_usuarios', [UsuariosController::class, "guardar_usuarios"]);
Route::post('usuarios/get', [UsuariosController::class, "get"]);
Route::post('usuarios/eliminar_usuarios', [UsuariosController::class, "eliminar_usuarios"]);


// PERMISOS

Route::get('permisos/index', [PermisosController::class, "index"]);
Route::post('permisos/guardar_permisos', [PermisosController::class, "guardar_permisos"]);
Route::post('permisos/get', [PermisosController::class, "get"]);


/*************
 * MODULO MANTENIMIENTOS *
 *************/

// PAISES
Route::get('paises/index', [PaisesController::class, "index"]);
Route::post('paises/buscar_datos', [PaisesController::class, "buscar_datos"]);
Route::post('paises/guardar_paises', [PaisesController::class, "guardar_paises"]);
Route::post('paises/get', [PaisesController::class, "get"]);
Route::post('paises/eliminar_paises', [PaisesController::class, "eliminar_paises"]);
Route::post('paises/obtener_paises', [PaisesController::class, "obtener_paises"]);


// IDIOMAS
Route::get('idiomas/index', [IdiomasController::class, "index"]);
Route::post('idiomas/buscar_datos', [IdiomasController::class, "buscar_datos"]);
Route::post('idiomas/guardar_idiomas', [IdiomasController::class, "guardar_idiomas"]);
Route::post('idiomas/get', [IdiomasController::class, "get"]);
Route::post('idiomas/eliminar_idiomas', [IdiomasController::class, "eliminar_idiomas"]);
Route::post('idiomas/obtener_idiomas', [IdiomasController::class, "obtener_idiomas"]);

