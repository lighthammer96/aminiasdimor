<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\IOFactory;
use App\Models\BaseModel;


class ImportarController extends Controller
{
    //
  
    
    public function __construct() {
        parent:: __construct();
        $this->base_model = new BaseModel();
    }

    public function importar_() {
        ini_set('max_execution_time', 600);
        // $r = $this->SubirArchivo($_FILES["excel"], "./assets/excels/", "");
        $campos =  array();
        $celdas =  array();

        $inputFileType = 'Xlsx';
        $inputFileName = base_path("public/excel/Ubigeos de Paises.xlsx");
        

        $reader = IOFactory::createReader($inputFileType);
        $reader->setLoadSheetsOnly("Brasil");
        $spreadsheet = $reader->load($inputFileName);

        $sheetData = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
        // echo "<pre>";
        // print_r($sheetData);
        // exit;
        // foreach ($sheetData as $key => $value) {
        //     if(!empty($value) && !empty($key)) {

        //         $campos[$key] = $value;
        //         $celdas[$value] = $key;
        //     }
        // }

        $count = count($sheetData);
        
        $division1 = array();
        $division2 = array();
        $division3 = array();
        $id1 = "";
        $id2 = "";
        $id3 = "";
        for ($i=2; $i < $count ; $i++) { 
           // echo $sheetData[$i]["A"]. " ".$sheetData[$i]["B"]."<br>";

            if(!in_array($sheetData[$i]["A"] , $division1)) {
                array_push($division1, $sheetData[$i]["A"]);

                $data_division1 = array(
                    "descripcion" => $sheetData[$i]["A"],
                    "pais_id" => 23
                );


                DB::table('public.departamento')->insert($data_division1);
                $id1 = DB::getPdo()->lastInsertId();
                echo "DIVISION 1: ".$sheetData[$i]["A"]. " INSERTADO ...<br>";
            }

            if(!in_array($sheetData[$i]["B"] , $division2)) {
                array_push($division2, $sheetData[$i]["B"]);


                $data_division2 = array(
                    "descripcion" => $sheetData[$i]["B"],
                    "iddepartamento" => $id1
                );


                DB::table('public.provincia')->insert($data_division2);
                $id2 = DB::getPdo()->lastInsertId();
                echo "DIVISION 2: ".$sheetData[$i]["B"]. " INSERTADO ...<br>";
            }


            // if(!in_array($sheetData[$i]["C"] , $division3)) {
            //     array_push($division3, $sheetData[$i]["C"]);


            //     $data_division3 = array(
            //         "descripcion" => $sheetData[$i]["C"],
            //         "idprovincia" => $id2
            //     );


            //     DB::table('public.distrito')->insert($data_division3);
            //     $id3 = DB::getPdo()->lastInsertId();
            //     echo "DIVISION 3: ".$sheetData[$i]["C"]. " INSERTADO ...<br>";
            // }
        }


        // print_r($division1);
        // print_r($division2); exit;
    }


