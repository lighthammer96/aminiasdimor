<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Propuesta de Tema</title>
    <style>

        /* referencia: https://ourcodeworld.co/articulos/leer/687/como-configurar-un-encabezado-y-pie-de-pagina-en-dompdf */
        @page {
            margin: 0cm 0cm;
        }

        /** Defina ahora los márgenes reales de cada página en el PDF **/
        body {
            margin-top: 4cm;
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
    @include("layouts.cabecera")
    <main>
        
        <div class="clear"></div>
        <div class="row" style="margin-top: 10px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo mayusculas(traducir("asambleas.propuesta")); ?></h3>
            </div>
        </div>
        <br>
      

        <div class="clear"></div>
        <div class="row"  style="">
            <div class="col" style="width: 100%; font-size: 16px !important; text-align: center;">
                <label for="">{{ traducir("asambleas.delegados_conferencia_reunidos") }} <strong>{{ $propuesta[0]->asamblea_fecha_inicio }} - {{ $propuesta[0]->asamblea_fecha_fin }}</strong>, {{ traducir("asambleas.en") }} <strong> {{ $propuesta[0]->asamblea_ciudad }}, {{ $propuesta[0]->pais }}</strong> </label>
            </div>
          
        </div>
        <br>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ mayusculas(traducir("asambleas.titulo")) }}: </label>
            </div>
            <div class="col" style="width: 90%;">
                <label for="">{{ $propuesta[0]->tpt_titulo }}</label>
            </div>
          
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ mayusculas(traducir("asambleas.de")) }}: </label>
            </div>
            <div class="col" style="width: 50%;">
                <label for="">{{ $propuesta[0]->lugar }}</label>
            </div>
            <div class="col" style="width: 40%;">
                <label for="">(X) {{ $propuesta[0]->tipconv_descripcion }}</label>
            </div>
          
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 50%;">
                <label for="">{{ mayusculas(traducir("asambleas.email_oficial_de_la")) }} {{ mayusculas($propuesta[0]->tipconv_descripcion) }}: </label>
            </div>
            <div class="col" style="width: 50%;">
                <label for="">{{ $propuesta[0]->pt_email }}</label>
            </div>
           
          
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="">{{ mayusculas(traducir("asambleas.pais_sede")) }}: </label>
            </div>
            <div class="col" style="width: 65%;">
                <label for="">{{ $propuesta[0]->pais }}</label>
            </div>
           
          
        </div>
        <br>

        <div class="clear"></div>
        <div class="row" style="text-align: justify;">
            <div class="col" style="width: 95%; margin-left:5%;">
                <label for="">{{ mayusculas(traducir("asambleas.certificacion_propuestas_asociaciones_uniones")) }}:
               
                </label>
               
            </div>
        </div>
        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 95%; margin-left:5%; text-align: justify;">
                <label for="" >
                    {{ traducir("asambleas.cpau_oracion_1") }} <strong>{{ $propuesta[0]->pt_votos_si_uya }} </strong>
                    {{ traducir("asambleas.si") }}, <strong>{{ $propuesta[0]->pt_votos_no_uya }}</strong>
                    {{ traducir("asambleas.no") }} {{ traducir("asambleas.y") }} <strong>{{ $propuesta[0]->pt_abstenciones_uya }}</strong> {{ traducir("asambleas.cpau_oracion_2") }}
                    <strong>{{ $propuesta[0]->pt_fecha_reunion_uya }}</strong> {{ traducir("asambleas.cpau_oracion_3") }} <strong>{{ $propuesta[0]->responsable }}</strong> {{ traducir("asambleas.cpau_oracion_4") }}
                </label>
            </div>
        
        </div>
        <br><br><br>
        <div class="clear"></div>
        <div class="row" style="text-align: justify;">
            <div class="col" style="width: 95%; margin-left:5%;">
                <label for="">{{ mayusculas(traducir("asambleas.certificacion_propuestas_comite_plenario_asociacion_general")) }}:
               
                </label>
               
            </div>
        </div>
        <br>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 95%; margin-left:5%; text-align: justify;">
                <label for="" >
                    {{ traducir("asambleas.cpau_oracion_1") }} <strong>{{ $propuesta[0]->pt_votos_si_cpag }} </strong>
                    {{ traducir("asambleas.si") }}, <strong>{{ $propuesta[0]->pt_votos_no_uya }}</strong>
                    {{ traducir("asambleas.no") }} {{ traducir("asambleas.y") }} <strong>{{ $propuesta[0]->pt_abstenciones_cpag }}</strong> {{ traducir("asambleas.cpcpag_oracion_2") }}
                    <strong>{{ $propuesta[0]->pt_fecha_reunion_cpag }}</strong>
                </label>
            </div>
        
        </div>
        <br><br>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <label for="" >{{ mayusculas(traducir("asambleas.categoria_propuesta")) }}</label>
            </div>
        
        </div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <?php 
                    
                    foreach ($categorias as $kc => $vc) {
                        if($vc->cp_id == $propuesta[0]->cp_id) {
                            echo '<label for="" >(X) '.$vc->cp_descripcion;

                            if($vc->cp_id == 8) {
                                echo ", ".$propuesta[0]->tpt_detalle_otros_asuntos.'</label>';
                            } else {
                                echo '</label>';
                            }
                            echo '<br>';
                        } else {
                            echo '<label for="" >( ) '.$vc->cp_descripcion.'</label><br>';
                        }

                        
                    
                    }
                            
                ?>
               
            </div>
        
        </div>
      

        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ mayusculas(traducir("asambleas.propuesta")) }}: {{ $propuesta[0]->tpt_propuesta }}</label>
            </div>
        
        </div>
        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ mayusculas(traducir("asambleas.ventajas_desventajas_propuesta")) }}: {{ $propuesta[0]->tpt_ventas_desventajas }}</label>
            </div>
        
        </div>
        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ mayusculas(traducir("asambleas.justificacion_propuesta")) }}: </label>
            </div>
        
        </div>
        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ mayusculas(traducir("asambleas.documentos_apoyo_propuesta")) }}: </label>
            </div>
        
        </div>

        <div class="row" style="">
            <div class="col" style="width: 95%; margin-left:5%; text-align: justify;">
                <label for="">(<?php echo ($propuesta[0]->pt_documentos_apoyo == 1) ? 'X' : ' '; ?>) {{ traducir("asambleas.no_presentaran_otros_documentos") }}</label><br>
                <label for="">(<?php echo ($propuesta[0]->pt_documentos_apoyo == 2) ? 'X' : ' '; ?>) {{ traducir("asambleas.si_enviar_documentos_adicionales") }}</label>
            </div>
        
        </div>
        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ mayusculas(traducir("asambleas.descripcion_documentos_apoyo")) }}: {{ $propuesta[0]->tpt_descripcion_documentos_apoyo }}</label>
            </div>
        
        </div>
        
        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ mayusculas(traducir("traductor.comentarios_")) }}: {{ $propuesta[0]->tpt_comentarios }}</label>
            </div>
        
        </div>
       
        
        <div class="clear"></div>
        <br><br><br><br>
        <div class="row" style="">
            <div class="col" style="width: 49%; border-top: 1px solid black; text-align: center;">
                <label for="" >{{ traducir("asambleas.nombres_letras_presidente") }}</label>
            </div>

            <div class="col" style="width: 2%;"></div>

            <div class="col" style="width: 49%; border-top: 1px solid black; text-align: center;">
                <label for="" >{{ traducir("asambleas.nombres_letras_secretario") }}</label>
            </div>
        
        </div>
        <div class="clear"></div>
        <br><br><br><br>
        <div class="row" style="">
            <div class="col" style="width: 49%; border-top: 1px solid black; text-align: center;">
                <label for="" >{{ traducir("asambleas.email_presidente") }}</label>
            </div>
            <div class="col" style="width: 2%;"></div>
            <div class="col" style="width: 49%; border-top: 1px solid black; text-align: center;">
                <label for="" >{{ traducir("asambleas.email_secretario") }}</label>
            </div>
        
        </div>
        <div class="clear"></div>
        <br><br><br><br>
        <div class="row" style="">
            <div class="col" style="width: 49%; border-top: 1px solid black; text-align: center;">
                <label for="" >{{ traducir("asambleas.fecha_firma") }}</label>
            </div>
            <div class="col" style="width: 2%;"></div>

            <div class="col" style="width: 49%; border-top: 1px solid black; text-align: center;">
                <label for="" >{{ traducir("asambleas.fecha_firma") }}</label>
            </div>
        
        </div>

        <div class="clear"></div>
        <br><br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label for="" >{{ traducir("asambleas.ultimo_parrafo_propuesta_tema_1") }}</label><br>
                <label for="" >{{ traducir("asambleas.ultimo_parrafo_propuesta_tema_2") }}</label><br><br>
                <label for="" >{{ traducir("asambleas.ultimo_parrafo_propuesta_tema_3") }}</label>
            </div>
          
        
        </div>

    </main>

</body>
</html>