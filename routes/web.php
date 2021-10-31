<?php

use App\Http\Controllers\ActividadmisioneraController;
use App\Http\Controllers\ApiController;
use App\Http\Controllers\AsociadosController;
use App\Http\Controllers\CargosController;
use App\Http\Controllers\DepartamentosController;
use App\Http\Controllers\DistritosController;
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
use App\Http\Controllers\AsambleasController;
use App\Http\Controllers\IglesiasController;
use App\Http\Controllers\ImportarController;
use App\Http\Controllers\InstitucionesController;
use App\Http\Controllers\MisionesController;
use App\Http\Controllers\NivelesController;
use App\Http\Controllers\OtraspropiedadesController;
use App\Http\Controllers\PastoresController;
use App\Http\Controllers\PropuestasController;
use App\Http\Controllers\ProvinciasController;
use App\Http\Controllers\ReportesController;
use App\Http\Controllers\ResolucionesController;
use App\Http\Controllers\TiposcargoController;
use App\Http\Controllers\TrasladosController;
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
Route::post('principal/obtener_parentesco', [PrincipalController::class, "obtener_parentesco"]);

Route::post('principal/consultar_modulo', [PrincipalController::class, "consultar_modulo"]);
Route::post('principal/EliminarProceso', [PrincipalController::class, "EliminarProceso"]);


/*************
 * MODULO SEGURIDAD *
 *************/
// PERFILES
Route::get('perfiles/index', [PerfilesController::class, "index"]);
Route::post('perfiles/buscar_datos', [PerfilesController::class, "buscar_datos"]);
Route::post('perfiles/guardar_perfiles', [PerfilesController::class, "guardar_perfiles"]);
Route::post('perfiles/get_perfiles', [PerfilesController::class, "get_perfiles"]);
Route::post('perfiles/eliminar_perfiles', [PerfilesController::class, "eliminar_perfiles"]);
Route::post('perfiles/obtener_perfiles', [PerfilesController::class, "obtener_perfiles"]);
Route::post('perfiles/obtener_traducciones', [PerfilesController::class, "obtener_traducciones"]);

// MODULOS
Route::get('modulos/index', [ModulosController::class, "index"]);
Route::post('modulos/buscar_datos', [ModulosController::class, "buscar_datos"]);
Route::post('modulos/guardar_modulos', [ModulosController::class, "guardar_modulos"]);
Route::post('modulos/guardar_padres', [ModulosController::class, "guardar_padres"]);
Route::post('modulos/get_modulos', [ModulosController::class, "get_modulos"]);
Route::post('modulos/eliminar_modulos', [ModulosController::class, "eliminar_modulos"]);
Route::post('modulos/obtener_padres', [ModulosController::class, "obtener_padres"]);
Route::post('modulos/obtener_modulos', [ModulosController::class, "obtener_modulos"]);
Route::post('modulos/obtener_traducciones', [ModulosController::class, "obtener_traducciones"]);

//USUARIOS
Route::get('usuarios/index', [UsuariosController::class, "index"]);
Route::post('usuarios/buscar_datos', [UsuariosController::class, "buscar_datos"]);
Route::post('usuarios/guardar_usuarios', [UsuariosController::class, "guardar_usuarios"]);
Route::post('usuarios/get_usuarios', [UsuariosController::class, "get_usuarios"]);
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
Route::post('idiomas/get_idiomas', [IdiomasController::class, "get_idiomas"]);
Route::post('idiomas/eliminar_idiomas', [IdiomasController::class, "eliminar_idiomas"]);
Route::post('idiomas/obtener_idiomas', [IdiomasController::class, "obtener_idiomas"]);

// DIVISIONES
Route::get('divisiones/index', [DivisionesController::class, "index"]);
Route::post('divisiones/buscar_datos', [DivisionesController::class, "buscar_datos"]);
Route::post('divisiones/guardar_divisiones', [DivisionesController::class, "guardar_divisiones"]);
Route::post('divisiones/get_divisiones', [DivisionesController::class, "get_divisiones"]);
Route::post('divisiones/eliminar_divisiones', [DivisionesController::class, "eliminar_divisiones"]);
Route::post('divisiones/obtener_divisiones', [DivisionesController::class, "obtener_divisiones"]);
Route::post('divisiones/obtener_traducciones', [DivisionesController::class, "obtener_traducciones"]);
Route::post('divisiones/obtener_divisiones_todos', [DivisionesController::class, "obtener_divisiones_todos"]);
Route::post('divisiones/obtener_divisiones_all', [DivisionesController::class, "obtener_divisiones_all"]);

