<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Feligresia</title>
    <style>

        /* referencia: https://ourcodeworld.co/articulos/leer/687/como-configurar-un-encabezado-y-pie-de-pagina-en-dompdf */
        @page {
            margin: 0cm 0cm;
        }

        /** Defina ahora los márgenes reales de cada página en el PDF **/
        body {
            margin-top: 3.3cm;
            margin-left: 2cm;
            margin-right: 2cm;
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
            font-size: 11px;
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
                <h3><?php echo strtoupper(traducir("traductor.lista_feligresia")); ?></h3>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.iglesia_localizada") }}</label>
            </div>

            <div class="col" style="width: 50%;">
                <label for=""><strong>{{ $miembros[0]->iglesia }}</strong></label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fecha") }}</label>
            </div>

            <div class="col" style="width: 15%;">
                <label for=""><strong>{{ date("d/m/Y") }}</strong></label>
            </div>
            
            

            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 250px;">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>N°</th>
                            <th>{{ traducir("traductor.nombre_direccion_telefono") }}</th>
                            <th>{{ traducir("traductor.fecha_nacimiento") }}</th>
                            <th>{{ traducir("traductor.fecha_aceptacion") }}</th>
                            <th>{{ traducir("traductor.fecha_baja_iglesia") }}</th>
                            <th>{{ traducir("traductor.motivo_baja_iglesia") }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                            $i = 1;
                            foreach ($miembros as $key => $value) {
                                $fecha_baja = "-.-";
                                if(isset($value->bajas[0]->fecha)) {
                                    $fecha_baja = $value->bajas[0]->fecha;
                                }
                                $fecha_aceptacion = "-.-";
                                if(isset($value->control[0]->fecha_aceptacion)) {
                                    $fecha_aceptacion = $value->control[0]->fecha_aceptacion;
                                }


                                $checked_1 = ($value->idcondicioneclesiastica == 1) ? 'checked="checked"' : ''; 
                                $checked_2 = ($value->idcondicioneclesiastica == 0) ? 'checked="checked"' : '';
                                $checkbox = '<input '.$checked_1.' type="checkbox" /> Bautismo <br> <input '.$checked_2.' type="checkbox" /> Recibimiento';

                                echo '<tr>';
                                echo '<td>'.$i.'</td>';
                                echo '<td style="line-height: 15px;">'.$value->apellidos.', '.$value->nombres.'<br>'.  $value->direccion.'<br>'.$value->telefono.'</td>';
                                echo '<td align="center">'.$value->fechanacimiento.'</td>';
                                
                                echo '<td align="center">'.$fecha_aceptacion.'<br>'.$checkbox.'</td>';
                                echo '<td align="center">'.$fecha_baja.'</td>';
                                echo '<td>';

                                    foreach ($motivos_baja as $kmb => $vmb) {
                                        if(isset($value->bajas[0]->idmotivobaja) && $vmb->idmotivobaja == $value->bajas[0]->idmotivobaja) {
                                            echo '<input checked="checked" type="radio" >&nbsp;&nbsp;'.$vmb->descripcion."<br>";
                                        } else {
                                            echo '<input  type="radio" >&nbsp;&nbsp;'.$vmb->descripcion."<br>";
                                        }
                                    
                                    }
                            
                         
                                
                                echo '</td>';
                                echo '</tr>';
                              

                                $i++;
                            }
                        ?>
                    </tbody>
                </table>
            </div>

           
            

            
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.feligresia_total") }}</label>
            </div>

            <div class="col" style="width: 3%;">
                <label for=""><strong>{{ $i - 1 }}</strong></label>
            </div>

            <div class="col" style="width: 27%;">
                <label for="">{{ traducir("traductor.nombre_secretario_igleseia") }}</label>
            </div>

            <div class="col" style="width: 35%;">
                <label for=""><strong>{{ $nombre_secretario }}</strong></label>
            </div>


            <div class="col" style="width: 20%;">
                <center>

                    <label for="" style="height: 15px; border-bottom: 1px dashed black; display:block; width: 100%;"></label>
                    <label for="">{{ traducir("traductor.firma") }}</label>
                </center>
            </div>
            
            
            

            
        </div>
        
   
      
    

    </main>
    
    
</body>
</html>