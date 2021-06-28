<?php

use App\Http\Controllers\AsociadosController;
use App\Http\Controllers\DistritosmisionerosController;
use App\Http\Controllers\IdiomasController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\ModulosController;
use App\Http\Controllers\PaisesController;
use App\Http\Controllers\PerfilesController;
use App\Http\Controllers\PermisosController;
use App\Http\Controllers\PrincipalController;
use App\Http\Controllers\UsuariosController;
use App\Http\Controllers\DivisionesController;
use App\Http\Controllers\IglesiasController;
use App\Http\Controllers\MisionesController;
use App\Http\Controllers\UnionesController;
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
Route::post('principal/obtener_departamentos', [PrincipalController::class, "obtener_departamentos"]);
Route::post('principal/obtener_provincias', [PrincipalController::class, "obtener_provincias"]);
Route::post('principal/obtener_distritos', [PrincipalController::class, "obtener_distritos"]);
Route::post('principal/obtener_divisiones', [PrincipalController::class, "obtener_divisiones"]);
Route::post('principal/obtener_tipos_documento', [PrincipalController::class, "obtener_tipos_documento"]);
Route::post('principal/obtener_tipos_acceso', [PrincipalController::class, "obtener_tipos_acceso"]);
Route::post('principal/obtener_categorias_iglesia', [PrincipalController::class, "obtener_categorias_iglesia"]);
Route::post('principal/obtener_tipos_construccion', [PrincipalController::class, "obtener_tipos_construccion"]);
Route::post('principal/obtener_tipos_documentacion', [PrincipalController::class, "obtener_tipos_documentacion"]);
Route::post('principal/obtener_tipos_inmueble', [PrincipalController::class, "obtener_tipos_inmueble"]);
Route::post('principal/obtener_condicion_inmueble', [PrincipalController::class, "obtener_condicion_inmueble"]);
Route::post('principal/cambiar_idioma', [PrincipalController::class, "cambiar_idioma"]);
Route::post('principal/obtener_motivos_baja', [PrincipalController::class, "obtener_motivos_baja"]);
Route::post('principal/obtener_condicion_eclesiastica', [PrincipalController::class, "obtener_condicion_eclesiastica"]);
Route::post('principal/obtener_religiones', [PrincipalController::class, "obtener_religiones"]);
Route::post('principal/obtener_tipos_cargo', [PrincipalController::class, "obtener_tipos_cargo"]);
Route::post('principal/obtener_cargos', [PrincipalController::class, "obtener_cargos"]);
Route::post('principal/obtener_instituciones', [PrincipalController::class, "obtener_instituciones"]);


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
Route::post('perfiles/obtener_traducciones', [PerfilesController::class, "obtener_traducciones"]);

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
// IDIOMAS
Route::get('idiomas/index', [IdiomasController::class, "index"]);
Route::post('idiomas/buscar_datos', [IdiomasController::class, "buscar_datos"]);
Route::post('idiomas/guardar_idiomas', [IdiomasController::class, "guardar_idiomas"]);
Route::post('idiomas/get', [IdiomasController::class, "get"]);
Route::post('idiomas/eliminar_idiomas', [IdiomasController::class, "eliminar_idiomas"]);
Route::post('idiomas/obtener_idiomas', [IdiomasController::class, "obtener_idiomas"]);

// DIVISIONES
Route::get('divisiones/index', [DivisionesController::class, "index"]);
Route::post('divisiones/buscar_datos', [DivisionesController::class, "buscar_datos"]);
Route::post('divisiones/guardar_divisiones', [DivisionesController::class, "guardar_divisiones"]);
Route::post('divisiones/get', [DivisionesController::class, "get"]);
Route::post('divisiones/eliminar_divisiones', [DivisionesController::class, "eliminar_divisiones"]);
Route::post('divisiones/obtener_divisiones', [DivisionesController::class, "obtener_divisiones"]);
Route::post('divisiones/obtener_traducciones', [DivisionesController::class, "obtener_traducciones"]);

// PAISES
Route::get('paises/index', [PaisesController::class, "index"]);
Route::post('paises/buscar_datos', [PaisesController::class, "buscar_datos"]);
Route::post('paises/guardar_paises', [PaisesController::class, "guardar_paises"]);
Route::post('paises/get', [PaisesController::class, "get"]);
Route::post('paises/eliminar_paises', [PaisesController::class, "eliminar_paises"]);
Route::post('paises/obtener_paises', [PaisesController::class, "obtener_paises"]);
Route::post('paises/obtener_paises_asociados', [PaisesController::class, "obtener_paises_asociados"]);
Route::post('paises/obtener_todos_paises', [PaisesController::class, "obtener_todos_paises"]);