// PAISES
Route::get('paises/index', [PaisesController::class, "index"]);
Route::post('paises/buscar_datos', [PaisesController::class, "buscar_datos"]);
Route::post('paises/guardar_paises', [PaisesController::class, "guardar_paises"]);
Route::post('paises/get_paises', [PaisesController::class, "get_paises"]);
Route::post('paises/eliminar_paises', [PaisesController::class, "eliminar_paises"]);
Route::post('paises/obtener_paises', [PaisesController::class, "obtener_paises"]);
Route::post('paises/obtener_paises_propuestas', [PaisesController::class, "obtener_paises_propuestas"]);
Route::post('paises/obtener_paises_asociados', [PaisesController::class, "obtener_paises_asociados"]);
Route::post('paises/obtener_todos_paises', [PaisesController::class, "obtener_todos_paises"]);
Route::post('paises/obtener_paises_asociados_todos', [PaisesController::class, "obtener_paises_asociados_todos"]);
Route::post('paises/obtener_paises_asociados_all', [PaisesController::class, "obtener_paises_asociados_all"]);
Route::post('paises/obtener_jerarquia', [PaisesController::class, "obtener_jerarquia"]);

// UNIONES
Route::get('uniones/index', [UnionesController::class, "index"]);
Route::post('uniones/buscar_datos', [UnionesController::class, "buscar_datos"]);
Route::post('uniones/guardar_uniones', [UnionesController::class, "guardar_uniones"]);
Route::post('uniones/get_uniones', [UnionesController::class, "get_uniones"]);
Route::post('uniones/eliminar_uniones', [UnionesController::class, "eliminar_uniones"]);
Route::post('uniones/obtener_uniones', [UnionesController::class, "obtener_uniones"]);
Route::post('uniones/obtener_paises', [UnionesController::class, "obtener_paises"]);
Route::post('uniones/obtener_uniones_paises', [UnionesController::class, "obtener_uniones_paises"]);
Route::post('uniones/obtener_uniones_paises_all', [UnionesController::class, "obtener_uniones_paises_all"]);
Route::post('uniones/obtener_uniones_paises_todos', [UnionesController::class, "obtener_uniones_paises_todos"]);


// MISIONES
Route::get('misiones/index', [MisionesController::class, "index"]);
Route::post('misiones/buscar_datos', [MisionesController::class, "buscar_datos"]);
Route::post('misiones/guardar_misiones', [MisionesController::class, "guardar_misiones"]);
Route::post('misiones/get_misiones', [MisionesController::class, "get_misiones"]);
Route::post('misiones/eliminar_misiones', [MisionesController::class, "eliminar_misiones"]);
Route::post('misiones/obtener_misiones', [MisionesController::class, "obtener_misiones"]);
Route::post('misiones/obtener_misiones_all', [MisionesController::class, "obtener_misiones_all"]);
Route::post('misiones/obtener_misiones_todos', [MisionesController::class, "obtener_misiones_todos"]);


// DISTRITOS MISIONEROS
Route::get('distritos_misioneros/index', [DistritosmisionerosController::class, "index"]);
Route::post('distritos_misioneros/buscar_datos', [DistritosmisionerosController::class, "buscar_datos"]);
Route::post('distritos_misioneros/guardar_distritos_misioneros', [DistritosmisionerosController::class, "guardar_distritos_misioneros"]);
Route::post('distritos_misioneros/get_distritos_misioneros', [DistritosmisionerosController::class, "get_distritos_misioneros"]);
Route::post('distritos_misioneros/eliminar_distritos_misioneros', [DistritosmisionerosController::class, "eliminar_distritos_misioneros"]);
Route::post('distritos_misioneros/obtener_distritos_misioneros', [DistritosmisionerosController::class, "obtener_distritos_misioneros"]);
Route::post('distritos_misioneros/obtener_distritos_misioneros_todos', [DistritosmisionerosController::class, "obtener_distritos_misioneros_todos"]);
Route::post('distritos_misioneros/obtener_distritos_misioneros_all', [DistritosmisionerosController::class, "obtener_distritos_misioneros_all"]);

