<?php

namespace App\Models;

use Exception;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class BaseModel extends Model
{
    use HasFactory;

    public function __construct() {
        $this->camposLogInsertar = ['fecha_registro', 'usuario_registro', 'pc_registro'];
        $this->camposLogModificar = ['fecha_ultima_modificacion', 'usuario_ultima_modificacion', 'pc_ultima_modificacion'];
        $this->camposLogAnular = ['fecha_ultima_anulacion', 'usuario_ultima_anulacion', 'pc_ultima_anulacion'];
        $this->camposLogActivar = ['fecha_ultima_activacion', 'usuario_ultima_activacion', 'pc_ultima_activacion'];
    }

    /**
    * [insertar description]
    * @param  [string]  $tabla  [nombre de la tabla a insertar]
    * @param  [array]  $data   [los datos con campos de la tabla y su valor respectivo ]
    * @param  [type]  $tipo_tabla  [N -> si un tabla normal, D -> si un detalle]
    * @param  boolean $status [si la tabla tiene un pk es false, si no es un detalle es true ]
    * @param  boolean $omitir [omite el salto del primero elemento ]
    * @return [type]          [description]
    */
    public function insertar($parametros, $tipoTabla = 'N') {
        //print_r($parametros);
        try {
      
            if(!isset($parametros["datos"])) {
                throw new Exception('No Existe variable datos, por ello no se puede insertar algo que no existe!');
            }

            foreach ($parametros["datos"] as $key => $value) {
                if($this->validarLogCampos($parametros["tabla"], "I")) {
                    $value["fecha_registro"] = date("Y-m-d H:i:s");
                    $value["usuario_registro"] = session("usuario_user");
                    // $value["pc_registro"] = $this->session->caja_pcname;

                }
                //$fields = $this->db->list_fields($tabla);
                // $this->db->insert($parametros["tabla"], $value);
              
                DB::table($parametros["tabla"])->insert($value);
               
            }

            // $db_error = $this->db->error();
            // if ($db_error["code"] != 0) {
            //     throw new Exception('Database error! Error Code [' . $db_error['code'] . '] Error: ' . $db_error['message']);
            //     return false; // unreachable retrun statement !!!
            // }

            if($tipoTabla == 'N') {
                $lastid = DB::getPdo()->lastInsertId();
            }
            // else {
            //     throw new Exception("NO TIENE UNA LLAVE DE TIPO AUTO INCREMENTAL");

            // }



            if ($tipoTabla == 'N') {
                $parametros["status"] = "i";
                $parametros["id"] = $lastid;
                $parametros["type"] = "success";
                $parametros["msg"] = "SE GUARDÓ CORRECTAMENTE";
                return $parametros;
                // return array("status" => "i", "id" => $lastid);

            }



        } catch (\Illuminate\Database\QueryException $e) {
            $parametros["status"] = "ei";
            $parametros["msg"] = $e->getMessage();
            $parametros["type"] = "error";
            return $parametros;

        }

    }

    public function modificar($parametros) {
        #print_r($data["data"]); exit;

        try {
            foreach ($parametros["datos"] as $key => $value) {
                $id = array_keys($value)[0];
                $valorid = array_values($value)[0];

            }

            if($this->validarLogCampos($parametros["tabla"], "M")) {
                $parametros["datos"][0]["fecha_ultima_modificacion"] = date("Y-m-d H:i:s");
                $parametros["datos"][0]["usuario_ultima_modificacion"] = session("usuario_user");
                // $parametros["datos"][0]["pc_ultima_modificacion"] = $this->session->caja_pcname;
            }


            // $this->db->where($id, $valorid);
            // $estado = $this->db->update($parametros["tabla"], $parametros["datos"][0]);
            $estado = DB::table($parametros["tabla"])
              ->where($id, $valorid)
              ->update($parametros["datos"][0]);
            // $db_error = $this->db->error();
            // if ($db_error["code"] != 0) {
            //     throw new Exception('Database error! Error Code [' . $db_error['code'] . '] Error: ' . $db_error['message']);
            //     return false; // unreachable retrun statement !!!
            // }

            if ($estado) {
                $parametros["status"] = "m";
                $parametros["id"] = $valorid;
                $parametros["msg"] = "SE MODIFICÓ CORRECTAMENTE";
                $parametros["type"] = "success";
                return $parametros;
                // return array(
                // 	"status" => "m",
                // 	"id" => $valorid,
                // 	"msg" => "SE MODIFICÓ CORRECTAMENTE",
                // 	"type" => "success"
                // );
            } else {
                $parametros["status"] = "em";
                $parametros["id"] = $valorid;
                $parametros["msg"] = "ERROR AL MODIFICAR";
                $parametros["type"] = "error";
                return $parametros;
                // return array(
                // 	"status" => "em",
                // 	"id" => $valorid,
                // 	"msg" => "ERROR AL MODIFICAR",
                // 	"type" => "error"

                // );
            }
        } catch (\Illuminate\Database\QueryException $e) {
            $parametros["status"] = "em";
            $parametros["id"] = $valorid;
            $parametros["msg"] = $e->getMessage();
            $parametros["type"] = "error";
            return $parametros;
            // return array(
            // 	"status" => "em",
            // 	"id" => $valorid,
            // 	"msg" => $e->getMessage(),
            // 	"type" => "error"
            // );
        }

    }


    public function eliminar($array) {

        try {

            // $this->db->where($array[1], $_REQUEST["id"]);
            // $estado = $this->db->delete($array[0]);
            $estado = DB::table($array[0])->where($array[1], $_REQUEST["id"])->delete();
            // $db_error = $this->db->error();
            // // print_r($db_error); exit;

            // // $db_error = $this->db->error();
            // if ($db_error["code"] != 0) {
            //     throw new Exception('Database error! Error Code [' . $db_error['code'] . '] Error: ' . $db_error['message']);
            //     return false; // unreachable retrun statement !!!
            // }
            // var_dump($estado);
            if ($estado) {
                return array(
                    "status" => "e",
                    "id" => $_REQUEST["id"],
                    "type" => "success",
                    "msg" => "SE ELIMINÓ CORRECTAMENTE"
                );
            } else {
                return array(
                    "status" => "ee",
                    "id" => $_REQUEST["id"],
                    "type" => "error",
                    "msg" => 'ERROR AL ELIMINAR'
                );
            }
            // $this->db->trans_commit();
        } catch (\Illuminate\Database\QueryException $e) {
            // $this->db->trans_rollback();
            // echo "ola";
            return array(
                "status" => "ee",
                "id" => $_REQUEST["id"],
                "msg" => $e->getMessage(),
                "type" => "error"
            );
            // echo json_encode(array("status" => "ee", "msg" => ));
        }


    }

    public function anular($array) {

        try {
            $data = array(
                "estado" => 'I'
            );

            if($this->validarLogCampos($array[0], "M")) {
                $data["fecha_ultima_anulacion"] = date("Y-m-d H:i:s");
                $data["usuario_ultima_anulacion"] = session("usuario_user");
                // $data["pc_ultima_anulacion"] = $this->session->caja_pcname;
            }


            // $this->db->where($array[1], $_REQUEST["id"]);
            // // $estado = $this->db->update($array[0], $data);
            // $estado = $this->db->update($array[0], $data);

            $estado = DB::table($array[0])
            ->where($array[1], $_REQUEST["id"])
            ->update($data);

            // $db_error = $this->db->error();

            // if ($db_error["code"] != 0) {
            //     throw new Exception('Database error! Error Code [' . $db_error['code'] . '] Error: ' . $db_error['message']);
            //     return false; // unreachable retrun statement !!!
            // }

            if ($estado) {
                return array(
                    "status" => "a",
                    "id" => $_REQUEST["id"],
                    "type" => "success",
                    "msg" => "SE ANULÓ CORRECTAMENTE"
                );
            } else {
                return array(
                    "status" => "ea",
                    "id" => $_REQUEST["id"],
                    "type" => "error",
                    "msg" => "ERROR AL ANULAR"
                );
            }

        } catch (\Illuminate\Database\QueryException $e) {

            return array(
                "status" => "ea",
                "id" => $_REQUEST["id"],
                "msg" => $e->getMessage(),
                "type" => "error"
            );

        }




    }

    public function activar($array) {
        try {
            $data = array(
                "estado" => 'A'
            );
            if($this->validarLogCampos($array[0], "A")) {
                $data["fecha_ultima_activacion"] = date("Y-m-d H:i:s");
                $data["usuario_ultima_activacion"] = session("usuario_user");
                // $data["pc_ultima_activacion"] = $this->session->caja_pcname;
            }

            // $this->db->where($array[1], $_REQUEST["id"]);
            // // $estado = $this->db->update($array[0], $data);
            // $estado = $this->db->update($array[0], $data);


            $estado = DB::table($array[0])
            ->where($array[1], $_REQUEST["id"])
            ->update($data);

            $db_error = $this->db->error();

            // if ($db_error["code"] != 0) {
            //     throw new Exception('Database error! Error Code [' . $db_error['code'] . '] Error: ' . $db_error['message']);
            //     return false; // unreachable retrun statement !!!
            // }
            if ($estado) {
                return array(
                    "status" => "ac",
                    "id" => $_REQUEST["id"],
                    "type" => "success",
                    "msg" => "SE ACTIVÓ CORRECTAMENTE"
                );
            } else {
                return array(
                    "status" => "eac",
                    "id" => $_REQUEST["id"],
                    "type" => "error",
                    "msg" => "ERROR AL ACTIVAR"
                );
            }

        } catch (\Illuminate\Database\QueryException $e) {

            return array(
                "status" => "eac",
                "id" => $_REQUEST["id"],
                "msg" => $e->getMessage(),
                "type" => "error"
            );

        }

    }



    public function validarLogCampos($tabla, $operacion) {
        $camposLOG = array();
        $cont = 0;
        switch ($operacion) {
            case 'I':
                $camposLOG = $this->camposLogInsertar;
                break;
            case 'M':
                $camposLOG = $this->camposLogModificar;
                break;
            case 'A':
                $camposLOG = $this->camposLogAnular;
                break;
            case 'C':
                $camposLOG = $this->camposLogActivar;
                break;
        }

        // $campos = $this->db->list_fields($tabla);
        $campos = $this->listar_campos($tabla);
        // print_r($campos);
        // print_r($camposLOG);
        for ($i=0; $i < count($campos); $i++) {

            if(in_array($campos[$i], $camposLOG)) {
                $cont++;
            }
        }
        // exit;
        if($cont == 3) {
            return true;
        }
        return false;
    }

    public function listar_campos($tabla) {

        $campos = array();
        $tabla = explode(".", $tabla);
        $schema = $tabla[0];
        $table = $tabla[1];

        $sql = "SELECT cols.column_name, cols.data_type
        FROM information_schema.columns cols
        WHERE cols.table_schema='{$schema}' AND cols.table_name= '{$table}'";

        $result = DB::select($sql);

        foreach ($result as $key => $value) {
            array_push($campos, $value->column_name);
        }

        return $campos;
    }

    public function FormatoFecha($fecha, $formato) {
        if($fecha != null) {
            if($formato == "user") {
                $date = explode("-", $fecha);
                if(count($date) == 3) {
                    return $date[2] . "/" . $date[1] . "/" . $date[0];
                }
            }

            if($formato == "server") {
                $date = explode("/", $fecha);
                if(count($date) == 3) {
                    return $date[2] . "-" . $date[1] . "-" . $date[0];
                }
            }
        }

        return $fecha;
    }


    public function ObtenerVersion() {
        $Sql = "SELECT * FROM actualizaciones ORDER BY actualizacion_id LIMIT 1";
    }

    public function getPermisos($status = false) {
        // $modulos = $this->db->order_by("modulo_orden", "ASC")->get_where("modulos",array("estado" => "A", "modulo_padre" => "1", "modulo_id>"=> 1 ))->result();

        $sql_modulos = "SELECT m.*, 
        CASE WHEN mi.mi_descripcion IS NULL THEN 
        (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=m.modulo_id AND idioma_id=".session("idioma_id_defecto").")
        ELSE mi.mi_descripcion END AS mi_descripcion 
        FROM seguridad.modulos AS m
        LEFT JOIN seguridad.modulos_idiomas AS mi ON ( mi.modulo_id = m.modulo_id AND mi.idioma_id=".session("idioma_id").")
        WHERE m.estado='A' AND m.modulo_padre=1 AND m.modulo_id>1 
        ORDER BY m.modulo_orden ASC";
        $modulos = DB::select($sql_modulos);

       
        if(!$status) {

            foreach ($modulos as $key => $value) {
                // $modulos[$key]->hijos = $this->db->order_by("modulo_orden","asc")->get_where("modulos",array("modulo_padre" => $value->modulo_id, "estado" => "A"))->result();

                $sql_hijos = "SELECT m.*,  CASE WHEN mi.mi_descripcion IS NULL THEN 
                (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=m.modulo_id AND idioma_id=".session("idioma_id_defecto").")
                ELSE mi.mi_descripcion END AS mi_descripcion 
                FROM seguridad.modulos AS m
                LEFT JOIN seguridad.modulos_idiomas AS mi ON ( mi.modulo_id = m.modulo_id AND mi.idioma_id=".session("idioma_id").")
                WHERE m.estado='A' AND m.modulo_padre={$value->modulo_id}
                ORDER BY m.modulo_orden ASC";
                $modulos[$key]->hijos = DB::select($sql_hijos);
                
            }
          
        } else {

            foreach ($modulos as $key => $value) {

                // $r = $this->db->query("SELECT m.* FROM modulos AS m
                // INNER JOIN seguridad.permisos AS p ON(m.modulo_id=p.modulo_id)
                // WHERE m.estado = 'A' AND p.perfil_id = ".session("perfil_id")." AND m.modulo_padre = ".$value->modulo_id. "
                // GROUP BY m.modulo_id
                // ORDER BY m.modulo_orden ASC")->result();

                $sql_hijos = "SELECT m.*, 
                CASE WHEN mi.mi_descripcion IS NULL THEN 
                (SELECT mi_descripcion FROM seguridad.modulos_idiomas WHERE modulo_id=m.modulo_id AND idioma_id=".session("idioma_id_defecto").")
                ELSE mi.mi_descripcion END AS mi_descripcion 
                FROM seguridad.modulos AS m 
                INNER JOIN seguridad.permisos AS p ON(m.modulo_id=p.modulo_id)
                LEFT JOIN seguridad.modulos_idiomas AS mi ON ( mi.modulo_id = m.modulo_id AND mi.idioma_id=".session("idioma_id").")
                WHERE m.estado = 'A' AND p.perfil_id = ".session("perfil_id")."  AND m.modulo_padre = ".$value->modulo_id. "
                GROUP BY m.modulo_id, mi.mi_descripcion
                ORDER BY m.modulo_orden ASC";
                // die($sql_hijos);
                $r = DB::select($sql_hijos);

                if(count($r)>0) {

                    $modulos[$key]->hijos = $r;

                } else {
                    //BORRAMOS LA POSICION DEL MODULO PADRE QUE NO TENGA HIJOS
                    unset($modulos[$key]);
                }
            }
           
        }
    
        return $modulos;

    }

    public function obtener_idiomas() {
        $sql = "SELECT * FROM public.idiomas WHERE estado='A'";

        return DB::select($sql);
    }
}