    public function importar() {
        ini_set('max_execution_time', 600);
        // $r = $this->SubirArchivo($_FILES["excel"], "./assets/excels/", "");
        $campos =  array();
        $celdas =  array();

        $inputFileType = 'Xlsx';
        $inputFileName = base_path("public/excel/Formato_Jerarquia.xlsx");
        

        $reader = IOFactory::createReader($inputFileType);
        $reader->setLoadSheetsOnly("Hoja2");
        $spreadsheet = $reader->load($inputFileName);

        $sheetData = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
        // echo "<pre>";
        // print_r($sheetData);
        // exit;
        // foreach ($sheetData as $key => $value) {
        //     if(!empty($value) && !empty($key)) {

        //         $campos[$key] = $value;
        //         $celdas[$value] = $key;
        //     }
        // }

        $count = count($sheetData);
        
        $union = array();
        $asociacion = array();
        $distrito = array();
        // $distrito = array();

        $union_id = "";
        $asociacion_id = "";
        $distrito_id = "";
        for ($i=2; $i < $count ; $i++) { 
           // echo $sheetData[$i]["A"]. " ".$sheetData[$i]["B"]."<br>";

            if(!in_array($sheetData[$i]["C"] , $union)) {
                array_push($union, $sheetData[$i]["C"]);

                $data_union = array(
                    "descripcion" => trim($sheetData[$i]["C"]),
                
                );


                DB::table('iglesias.union')->insert($data_union);
                $union_id = DB::getPdo()->lastInsertId();


                $data_union = array(
                    "idunion" => $union_id,
                    "pais_id" => trim($sheetData[$i]["B"])
                );


                DB::table('iglesias.union_paises')->insert($data_union);
               // $union_id = DB::getPdo()->lastInsertId();



                echo "UNION: ".$sheetData[$i]["C"]. " INSERTADO ...<br>";
            }

            if(!in_array($sheetData[$i]["D"] , $asociacion)) {
                array_push($asociacion, $sheetData[$i]["D"]);


                $data_asociacion = array(
                    "descripcion" => $sheetData[$i]["D"],
                    "idunion" => $union_id,
                );


                DB::table('iglesias.mision')->insert($data_asociacion);
                $asociacion_id = DB::getPdo()->lastInsertId();

                echo "ASOCIACION: ".$sheetData[$i]["D"]. " INSERTADO ...<br>";
            }


            if(!in_array($sheetData[$i]["E"] , $distrito)) {
                array_push($distrito, $sheetData[$i]["E"]);


                $data_distrito = array(
                    "descripcion" => $sheetData[$i]["E"],
                    "idmision" => $asociacion_id,
                );


                DB::table('iglesias.distritomisionero')->insert($data_distrito);
                $distrito_id = DB::getPdo()->lastInsertId();

                echo "DISTRITO MISIONERO: ".$sheetData[$i]["E"]. " INSERTADO ...<br>";
            }

            $sql_division = "SELECT * FROM public.departamento AS d
            INNER JOIN public.provincia AS p ON (d.iddepartamento=p.iddepartamento)
            /*INNER JOIN public.distrito AS dd ON (dd.idprovincia=p.idprovincia)*/
            WHERE upper(p.descripcion)='".trim(strtoupper($sheetData[$i]["J"]))."'";
            $division = DB::select($sql_division);
            $data_iglesia =  array(
                "descripcion" => trim($sheetData[$i]["F"]),
                "direccion" => trim($sheetData[$i]["G"]),
                "iddivision" => trim($sheetData[$i]["A"]),
                "pais_id" => trim($sheetData[$i]["B"]),
                "idunion" => trim($union_id),
                "idmision" => trim($asociacion_id),
                "iddistritomisionero" => trim($distrito_id),
                "iddepartamento" => (isset($division[0]->iddepartamento)) ? $division[0]->iddepartamento : 0,
                "idprovincia" => (isset($division[0]->idprovincia)) ? $division[0]->idprovincia : 0,
                "iddistrito" => (isset($division[0]->iddistrito)) ? $division[0]->iddistrito : 0,
                "idcategoriaiglesia" => trim($sheetData[$i]["H"])
            );

            DB::table('iglesias.iglesia')->insert($data_iglesia);

            echo "IGLESIA: ".$sheetData[$i]["F"]. " INSERTADO ...<br>";
        }


        // print_r($division1);
        // print_r($division2); exit;
    }

    public function datos() {
        $view = "importar.index";
        $data["title"] = traducir("traductor.titulo_importar_datos");
        $data["subtitle"] = "";
        // $data["tabla"] = $this->cargos_model->tabla()->HTML();

      
        $data["scripts"] = $this->cargar_js(["importar.js"]);
        return parent::init($view, $data);
    }