// IGLESIAS
Route::get('iglesias/index', [IglesiasController::class, "index"]);
Route::post('iglesias/buscar_datos', [IglesiasController::class, "buscar_datos"]);
Route::post('iglesias/guardar_iglesias', [IglesiasController::class, "guardar_iglesias"]);
Route::post('iglesias/get_iglesias', [IglesiasController::class, "get_iglesias"]);
Route::post('iglesias/eliminar_iglesias', [IglesiasController::class, "eliminar_iglesias"]);
Route::post('iglesias/obtener_iglesias', [IglesiasController::class, "obtener_iglesias"]);
Route::post('iglesias/obtener_iglesias_all', [IglesiasController::class, "obtener_iglesias_all"]);
Route::get('iglesias/ver_activos/{idiglesia}', [IglesiasController::class, "ver_activos"]);
Route::get('iglesias/ver_inactivos/{idiglesia}', [IglesiasController::class, "ver_inactivos"]);


// PASTORES
Route::get('pastores/index', [PastoresController::class, "index"]);
Route::post('pastores/buscar_datos', [PastoresController::class, "buscar_datos"]);
Route::post('pastores/guardar_pastores', [PastoresController::class, "guardar_pastores"]);
Route::post('pastores/get_pastores', [PastoresController::class, "get_pastores"]);
Route::post('pastores/eliminar_pastores', [PastoresController::class, "eliminar_pastores"]);
Route::post('pastores/obtener_pastores', [PastoresController::class, "obtener_pastores"]);
Route::post('pastores/obtener_cargos', [PastoresController::class, "obtener_cargos"]);

// DEPARTAMENTOS
Route::get('departamentos/index', [DepartamentosController::class, "index"]);
Route::post('departamentos/buscar_datos', [DepartamentosController::class, "buscar_datos"]);
Route::post('departamentos/guardar_departamentos', [DepartamentosController::class, "guardar_departamentos"]);
Route::post('departamentos/get_departamentos', [DepartamentosController::class, "get_departamentos"]);
Route::post('departamentos/eliminar_departamentos', [DepartamentosController::class, "eliminar_departamentos"]);
Route::post('departamentos/obtener_departamentos', [DepartamentosController::class, "obtener_departamentos"]);


// PROVINCIAS
Route::get('provincias/index', [ProvinciasController::class, "index"]);
Route::post('provincias/buscar_datos', [ProvinciasController::class, "buscar_datos"]);
Route::post('provincias/guardar_provincias', [ProvinciasController::class, "guardar_provincias"]);
Route::post('provincias/get_provincias', [ProvinciasController::class, "get_provincias"]);
Route::post('provincias/eliminar_provincias', [ProvinciasController::class, "eliminar_provincias"]);
Route::post('provincias/obtener_provincias', [ProvinciasController::class, "obtener_provincias"]);


// DISTRITOS
Route::get('distritos/index', [DistritosController::class, "index"]);
Route::post('distritos/buscar_datos', [DistritosController::class, "buscar_datos"]);
Route::post('distritos/guardar_distritos', [DistritosController::class, "guardar_distritos"]);
Route::post('distritos/get_distritos', [DistritosController::class, "get_distritos"]);
Route::post('distritos/eliminar_distritos', [DistritosController::class, "eliminar_distritos"]);
Route::post('distritos/obtener_distritos', [DistritosController::class, "obtener_distritos"]);



// TIPOS CARGO
Route::get('tipos_cargo/index', [TiposcargoController::class, "index"]);
Route::post('tipos_cargo/buscar_datos', [TiposcargoController::class, "buscar_datos"]);
Route::post('tipos_cargo/guardar_tipos_cargo', [TiposcargoController::class, "guardar_tipos_cargo"]);
Route::post('tipos_cargo/get_tipos_cargo', [TiposcargoController::class, "get_tipos_cargo"]);
Route::post('tipos_cargo/eliminar_tipos_cargo', [TiposcargoController::class, "eliminar_tipos_cargo"]);
Route::post('tipos_cargo/obtener_tipos_cargo', [TiposcargoController::class, "obtener_tipos_cargo"]);

