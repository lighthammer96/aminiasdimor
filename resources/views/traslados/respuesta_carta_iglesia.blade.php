<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Respuesta a Carta de Iglesia</title>
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
            font-size: 14px;
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
    @include('layouts.cabecera')

    <main>
        <div class="row" style="margin-top: 30px; margin-bottom: 50px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo mayusculas(traducir("traductor.respuesta_carta_iglesia")); ?></h3>
            </div>
        </div>
        <div class="clear"></div>
        
        <div class="row">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.iglesia_en") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for=""><strong>{{ $control[0]->iglesia_destino }}</strong></label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 100%;">
                <label for="">{{ traducir("traductor.saludo_carta") }}</label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 100px;">
            <div class="col" style="width: 100%; line-height: 20px; text-align: justify;">
                <label for="">
                    {{ traducir("traductor.agrado") }} <strong>{{ $miembro[0]->apellidos }}, {{ $miembro[0]->nombres }}</strong> {{ traducir("traductor.nacido") }} <strong>{{ $miembro[0]->fechanacimiento }}</strong>{{ traducir("traductor.bautizado") }} <strong>{{ $miembro[0]->fechabautizo }}</strong>{{ traducir("traductor.de_estado_civil") }} <strong>{{ $miembro[0]->estado_civil }}</strong>{{ traducir("traductor.recomendado") }} <strong>{{ $control[0]->fecha }}</strong> {{ traducir("traductor.aceptado") }} <strong>{{ $fecha }}</strong>
                    
                </label>
            </div>
            
        </div>
        <!-- <div class="clear"></div>
        <div class="row" style="margin-bottom: 70px; ">
            <div class="col" style="width: 100%; line-height: 20px; text-align: justify;">
                <label for=""> -->
                    
                <?php 
                    
                    // foreach ($estado_civil as $kec => $vec) {
                    //     if($vec->idestadocivil == $miembro[0]->idestadocivil) {
                    //         echo '<input checked="checked" type="radio" >&nbsp;&nbsp;'.$vec->descripcion."&nbsp;&nbsp;";
                    //     } else {
                    //         echo '<input  type="radio" >&nbsp;&nbsp;'.$vec->descripcion."&nbsp;&nbsp;";
                    //     }
                       
                    // }
                
                ?>
                <!-- {{-- traducir("traductor.recomendado") --}} <strong>{{-- $control[0]->fecha --}}</strong> {{-- traducir("traductor.aceptado") --}} <strong>{{-- $fecha --}}</strong> -->
                <!-- </label>
            </div>
            
        </div> -->
       


        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 20%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.de_iglesia_en") }}</label>
            </div>
            <div class="col" style="width: 60%;">
                <label for=""><strong>{{ $control[0]->iglesia_origen }}</strong></label>
            </div>
        </div> 
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 50px !important;">
            <div class="col" style="width: 20%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.direccion") }}: </label>
            </div>
            <div class="col" style="width: 60%;">
                <label for=""><strong>{{ $control[0]->direccion_destino }}</strong></label>
            </div>
        </div> 
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 50px !important;">
            <div class="col" style="width: 20%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.anciano_director") }}: </label>
            </div>
            <div class="col" style="width: 40%;">
                <label for=""><strong>{{ $nombre_director }}</strong></label><br>
                <center>
                    
                    <label for="">{{ traducir("traductor.nombre") }}</label>
                </center>
               
            </div>
            <div class="col" style="width: 20%; " >
                <center>
                    <label for="" style="height: 15px; border-bottom: 1px dashed black; display:block; width: 100%;"></label>
                    <label for="">{{ traducir("traductor.firma") }}</label>
                </center>
            </div>
        </div> 
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px !important;">
            <div class="col" style="width: 20%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.secretario") }}: </label>
            </div>
            <div class="col" style="width: 40%;" >
                <label for="" ><strong>{{ $nombre_secretario }}</strong></label><br>
                <center>
                    <label for="">{{ traducir("traductor.nombre") }}</label>
                </center>
               
            </div>
            <div class="col" style="width: 20%; ">
                <center>
                    <label for="" style="height: 15px; border-bottom: 1px dashed black; display:block; width: 100%;"></label>
                    <label for="">{{ traducir("traductor.firma") }}</label>
                </center>
            </div>
        </div> 
        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 20%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha") }}: </label>
            </div>
            <div class="col" style="width: 60%;">
                <label for="" style=""><strong>{{ $control[0]->fecha }}</strong></label>
            </div>
        </div> 
    </main>
   
      

    
    
</body>
</html>