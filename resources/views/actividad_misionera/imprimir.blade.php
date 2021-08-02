<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ traducir("traductor.titulo_informe_misionero_trimestral_iglesia") }}</title>
    <style>

        /* referencia: https://ourcodeworld.co/articulos/leer/687/como-configurar-un-encabezado-y-pie-de-pagina-en-dompdf */
        @page {
            margin: 0cm 0cm;
        }

        /** Defina ahora los márgenes reales de cada página en el PDF **/
        body {
            margin-top: 3.3cm;
            margin-left: 0.5cm;
            margin-right: 0.5cm;
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
        
        
        <div class="row" style="margin-top: 30px; margin-bottom: 50px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo mayusculas(traducir("traductor.titulo_informe_misionero_trimestral_iglesia")); ?></h3>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.iglesia_localizada") }}</label>
            </div>
            <div class="col" style="width: 45%;">
                <label for=""><strong>{{ $nivel_organizativo }}</strong></label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.periodo_informe") }}: {{ traducir("traductor.anio") }}</label>
            </div>
            <div class="col" style="width: 5%;">
                <label for=""><strong>{{ $anio }}</strong></label>
            </div>
          
        </div>

        <div class="row" style="">
            <div class="col" style="width: 75%;">
                <label for=""></label>
            </div>
          
            <div class="col" style="width: 25%;">
                <label for="">{{ $trimestre }}</label>
            </div>
            
          
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%;">
                    <thead>
                        <tr>
                            <th rowspan="2">{{ traducir("traductor.para_semana_termina") }}</th>
                            <th rowspan="2">{{ traducir("traductor.estudios_biblicos") }}</th>
                            <th rowspan="2">{{ traducir("traductor.visitas_misioneras") }}</th>
                            <th rowspan="2">{{ traducir("traductor.conferencias_biblicas") }}</th>
                            <th rowspan="2">{{ traducir("traductor.seminarios") }}</th>
                            <th rowspan="2">{{ traducir("traductor.congresos") }}</th>
                            <th colspan="3">{{ traducir("traductor.distribucion_externa") }}</th>
                            <th colspan="3">{{ traducir("traductor.distribucion_interna") }}</th>
                        </tr>
                        <tr>
                            <th>{{ traducir("traductor.libros") }}</th>
                            <th>{{ traducir("traductor.revistas") }}</th>
                            <th>{{ traducir("traductor.volantes") }}</th>
                            <th>{{ traducir("traductor.lecciones_esc_sab") }}</th>
                            <th>{{ traducir("traductor.guard_sab") }}</th>
                            <th>{{ traducir("traductor.ancla_juvenil") }}</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                        <?php 
                            $estudios_biblicos = 0;
                            $visitas_misioneras = 0;
                            $conferencias_publicas = 0;
                            $seminarios = 0;
                            $congresos = 0;
                            $libros = 0;
                            $revistas = 0;
                            $volantes = 0;
                            $lecciones = 0;
                            $guard = 0;
                            $ancla_juvenil = 0;
                            foreach ($actividades as $key => $value) {
                                echo '<tr>';
                                echo '  <td>'.$value->fecha_final.'</td>';
                                echo '  <td>'.$value->estudios_biblicos  .'</td>';
                                echo '  <td>'.$value->visitas_misioneras  .'</td>';
                                echo '  <td>'.$value->conferencias_publicas  .'</td>';
                                echo '  <td>'.$value->seminarios  .'</td>';
                                echo '  <td>'.$value->congresos  .'</td>';
                                echo '  <td>'.$value->libros  .'</td>';
                                echo '  <td>'.$value->revistas  .'</td>';
                                echo '  <td>'.$value->volantes  .'</td>';
                                echo '  <td>'.$value->lecciones  .'</td>';
                                echo '  <td>'.$value->guard  .'</td>';
                                echo '  <td>'.$value->ancla_juvenil  .'</td>';

                                echo '</tr>';

                                $estudios_biblicos += intval($value->estudios_biblicos);
                                $visitas_misioneras += intval($value->visitas_misioneras);
                                $conferencias_publicas += intval($value->conferencias_publicas);
                                $seminarios += intval($value->seminarios);
                                $congresos += intval($value->congresos);
                                $libros += intval($value->libros);
                                $revistas += intval($value->revistas);
                                $volantes += intval($value->volantes);
                                $lecciones += intval($value->lecciones);
                                $guard += intval($value->guard);
                                $ancla_juvenil += intval($value->ancla_juvenil);
                            }

                            echo '<tr>';
                            echo '  <td>'.traducir("traductor.total_trimestre").'</td>';
                            echo '  <td>'.$estudios_biblicos.'</td>';
                            echo '  <td>'.$visitas_misioneras.'</td>';
                            echo '  <td>'.$conferencias_publicas.'</td>';
                            echo '  <td>'.$seminarios.'</td>';
                            echo '  <td>'.$congresos.'</td>';
                            echo '  <td>'.$libros.'</td>';
                            echo '  <td>'.$revistas.'</td>';
                            echo '  <td>'.$volantes.'</td>';
                            echo '  <td>'.$lecciones.'</td>';
                            echo '  <td>'.$guard.'</td>';
                            echo '  <td>'.$ancla_juvenil.'</td>';
                            echo '</tr>';
                        ?>
                    </tbody>
                </table>
            </div>
        </div>    
        
        <div class="clear"></div>
        <br><br>
        <div class="row" style="height: 100px;">
            <div class="col" style="width: 100%;">
                <label for="" style="font-size: 20px !important;">{{ traducir("traductor.informe_espiritual") }}</label><br>
                <label for="">{{ $informe_espiritual }}</label>
            </div>         
        </div>
        <div class="clear"></div>
        <div class="row" style="height: 100px; margin-bottom: 120px; ">
            <div class="col" style="width: 100%;">
                <label for="" style="font-size: 20px !important;">{{ traducir("traductor.planes") }}</label><br>
                <label for="">{{ $planes }}</label>
            </div>         
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 20px;">
            <div class="col" style="width: 37%;">
                <label for=""><strong><strong>{{ $director }}</strong></label><br>
                <label for="">{{ traducir("traductor.anciano_director_iglesia") }}</label>
            </div>
            <div class="col" style="width: 13%;">
                <center>
                    <label for=""></label><br>
                    <label for="">{{ traducir("traductor.firma") }}</label>
                </center>
            </div>
            <div class="col" style="width: 37%;">
                <label for=""><strong>{{ $director_obra }}</strong></label><br>
                <label for="">{{ traducir("traductor.director_obra_misionera") }}</label>
            </div>
            <div class="col" style="width: 13%;">
                <center>
                    <label for=""></label><br>
                    <label for="">{{ traducir("traductor.firma") }}</label>
                </center>
            </div>
         
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 85%;">
                <label for=""></label><br>
                <label for=""></label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.fecha") }}: </label>
                <label for=""><strong>{{ fecha_actual_idioma() }}</strong></label>
            </div>
            
         
        </div>
   
      
    

    </main>
    
    
</body>
</html>