// NIVELES
Route::get('niveles/index', [NivelesController::class, "index"]);
Route::post('niveles/buscar_datos', [NivelesController::class, "buscar_datos"]);
Route::post('niveles/guardar_niveles', [NivelesController::class, "guardar_niveles"]);
Route::post('niveles/get_niveles', [NivelesController::class, "get_niveles"]);
Route::post('niveles/eliminar_niveles', [NivelesController::class, "eliminar_niveles"]);
Route::post('niveles/obtener_niveles', [NivelesController::class, "obtener_niveles"]);

// CARGOS
Route::get('cargos/index', [CargosController::class, "index"]);
Route::post('cargos/buscar_datos', [CargosController::class, "buscar_datos"]);
Route::post('cargos/guardar_cargos', [CargosController::class, "guardar_cargos"]);
Route::post('cargos/get_cargos', [CargosController::class, "get_cargos"]);
Route::post('cargos/eliminar_cargos', [CargosController::class, "eliminar_cargos"]);
Route::post('cargos/obtener_cargos', [CargosController::class, "obtener_cargos"]);

// INSTITUCIONES
Route::get('instituciones/index', [InstitucionesController::class, "index"]);
Route::post('instituciones/buscar_datos', [InstitucionesController::class, "buscar_datos"]);
Route::post('instituciones/guardar_instituciones', [InstitucionesController::class, "guardar_instituciones"]);
Route::post('instituciones/get_instituciones', [InstitucionesController::class, "get_instituciones"]);
Route::post('instituciones/eliminar_instituciones', [InstitucionesController::class, "eliminar_instituciones"]);
Route::post('instituciones/obtener_instituciones', [InstitucionesController::class, "obtener_instituciones"]);



// OTRAS PROPIEDADES
Route::get('otras_propiedades/index', [OtraspropiedadesController::class, "index"]);
Route::post('otras_propiedades/buscar_datos', [OtraspropiedadesController::class, "buscar_datos"]);
Route::post('otras_propiedades/guardar_otras_propiedades', [OtraspropiedadesController::class, "guardar_otras_propiedades"]);
Route::post('otras_propiedades/get_otras_propiedades', [OtraspropiedadesController::class, "get_otras_propiedades"]);
Route::post('otras_propiedades/eliminar_otras_propiedades', [OtraspropiedadesController::class, "eliminar_otras_propiedades"]);
Route::post('otras_propiedades/obtener_otras_propiedades', [OtraspropiedadesController::class, "obtener_otras_propiedades"]);


/*************
 * MODULO GESTION DE IGLESIAS *
 *************/


