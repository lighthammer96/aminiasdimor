<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificado de Bautizo</title>
    <style>

        * {
            font-family: 'Roboto', sans-serif;
            box-sizing: border-box;
            /* font-weight: bold; */
            font-size: 14px;
        }
		

        #contenido {
            
            width: 696px;
            /* border: 1px solid gray */
					
        }

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
    <div id="contenido">
        <img style="width: 794px; margin-left: -45px; " src="{{ URL::asset('images/cabecera_reportes.png') }}" alt="">
        <div class="row" style="margin-top: 30px; margin-bottom: 50px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo strtoupper(traducir("traductor.certificado_bautizo")); ?></h3>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; text-align: center;">
                <label for="">{{ traducir("traductor.por_presente") }} </label>
            </div>
          
        </div>
        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important; text-align: center;">
            <div class="col" style="width: 100%;">
                <label for=""><strong>{{ $miembro[0]->apellidos }}, {{ $miembro[0]->nombres }}</strong></label>
            </div>
           
        </div>
        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important; text-align: center; line-height: 30px;">
            <div class="col" style="width: 100%;">
                <label for="">{{ traducir("traductor.fue_bautizado") }} <strong>{{ $miembro[0]->fechabautizo }}</strong> {{ traducir("traductor.fue_aceptado") }}</label>
            </div>
           
        </div>

        <div class="row" style="margin-top: 200px; text-align: center;">
            <div class="col" style="width: 50%;">
                <label for=""><strong>{{ $miembro[0]->iglesia }}</strong></label><br>
                <label for="">{{ traducir("traductor.iglesia_local") }}</label>
            </div>
            <div class="col" style="width: 50%;">
                <label for=""></label><br>
                <label for="">{{ traducir("traductor.texto_bautismal") }}</label>
            </div>
            <!-- <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.texto_bautismal") }}</label>
            </div>
            <div class="col" style="width: 25%;">
                <label for=""></label>
            </div> -->
         
        </div>

        <div class="row" style="margin-top: 150px;">
            <div class="col" style="width: 35%;">
                <label for=""><strong>{{ $miembro[0]->bautizador }}</strong></label><br>
                <label for="">{{ traducir("traductor.nombre_ministro") }}</label>
            </div>
            <div class="col" style="width: 15%;">
                <label for=""></label><br>
                <label for="">{{ traducir("traductor.firma") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for=""></label><br>
                <label for="">{{ traducir("traductor.nombre_secretario") }}</label>
            </div>
            <div class="col" style="width: 15%;">
                <label for=""></label><br>
                <label for="">{{ traducir("traductor.firma") }}</label>
            </div>
         
        </div>
   
      
    </div>
    
    
</body>
</html>