// UNIONES
Route::get('uniones/index', [UnionesController::class, "index"]);
Route::post('uniones/buscar_datos', [UnionesController::class, "buscar_datos"]);
Route::post('uniones/guardar_uniones', [UnionesController::class, "guardar_uniones"]);
Route::post('uniones/get', [UnionesController::class, "get"]);
Route::post('uniones/eliminar_uniones', [UnionesController::class, "eliminar_uniones"]);
Route::post('uniones/obtener_uniones', [UnionesController::class, "obtener_uniones"]);
Route::post('uniones/obtener_paises', [UnionesController::class, "obtener_paises"]);
Route::post('uniones/obtener_uniones_paises', [UnionesController::class, "obtener_uniones_paises"]);


// MISIONES
Route::get('misiones/index', [MisionesController::class, "index"]);
Route::post('misiones/buscar_datos', [MisionesController::class, "buscar_datos"]);
Route::post('misiones/guardar_misiones', [MisionesController::class, "guardar_misiones"]);
Route::post('misiones/get', [MisionesController::class, "get"]);
Route::post('misiones/eliminar_misiones', [MisionesController::class, "eliminar_misiones"]);
Route::post('misiones/obtener_misiones', [MisionesController::class, "obtener_misiones"]);


// DISTRITOS MISIONEROS
Route::get('distritos_misioneros/index', [DistritosmisionerosController::class, "index"]);
Route::post('distritos_misioneros/buscar_datos', [DistritosmisionerosController::class, "buscar_datos"]);
Route::post('distritos_misioneros/guardar_distritos_misioneros', [DistritosmisionerosController::class, "guardar_distritos_misioneros"]);
Route::post('distritos_misioneros/get', [DistritosmisionerosController::class, "get"]);
Route::post('distritos_misioneros/eliminar_distritos_misioneros', [DistritosmisionerosController::class, "eliminar_distritos_misioneros"]);
Route::post('distritos_misioneros/obtener_distritos_misioneros', [DistritosmisionerosController::class, "obtener_distritos_misioneros"]);

// IGLESIAS
Route::get('iglesias/index', [IglesiasController::class, "index"]);
Route::post('iglesias/buscar_datos', [IglesiasController::class, "buscar_datos"]);
Route::post('iglesias/guardar_iglesias', [IglesiasController::class, "guardar_iglesias"]);
Route::post('iglesias/get', [IglesiasController::class, "get"]);
Route::post('iglesias/eliminar_iglesias', [IglesiasController::class, "eliminar_iglesias"]);
Route::post('iglesias/obtener_iglesias', [IglesiasController::class, "obtener_iglesias"]);


/*************
 * MODULO GESTION DE IGLESIAS *
 *************/


// ASOCIADOS
Route::get('asociados/index', [AsociadosController::class, "index"]);
Route::post('asociados/buscar_datos', [AsociadosController::class, "buscar_datos"]);
Route::post('asociados/guardar_asociados', [AsociadosController::class, "guardar_asociados"]);
Route::post('asociados/get', [AsociadosController::class, "get"]);
Route::post('asociados/obtener_estado_civil', [AsociadosController::class, "obtener_estado_civil"]);
Route::post('asociados/obtener_nivel_educativo', [AsociadosController::class, "obtener_nivel_educativo"]);
Route::post('asociados/obtener_profesiones', [AsociadosController::class, "obtener_profesiones"]);
Route::post('asociados/buscar_datos_responsables', [AsociadosController::class, "buscar_datos_responsables"]);
Route::post('asociados/guardar_bajas', [AsociadosController::class, "guardar_bajas"]);
Route::post('asociados/guardar_altas', [AsociadosController::class, "guardar_altas"]);
Route::post('asociados/obtener_periodos_ini', [AsociadosController::class, "obtener_periodos_ini"]);
Route::post('asociados/obtener_periodos_fin', [AsociadosController::class, "obtener_periodos_fin"]);
Route::post('asociados/obtener_cargos', [AsociadosController::class, "obtener_cargos"]);
Route::post('asociados/obtener_historial_altas_bajas', [AsociadosController::class, "obtener_historial_altas_bajas"]);