// ASOCIADOS
Route::get('asociados/index', [AsociadosController::class, "index"]);
Route::get('asociados/asignacion_delegados', [AsociadosController::class, "asignacion_delegados"]);
Route::get('asociados/delegados', [AsociadosController::class, "delegados"]);
Route::post('asociados/buscar_datos', [AsociadosController::class, "buscar_datos"]);
Route::post('asociados/guardar_asociados', [AsociadosController::class, "guardar_asociados"]);
Route::post('asociados/get_asociados', [AsociadosController::class, "get_asociados"]);
Route::post('asociados/filtrar_asociados', [AsociadosController::class, "filtrar_asociados"]);
Route::post('asociados/obtener_estado_civil', [AsociadosController::class, "obtener_estado_civil"]);
Route::post('asociados/obtener_nivel_educativo', [AsociadosController::class, "obtener_nivel_educativo"]);
Route::post('asociados/obtener_profesiones', [AsociadosController::class, "obtener_profesiones"]);
Route::post('asociados/obtener_profesiones_todos', [AsociadosController::class, "obtener_profesiones_todos"]);
Route::post('asociados/buscar_datos_responsables', [AsociadosController::class, "buscar_datos_responsables"]);
Route::post('asociados/guardar_bajas', [AsociadosController::class, "guardar_bajas"]);
Route::post('asociados/guardar_altas', [AsociadosController::class, "guardar_altas"]);
Route::post('asociados/obtener_periodos_ini', [AsociadosController::class, "obtener_periodos_ini"]);
Route::post('asociados/obtener_periodos_fin', [AsociadosController::class, "obtener_periodos_fin"]);
Route::post('asociados/obtener_periodos_fin_dependiente', [AsociadosController::class, "obtener_periodos_fin_dependiente"]);
Route::post('asociados/obtener_cargos_miembro', [AsociadosController::class, "obtener_cargos_miembro"]);
Route::post('asociados/obtener_historial_altas_bajas', [AsociadosController::class, "obtener_historial_altas_bajas"]);
Route::post('asociados/obtener_traslados', [AsociadosController::class, "obtener_traslados"]);
Route::post('asociados/obtener_anios', [AsociadosController::class, "obtener_anios"]);
Route::post('asociados/obtener_capacitacion_miembro', [AsociadosController::class, "obtener_capacitacion_miembro"]);
Route::get('asociados/imprimir_ficha_asociado/{idmiembro}', [AsociadosController::class, "imprimir_ficha_asociado"]);
Route::get('asociados/imprimir_ficha_bautizo/{idmiembro}', [AsociadosController::class, "imprimir_ficha_bautizo"]);
Route::get('asociados/curriculum', [AsociadosController::class, "curriculum"]);
Route::post('asociados/obtener_parentesco_miembro', [AsociadosController::class, "obtener_parentesco_miembro"]);
Route::post('asociados/obtener_educacion_miembro', [AsociadosController::class, "obtener_educacion_miembro"]);
Route::post('asociados/obtener_laboral_miembro', [AsociadosController::class, "obtener_laboral_miembro"]);
Route::post('asociados/guardar_curriculum', [AsociadosController::class, "guardar_curriculum"]);
Route::post('asociados/guardar_delegados', [AsociadosController::class, "guardar_delegados"]);
Route::post('asociados/guardar_asignacion_delegados', [AsociadosController::class, "guardar_asignacion_delegados"]);
Route::get('asociados/imprimir_curriculum/{idmiembro}', [AsociadosController::class, "imprimir_curriculum"]);
Route::get('asociados/imprimir_listado_delegados', [AsociadosController::class, "imprimir_listado_delegados"]);
Route::post('asociados/notificar_delegados', [AsociadosController::class, "notificar_delegados"]);


// TRASLADOS
Route::get('traslados/index', [TrasladosController::class, "index"]);
Route::post('traslados/buscar_datos', [TrasladosController::class, "buscar_datos"]);
Route::post('traslados/buscar_datos_asociados_traslados', [TrasladosController::class, "buscar_datos_asociados_traslados"]);
// Route::post('traslados/guardar_traslados', [TrasladosController::class, "guardar_traslados"]);
Route::post('traslados/get_control', [TrasladosController::class, "get_control"]);
Route::post('traslados/eliminar_traslados', [TrasladosController::class, "eliminar_traslados"]);
Route::post('traslados/eliminar_traslados_temp', [TrasladosController::class, "eliminar_traslados_temp"]);
// Route::post('traslados/obtener_traslados', [TrasladosController::class, "obtener_traslados"]);
Route::post('traslados/guardar_traslados_temp', [TrasladosController::class, "guardar_traslados_temp"]);
Route::post('traslados/guardar_traslados_mi', [TrasladosController::class, "guardar_traslados_mi"]);
Route::post('traslados/trasladar', [TrasladosController::class, "trasladar"]);
Route::post('traslados/agregar_traslado', [TrasladosController::class, "agregar_traslado"]);

Route::get('traslados/control', [TrasladosController::class, "control"]);
Route::post('traslados/buscar_datos_control', [TrasladosController::class, "buscar_datos_control"]);
Route::post('traslados/guardar_control', [TrasladosController::class, "guardar_control"]);
Route::get('traslados/imprimir_carta_iglesia/{idmiembro}/{idcontrol}', [TrasladosController::class, "imprimir_carta_iglesia"]);
Route::get('traslados/imprimir_respuesta_carta_iglesia/{idmiembro}/{idcontrol}', [TrasladosController::class, "imprimir_respuesta_carta_iglesia"]);