    public function guardar_importar(Request $request) {
        // print_r($_FILES);
        // print_r($_REQUEST);
        ini_set('max_execution_time', 600);
        // $r = $this->SubirArchivo($_FILES["excel"], "./assets/excels/", "");
        $campos =  array();
        $celdas =  array();
        $result =  array();
        try {
            $nombre_archivo = $request->input("dato")."_".date("dmY")."_".date("His");
            $response = $this->SubirArchivo($_FILES["excel"], base_path("public/excel/"), $nombre_archivo);
            if ($response["response"] == "ERROR") {
                throw new Exception(traducir("traductor.error_archivo"));
            }

           
    
            $inputFileType = 'Xlsx';
            $inputFileName = base_path("public/excel/". $response["NombreFile"]);
            
    
            $reader = IOFactory::createReader($inputFileType);
            $reader->setLoadSheetsOnly($request->input("dato"));
            $spreadsheet = $reader->load($inputFileName);
    
            $sheetData = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
            // echo "<pre>";
            // print_r($sheetData);

           
            foreach ($sheetData[1] as $key => $value) {
                if(!empty($value) && !empty($key)) {
    
                    $campos[$key] = $value;
                    $celdas[$value] = $key;
                }
            }

            // print_r($campos);
            // print_r($celdas);
            // exit;

            $data = array();
            for ($i=2; $i <= count($sheetData) ; $i++) {
                $data =  array();
                foreach ($sheetData[$i] as $k => $v) {
                    if(isset($campos[$k]) && isset($sheetData[$i][$celdas[$campos[$k]]]) ) {
    
                        $data[$campos[$k]] = strtr(trim($sheetData[$i][$celdas[$campos[$k]]]),"àèìòùáéíóúçñäëïöü","ÀÈÌÒÙÁÉÍÓÚÇÑÄËÏÖÜ");
                    }
                }

                if($request->input("dato") == "asociados") {
                    $data["fecharegistro"] = date("Y-m-d H:i:s");
                    $idiglesia = (isset($sheetData[$i][$celdas["idiglesia"]])) ? $sheetData[$i][$celdas["idiglesia"]] : 0;
                    // $iddistritodomicilio = (isset($sheetData[$i][$celdas["iddistritodomicilio"]])) ? $sheetData[$i][$celdas["iddistritodomicilio"]] : 0;



                    $jerarquia = DB::select("SELECT * FROM iglesias.vista_jerarquia WHERE idiglesia={$idiglesia}");
    
                    // $division_politica = DB::select("SELECT * FROM public.vista_division_politica WHERE iddistrito={$iddistritodomicilio}");
                    
                    $data["iddivision"] = (isset($jerarquia[0]->iddivision)) ? $jerarquia[0]->iddivision : 0;
                    $data["pais_id"] = (isset($jerarquia[0]->pais_id)) ? $jerarquia[0]->pais_id : 0;
                    $data["idunion"] = (isset($jerarquia[0]->idunion)) ? $jerarquia[0]->idunion : 0;
                    $data["idmision"] = (isset($jerarquia[0]->idmision)) ? $jerarquia[0]->idmision : 0;
                    $data["iddistritomisionero"] = (isset($jerarquia[0]->iddistritomisionero)) ? $jerarquia[0]->iddistritomisionero : 0;
                    // $data["iddepartamentodomicilio"] = (isset($division_politica[0]->iddepartamento)) ? $division_politica[0]->iddepartamento : 0;
                    // $data["idprovinciadomicilio"] = (isset($division_politica[0]->idprovincia)) ? $division_politica[0]->idprovincia : 0;
                    // $data["iddistritodomicilio"] = (isset($division_politica[0]->iddistrito)) ? $division_politica[0]->iddistrito : 0;


                    $encargado_bautizo = DB::select("SELECT idmiembro AS id FROM iglesias.miembro WHERE idtipodoc={$sheetData[$i][$celdas["idtipodoc_encargado_bautizo"]]} AND nrodoc='{$sheetData[$i][$celdas["nrodoc_encargado_bautizo"]]}'");
                    $data["tabla_encargado_bautizo"] = "iglesias.miembro";

                    if(count($encargado_bautizo) <= 0) {
                        $encargado_bautizo = DB::select("SELECT idotrospastores AS id FROM iglesias.otrospastores WHERE idtipodoc={$sheetData[$i][$celdas["idtipodoc_encargado_bautizo"]]} AND nrodoc='{$sheetData[$i][$celdas["nrodoc_encargado_bautizo"]]}'");
                        $data["tabla_encargado_bautizo"] = "iglesias.otrospastores";
                    }
                    
                    $data["encargado_bautizo"] = $encargado_bautizo[0]->id;

                    $result = $this->base_model->insertar($this->preparar_datos("iglesias.miembro", $data));
                }
                // print_r($data);
                if($request->input("dato") == "iglesias") {

                    $iddistritomisionero = (isset($sheetData[$i][$celdas["iddistritomisionero"]])) ? $sheetData[$i][$celdas["iddistritomisionero"]] : 0;
                    // $iddistrito = (isset($sheetData[$i][$celdas["iddistrito"]])) ? $sheetData[$i][$celdas["iddistrito"]] : 0;


                    $jerarquia = DB::select("SELECT * FROM iglesias.vista_jerarquia WHERE iddistritomisionero={$iddistritomisionero}");
    
                    // $division_politica = DB::select("SELECT * FROM public.vista_division_politica WHERE iddistrito={$iddistrito}");
                    
                    $data["iddivision"] = (isset($jerarquia[0]->iddivision)) ? $jerarquia[0]->iddivision : 0;
                    $data["pais_id"] = (isset($jerarquia[0]->pais_id)) ? $jerarquia[0]->pais_id : 0;
                    $data["idunion"] = (isset($jerarquia[0]->idunion)) ? $jerarquia[0]->idunion : 0;
                    $data["idmision"] = (isset($jerarquia[0]->idmision)) ? $jerarquia[0]->idmision : 0;
                    $data["iddistritomisionero"] = (isset($jerarquia[0]->iddistritomisionero)) ? $jerarquia[0]->iddistritomisionero : 0;
                    // $data["iddepartamento"] = (isset($division_politica[0]->iddepartamento)) ? $division_politica[0]->iddepartamento : 0;
                    // $data["idprovincia"] = (isset($division_politica[0]->idprovincia)) ? $division_politica[0]->idprovincia : 0;
                    // $data["iddistrito"] = (isset($division_politica[0]->iddistrito)) ? $division_politica[0]->iddistrito : 0;
                   
                    $result = $this->base_model->insertar($this->preparar_datos("iglesias.iglesia", $data));
                }




               
                // print_r($sheetData[$i][$celdas["idiglesia"]]."<br>");
                // $this->db->insert($_REQUEST["tabla"], $data);
               
            }

          
        
            echo json_encode($result);
        } catch (Exception $e) {
            DB::rollBack();
            $response["status"] = "ei"; 
            $response["msg"] = $e->getMessage(); 
            echo json_encode($response);
        }
    }
    
}
