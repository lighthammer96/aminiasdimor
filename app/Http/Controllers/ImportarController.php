<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\IOFactory;



class ImportarController extends Controller
{
    //
  
    
    public function __construct() {
        parent:: __construct();
     
    }

    public function importar() {
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
    
}