// ACTIVIDAD MISIONERA

Route::get('actividad_misionera/index', [ActividadmisioneraController::class, "index"]);
Route::post('actividad_misionera/buscar_datos', [ActividadmisioneraController::class, "buscar_datos"]);
Route::post('actividad_misionera/obtener_anios', [ActividadmisioneraController::class, "obtener_anios"]);
Route::post('actividad_misionera/obtener_trimestres', [ActividadmisioneraController::class, "obtener_trimestres"]);
Route::post('actividad_misionera/obtener_actividades', [ActividadmisioneraController::class, "obtener_actividades"]);
Route::post('actividad_misionera/guardar_actividad', [ActividadmisioneraController::class, "guardar_actividad"]);
Route::get('actividad_misionera/reporte', [ActividadmisioneraController::class, "reporte"]);
Route::post('actividad_misionera/obtener_trimestres_todos  ', [ActividadmisioneraController::class, "obtener_trimestres_todos"]);
Route::get('actividad_misionera/imprimir_actividades_misioneras  ', [ActividadmisioneraController::class, "imprimir_actividades_misioneras"]);

// ELECCION
Route::get('eleccion/index', [AsambleasController::class, "index"]);
Route::post('eleccion/buscar_datos', [AsambleasController::class, "buscar_datos"]);
Route::post('eleccion/guardar_eleccion', [AsambleasController::class, "guardar_eleccion"]);
Route::post('eleccion/get_eleccion', [AsambleasController::class, "get_eleccion"]);
Route::post('eleccion/eliminar_eleccion', [AsambleasController::class, "eliminar_eleccion"]);
Route::post('eleccion/obtener_eleccion', [AsambleasController::class, "obtener_eleccion"]);

/*************
 * MODULO REPORTES*
 *************/


Route::get('reportes/general_asociados', [ReportesController::class, "general_asociados"]);
Route::get('reportes/grafico_feligresia', [ReportesController::class, "grafico_feligresia"]);
Route::get('reportes/imprimir_general_asociados', [ReportesController::class, "imprimir_general_asociados"]);
Route::get('reportes/imprimir_miembros_iglesia', [ReportesController::class, "imprimir_miembros_iglesia"]);
Route::get('reportes/miembros_iglesia', [ReportesController::class, "miembros_iglesia"]);
Route::get('reportes/oficiales_iglesia', [ReportesController::class, "oficiales_iglesia"]);
Route::get('reportes/oficiales_union_asociacion', [ReportesController::class, "oficiales_union_asociacion"]);
Route::get('reportes/informe_semestral', [ReportesController::class, "informe_semestral"]);
Route::get('reportes/imprimir_fichas_asociados', [ReportesController::class, "imprimir_fichas_asociados"]);
Route::get('reportes/imprimir_oficiales_iglesia', [ReportesController::class, "imprimir_oficiales_iglesia"]);
Route::get('reportes/imprimir_informe_semestral', [ReportesController::class, "imprimir_informe_semestral"]);
Route::get('reportes/imprimir_oficiales_union_asociacion', [ReportesController::class, "imprimir_oficiales_union_asociacion"]);
Route::get('reportes/exportar_excel_general_asociados', [ReportesController::class, "exportar_excel_general_asociados"]);
Route::post('reportes/obtener_iglesias', [ReportesController::class, "obtener_iglesias"]);
Route::post('reportes/obtener_feligresia', [ReportesController::class, "obtener_feligresia"]);


// IMPORTAR

Route::get('importar/importar', [ImportarController::class, "importar"]);
Route::get('importar/datos', [ImportarController::class, "datos"]);
Route::post('importar/guardar_importar', [ImportarController::class, "guardar_importar"]);
Route::post('importar/importar_datos', [ImportarController::class, "importar_datos"]);
Route::post('importar/procesos', [ImportarController::class, "procesos"]);



/*************
 * MODULO GESTION DE ASAMBLEAS *
 *************/

 // ASAMBLEAS DE CONVOCATORIA
