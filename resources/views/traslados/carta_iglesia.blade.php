<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carta de Iglesia</title>
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
                <h3><?php echo strtoupper(traducir("traductor.carta_iglesia")); ?></h3>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 30%;">
                <label for="">{{ traducir("traductor.iglesia_en") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for=""></label>
            </div>
        </div>
        <div class="row">
            <div class="col" style="width: 100%;">
                <label for="">{{ traducir("traductor.saludo_carta") }}</label>
            </div>
            
        </div>
        <div class="row">
            <div class="col" style="width: 100%;">
                <label for="">{{ traducir("traductor.agrado") }} ____________ {{ traducir("traductor.nacido") }} ______________ {{ traducir("traductor.bautizado") }}</label>
            </div>
            
        </div>
      
    </div>
    
    
</body>
</html>