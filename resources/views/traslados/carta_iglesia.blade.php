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
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.iglesia_en") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for=""><strong>{{ $miembro[0]->iglesia }}</strong></label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 100%;">
                <label for="">{{ traducir("traductor.saludo_carta") }}</label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" >
            <div class="col" style="width: 100%; line-height: 20px;">
                <label for="">
                    {{ traducir("traductor.agrado") }} <strong>{{ $miembro[0]->apellidos }}, {{ $miembro[0]->nombres }}</strong> {{ traducir("traductor.nacido") }} <strong>{{ $miembro[0]->fechanacimiento }}</strong> {{ traducir("traductor.bautizado") }} <strong>{{ $miembro[0]->fechabautizo }}</strong> {{ traducir("traductor.de_estado_civil") }}
                    
                </label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 40px;">
            <div class="col" style="width: 100%; line-height: 20px; text-align: justify;">
                <label for="">
                    
                <?php 
                    
                    foreach ($estado_civil as $kec => $vec) {
                        if($vec->idestadocivil == $miembro[0]->idestadocivil) {
                            echo '<input checked="checked" type="radio" >&nbsp;&nbsp;'.$vec->descripcion."&nbsp;&nbsp;";
                        } else {
                            echo '<input  type="radio" >&nbsp;&nbsp;'.$vec->descripcion."&nbsp;&nbsp;";
                        }
                       
                    }
                
                ?>
                {{ traducir("traductor.parrafo1_carta") }}
                </label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 40px;">
            <div class="col" style="width: 100%; line-height: 20px; text-align: justify;">
                <label for="">
                    
                    {{ traducir("traductor.parrafo2_carta") }}
                </label>
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 50px;">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.comentarios_") }}</label>
            </div>
            <div class="col" style="width: 85%; height:18px; border-bottom: 1px dashed black;">
                <label for=""></label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 30%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.de_iglesia_en") }}</label>
            </div>
            <div class="col" style="width: 50%;">
                <label for=""><strong>{{ $miembro[0]->iglesia }}</strong></label>
            </div>
        </div> 
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 50px !important;">
            <div class="col" style="width: 30%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.direccion") }}: </label>
            </div>
            <div class="col" style="width: 50%;">
                <label for=""><strong>{{ $miembro[0]->direccion_iglesia }}</strong></label>
            </div>
        </div> 
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 50px !important;">
            <div class="col" style="width: 30%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.anciano_director") }}: </label>
            </div>
            <div class="col" style="width: 30%;">
                <label for=""><strong>{{ $miembro[0]->bautizador }}</strong></label><br>
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
            <div class="col" style="width: 30%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.secretario") }}: </label>
            </div>
            <div class="col" style="width: 30%;" >
                <label for="" ></label><br>
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
            <div class="col" style="width: 30%;">

            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha") }}: </label>
            </div>
            <div class="col" style="width: 50%;">
                <label for="" style=""><strong>{{ $fecha }}</strong></label>
            </div>
        </div> 
      
    </div>
    
    
</body>
</html>