Route::get('asambleas/index', [AsambleasController::class, "index"]);
Route::post('asambleas/buscar_datos', [AsambleasController::class, "buscar_datos"]);
Route::post('asambleas/obtener_anios', [AsambleasController::class, "obtener_anios"]);
Route::post('asambleas/obtener_tipo_convocatoria', [AsambleasController::class, "obtener_tipo_convocatoria"]);
Route::post('asambleas/obtener_asambleas', [AsambleasController::class, "obtener_asambleas"]);
Route::post('asambleas/obtener_detalle_agenda', [AsambleasController::class, "obtener_detalle_agenda"]);
Route::post('asambleas/guardar_asambleas', [AsambleasController::class, "guardar_asambleas"]);
Route::post('asambleas/get_asambleas', [AsambleasController::class, "get_asambleas"]);
Route::post('asambleas/eliminar_asambleas', [AsambleasController::class, "eliminar_asambleas"]);





// PROPUESTAS DE TEMAS Y ELECCIONES
Route::get('propuestas/temas', [PropuestasController::class, "temas"]);
Route::get('propuestas/elecciones', [PropuestasController::class, "elecciones"]);
Route::post('propuestas/buscar_datos', [PropuestasController::class, "buscar_datos"]);
Route::post('propuestas/buscar_datos_elecciones', [PropuestasController::class, "buscar_datos_elecciones"]);
Route::post('propuestas/guardar_propuestas_temas', [PropuestasController::class, "guardar_propuestas_temas"]);
Route::post('propuestas/guardar_propuestas_elecciones', [PropuestasController::class, "guardar_propuestas_elecciones"]);
Route::post('propuestas/get_propuestas_temas', [PropuestasController::class, "get_propuestas_temas"]);
Route::post('propuestas/get_propuestas_elecciones', [PropuestasController::class, "get_propuestas_elecciones"]);
Route::post('propuestas/eliminar_propuestas_temas', [PropuestasController::class, "eliminar_propuestas_temas"]);
Route::post('propuestas/eliminar_propuestas_elecciones', [PropuestasController::class, "eliminar_propuestas_elecciones"]);
Route::post('propuestas/obtener_propuestas', [PropuestasController::class, "obtener_propuestas"]);
Route::post('propuestas/obtener_correlativo', [PropuestasController::class, "obtener_correlativo"]);
Route::post('propuestas/obtener_detalle_propuesta', [PropuestasController::class, "obtener_detalle_propuesta"]);
Route::post('propuestas/obtener_formas_votacion', [PropuestasController::class, "obtener_formas_votacion"]);
Route::post('propuestas/obtener_categorias_propuestas', [PropuestasController::class, "obtener_categorias_propuestas"]);
Route::post('propuestas/get_votaciones', [PropuestasController::class, "get_votaciones"]);
Route::post('propuestas/guardar_votaciones', [PropuestasController::class, "guardar_votaciones"]);
Route::post('propuestas/obtener_propuestas_temas_origen', [PropuestasController::class, "obtener_propuestas_temas_origen"]);
Route::post('propuestas/obtener_propuestas_origen', [PropuestasController::class, "obtener_propuestas_origen"]);
Route::post('propuestas/obtener_descripciones_propuestas_origen', [PropuestasController::class, "obtener_descripciones_propuestas_origen"]);

Route::get('propuestas/imprimir_propuesta_tema/{pt_id}', [PropuestasController::class, "imprimir_propuesta_tema"]);


 // RESOLUCIONES
 Route::get('resoluciones/index', [ResolucionesController::class, "index"]);
 Route::post('resoluciones/buscar_datos', [ResolucionesController::class, "buscar_datos"]);

 Route::post('resoluciones/obtener_resoluciones', [ResolucionesController::class, "obtener_resoluciones"]);

 Route::post('resoluciones/guardar_resoluciones', [ResolucionesController::class, "guardar_resoluciones"]);
 Route::post('resoluciones/get_resoluciones', [ResolucionesController::class, "get_resoluciones"]);
 Route::post('resoluciones/eliminar_resoluciones', [ResolucionesController::class, "eliminar_resoluciones"]);


 

 // API APP

 Route::get('api/login', [ApiController::class, "login"]);
