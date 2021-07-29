<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oficiales de Iglesia</title>
    <style>

        /* referencia: https://ourcodeworld.co/articulos/leer/687/como-configurar-un-encabezado-y-pie-de-pagina-en-dompdf */
        @page {
            margin: 0cm 0cm;
        }

        /** Defina ahora los márgenes reales de cada página en el PDF **/
        body {
            margin-top: 3.3cm;
            margin-left: 1cm;
            margin-right: 1cm;
            margin-bottom: 2cm;
        }
            
        header {
            position: fixed;
            top: 0.9cm;
            left: 2cm;
            right: 2cm;
            height: 2.5cm;
            text-align: center;
            line-height: 0.8cm;
            font-family: 'Times New Roman' !important;
        }

        * {
            font-family: 'Roboto', sans-serif;
            box-sizing: border-box;
            /* font-weight: bold; */
            font-size: 12px;
        }
		

        /* #contenido {
            
            width: 696px; */
            /* border: 1px solid gray */
					
        /* } */

        /* #logo img {
		
            width: 100%;
        }

        #empresa, #documento {
            padding: 1%;
        }

        #cliente {
            border-radius: 5px; 
            border: 1px solid gray; 
            padding: 1%;
            height: 70px;

        }
     */


        .row {
            width: 100%;
            height: 30px;
            /* margin-top: 15px; */
            /* clear: both; */
        }

        .row-sm {
            width: 100%;
            height: 20px;
            /* margin-top: 15px; */
            /* clear: both; */
        }
        .clear {
            clear: both; 
        }
        .col {
            float: left;
            /* border: 1px solid black; */
        }
        

        h2, h3, h4, h5 {
            /* text-align: center !important; */
            margin: 2px 0;
            /* padding-botton: 2px; */
			
        }
    </style>
   
</head>
<body>
    @include("layouts.cabecera")
    <main>
        
        <div class="clear"></div>
        <div class="row" style="margin-top: 10px; margin-bottom: 20px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo strtoupper(traducir("traductor.eleccion_oficiales_iglesia")); ?></h3>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.iglesia_localizada") }}</label>
            </div>

            <div class="col" style="width: 50%;">
                <label for=""><strong>{{ $nivel_organizativo }}</strong></label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.anio") }}</label>
            </div>

            <div class="col" style="width: 15%;">
                <label for=""><strong>{{ $anio }}</strong></label>
            </div>
            
            

            
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($director[0])
                            {{ strtoupper($director[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director[0])
                            {{ $director[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($director[0])
                            {{ $director[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($director[0])
                            {{ $director[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director[0])
                            {{ $director[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director[0])
                            {{ $director[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director[0])
                            {{ $director[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>




        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($secretario[0])
                            {{ strtoupper($secretario[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($tesorero[0])
                            {{ strtoupper($tesorero[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($diacono[0])
                            {{ strtoupper($diacono[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($diacono[0])
                            {{ $diacono[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($diacono[0])
                            {{ $diacono[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($diacono[0])
                            {{ $diacono[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($diacono[0])
                            {{ $diacono[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($diacono[0])
                            {{ $diacono[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($diacono[0])
                            {{ $diacono[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($director_escuela_sabatica[0])
                            {{ strtoupper($director_escuela_sabatica[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_escuela_sabatica[0])
                            {{ $director_escuela_sabatica[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($director_escuela_sabatica[0])
                            {{ $director_escuela_sabatica[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($director_escuela_sabatica[0])
                            {{ $director_escuela_sabatica[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_escuela_sabatica[0])
                            {{ $director_escuela_sabatica[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_escuela_sabatica[0])
                            {{ $director_escuela_sabatica[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_escuela_sabatica[0])
                            {{ $director_escuela_sabatica[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($director_obra_misionera[0])
                            {{ strtoupper($director_obra_misionera[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_obra_misionera[0])
                            {{ $director_obra_misionera[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($director_obra_misionera[0])
                            {{ $director_obra_misionera[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($director_obra_misionera[0])
                            {{ $director_obra_misionera[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_obra_misionera[0])
                            {{ $director_obra_misionera[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_obra_misionera[0])
                            {{ $director_obra_misionera[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_obra_misionera[0])
                            {{ $director_obra_misionera[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($director_jovenes[0])
                            {{ strtoupper($director_jovenes[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_jovenes[0])
                            {{ $director_jovenes[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($director_jovenes[0])
                            {{ $director_jovenes[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($director_jovenes[0])
                            {{ $director_jovenes[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 100px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_jovenes[0])
                            {{ $director_jovenes[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_jovenes[0])
                            {{ $director_jovenes[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_jovenes[0])
                            {{ $director_jovenes[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 45%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_anciano_director_iglesia") }}</label>
               
            </div>
            <div class="col" style="width: 10%;"></div>
            <div class="col" style="width: 45%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_secretario_iglesia") }}</label>
            </div>
        </div>

        <div class="row" style="">
            <div class="col" style="width: 90%;">
                <label for=""></label>
               
            </div>
         
            <div class="col" style="width: 10%; text-align: center">
                <label for=""><strong>{{ fecha_actual_idioma() }}</strong></label><br>
                <label for="">{{ traducir("traductor.fecha") }}</label>
            </div>
        </div>
        
   
      
    

    </main>
    
    
</body>
</html>