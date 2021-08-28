<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informe Semestral de Secretaria</title>
    <style>

        /* referencia: https://ourcodeworld.co/articulos/leer/687/como-configurar-un-encabezado-y-pie-de-pagina-en-dompdf */
        @page {
            margin: 0cm 0cm;
        }

        /** Defina ahora los márgenes reales de cada página en el PDF **/
        body {
            margin-top: 4.4cm;
            margin-left: 0.5cm;
            margin-right: 0.5cm;
            margin-bottom: 2cm;
        }
            
        header {
            position: fixed;
            top: 0.9cm;
            left: 2cm;
            right: 2cm;
            height: 4.4cm;
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
                <h3><?php echo mayusculas(traducir("traductor.titulo_informe_semestral")); ?></h3>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.nombre_union") }}</label>
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
            <div class="col" style="width: 80%;">
                <label for=""></label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ $semestre }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 12px !important; font-weight: bold;">
                <label for="">I. {{ mayusculas(traducir("traductor.feligresia")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th rowspan="2">{{ traducir("traductor.nombre_asociacion") }}</th>
                            <th rowspan="2">{{ traducir("traductor.numero_iglesias_asociacion") }}</th>
                            <th rowspan="2">{{ traducir("traductor.feligresia_ultimo_informe") }}</th>
                            <th colspan="3">{{ traducir("traductor.aumento") }}</th>
                            <th colspan="4">{{ traducir("traductor.disminucion") }}</th>
                            <th rowspan="2">{{ traducir("traductor.feligresia_actual") }}</th>
                            <th rowspan="2">{{ traducir("traductor.almas_interesadas") }}</th>
                        </tr>
                        <tr>
                            <th >{{ traducir("traductor.bautismos") }}</th>
                            <th >{{ traducir("traductor.recibimientos") }}</th>
                            <th >{{ traducir("traductor.traslados_positivos") }}</th>
                            <th>{{ traducir("traductor.muertes") }}</th>
                            <th>{{ traducir("traductor.renuncias") }}</th>
                            <th >{{ traducir("traductor.exclusiones") }}</th>
                            <th >{{ traducir("traductor.traslados_negativos") }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 

                            $iglesias = 0;
                            $feligresia_anterior = 0;
                            $bautismos = 0;
                            $recibimientos = 0;
                            $traslados_positivos = 0;
                            $muertes = 0;
                            $renuncias = 0;
                            $exclusiones = 0;
                            $traslados_negativos = 0;
                            $feligresia_actual = 0;
                            $almas_interesadas = 0;
                            foreach ($misiones as $key => $value) {
                                echo '<tr>';
                                echo '  <td >'.$value->descripcion.'</td>';
                                echo '  <td align="center">'.$value->iglesias.'</td>';
                                echo '  <td align="center">'.$value->feligresia_anterior.'</td>';
                                echo '  <td align="center">'.$value->bautismos.'</td>';
                                echo '  <td align="center">'.$value->recibimientos.'</td>';
                                echo '  <td align="center">'.$value->traslados_positivos.'</td>';
                                echo '  <td align="center">'.$value->muertes.'</td>';
                                echo '  <td align="center">'.$value->renuncias.'</td>';
                                echo '  <td align="center">'.$value->exclusiones.'</td>';
                                echo '  <td align="center">'.$value->traslados_negativos.'</td>';
                                echo '  <td align="center">'.$value->feligresia_actual.'</td>';
                                echo '  <td align="center">'.$value->almas_interesadas.'</td>';
                                echo '</tr>';

                                $iglesias += intval($value->iglesias);
                                $feligresia_anterior += intval($value->feligresia_anterior);
                                $bautismos += intval($value->bautismos);
                                $recibimientos += intval($value->recibimientos);
                                $traslados_positivos += intval($value->traslados_positivos);
                                $muertes += intval($value->muertes);
                                $renuncias += intval($value->renuncias);
                                $exclusiones += intval($value->exclusiones);
                                $traslados_negativos += intval($value->traslados_negativos);
                                $feligresia_actual += intval($value->feligresia_actual);
                                $almas_interesadas += intval($value->almas_interesadas);
                            }

                            echo '<tr>';
                            echo '  <td >'.traducir("traductor.total").'</td>';
                            echo '  <td align="center">'.$iglesias.'</td>';
                            echo '  <td align="center">'.$feligresia_anterior.'</td>';
                            echo '  <td align="center">'.$bautismos.'</td>';
                            echo '  <td align="center">'.$recibimientos.'</td>';
                            echo '  <td align="center">'.$traslados_positivos.'</td>';
                            echo '  <td align="center">'.$muertes.'</td>';
                            echo '  <td align="center">'.$renuncias.'</td>';
                            echo '  <td align="center">'.$exclusiones.'</td>';
                            echo '  <td align="center">'.$traslados_negativos.'</td>';
                            echo '  <td align="center">'.$feligresia_actual.'</td>';
                            echo '  <td align="center">'.$almas_interesadas.'</td>';
                            echo '</tr>';

                        ?>
                    </tbody>
                </table>
            </div>
        </div>



        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 12px !important; font-weight: bold;">
                <label for="">II. {{ mayusculas(traducir("traductor.obreros")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th rowspan="2">{{ traducir("traductor.nombre_asociacion") }}</th>
                            <th colspan="2">{{ traducir("traductor.ministros") }}</th>
                            <th colspan="2">{{ traducir("traductor.obreros_biblicos") }}</th>
                            <th colspan="2">{{ traducir("traductor.empleados_oficina") }}</th>
                            <th colspan="2">{{ traducir("traductor.colportores") }}</th>
                            <th rowspan="2">{{ traducir("traductor.ancianos_consagrados") }}</th>
                            <th rowspan="2">{{ traducir("traductor.total") }}</th>
                        </tr>
                        <tr>
                            <th >{{ traducir("traductor.remunerados") }}</th>
                            <th >{{ traducir("traductor.no_remunerados") }}</th>
                            <th >{{ traducir("traductor.remunerados") }}</th>
                            <th>{{ traducir("traductor.no_remunerados") }}</th>
                            <th>{{ traducir("traductor.remunerados") }}</th>
                            <th >{{ traducir("traductor.no_remunerados") }}</th>
                            <th >{{ traducir("traductor.tiempo_completo") }}</th>
                            <th >{{ traducir("traductor.tiempo_parcial") }}</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php 

                        $ministros_r = 0;
                        $ministros_nr = 0;
                        $obreros_r = 0;
                        $obreros_nr = 0;
                        $empleados_r = 0;
                        $empleados_nr = 0;
                        $colportores_c = 0;
                        $colportores_p = 0;
                        $ancianos = 0;
                        $feligresia_actual = 0;
                        $almas_interesadas = 0;
                        $total = 0;
                        foreach ($misiones as $key => $value) {
                            $ministros_r += intval($value->ministros_r);
                            $ministros_nr += intval($value->ministros_nr);
                            $obreros_r += intval($value->obreros_r);
                            $obreros_nr += intval($value->obreros_nr);
                            $empleados_r += intval($value->empleados_r);
                            $empleados_nr += intval($value->empleados_nr);
                            $colportores_c += intval($value->colportores_c);
                            $colportores_p += intval($value->colportores_p);
                            $ancianos += intval($value->ancianos);

                            $total += $ministros_r + $ministros_nr + $obreros_r + $obreros_nr + $empleados_r + $empleados_nr + $colportores_c + $colportores_p + $ancianos;

                            echo '<tr>';
                            echo '  <td >'.$value->descripcion.'</td>';
                            echo '  <td align="center">'.$value->ministros_r.'</td>';
                            echo '  <td align="center">'.$value->ministros_nr.'</td>';
                            echo '  <td align="center">'.$value->obreros_r.'</td>';
                            echo '  <td align="center">'.$value->obreros_nr.'</td>';
                            echo '  <td align="center">'.$value->empleados_r.'</td>';
                            echo '  <td align="center">'.$value->empleados_nr.'</td>';
                            echo '  <td align="center">'.$value->colportores_c.'</td>';
                            echo '  <td align="center">'.$value->colportores_p.'</td>';
                            echo '  <td align="center">'.$value->ancianos.'</td>';
                            echo '  <td align="center">'.$total.'</td>';
                  
                            echo '</tr>';

                          
                           
                        }

                        echo '<tr>';
                        echo '  <td >'.traducir("traductor.total").'</td>';
                        echo '  <td align="center">'.$ministros_r.'</td>';
                        echo '  <td align="center">'.$ministros_nr.'</td>';
                        echo '  <td align="center">'.$obreros_r.'</td>';
                        echo '  <td align="center">'.$obreros_nr.'</td>';
                        echo '  <td align="center">'.$empleados_r.'</td>';
                        echo '  <td align="center">'.$empleados_nr.'</td>';
                        echo '  <td align="center">'.$colportores_c.'</td>';
                        echo '  <td align="center">'.$colportores_p.'</td>';
                        echo '  <td align="center">'.$ancianos.'</td>';
                        echo '  <td align="center">'.$total.'</td>';
          
                        echo '</tr>';

                    ?>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 12px !important; font-weight: bold;">
                <label for="">III. {{ mayusculas(traducir("traductor.actividades")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th rowspan="2">{{ traducir("traductor.nombre_asociacion") }}</th>
                            <th rowspan="2">{{ traducir("traductor.estudios_biblicos") }}</th>
                            <th rowspan="2">{{ traducir("traductor.visitas_misioneras") }}</th>
                            <th rowspan="2">{{ traducir("traductor.conferencias_publicas") }}</th>
                            <th rowspan="2">{{ traducir("traductor.seminarios") }}</th>
                            <th rowspan="2">{{ traducir("traductor.congresos") }}</th>
                            <th colspan="3">{{ traducir("traductor.distribucion_externa") }}</th>
                            <th colspan="3">{{ traducir("traductor.distribucion_interna") }}</th>
                        </tr>
                        <tr>
                            <th >{{ traducir("traductor.libros") }}</th>
                            <th >{{ traducir("traductor.revistas") }}</th>
                            <th >{{ traducir("traductor.volantes") }}</th>
                            <th>{{ traducir("traductor.lecciones_esc_sab") }}</th>
                            <th>{{ traducir("traductor.guard_sab") }}</th>
                            <th >{{ traducir("traductor.ancla_juvenil") }}</th>
                           
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
                        foreach ($misiones as $key => $value) {
                            echo '<tr>';
                            echo '  <td >'.$value->descripcion.'</td>';
                            echo '  <td align="center">'.$value->estudios_biblicos.'</td>';
                            echo '  <td align="center">'.$value->visitas_misioneras.'</td>';
                            echo '  <td align="center">'.$value->conferencias_publicas.'</td>';
                            echo '  <td align="center">'.$value->seminarios.'</td>';
                            echo '  <td align="center">'.$value->congresos.'</td>';
                            echo '  <td align="center">'.$value->libros.'</td>';
                            echo '  <td align="center">'.$value->revistas.'</td>';
                            echo '  <td align="center">'.$value->volantes.'</td>';
                            echo '  <td align="center">'.$value->lecciones.'</td>';
                            echo '  <td align="center">'.$value->guard.'</td>';
                            echo '  <td align="center">'.$value->ancla_juvenil.'</td>';
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
                        echo '  <td >'.traducir("traductor.total").'</td>';
                        echo '  <td align="center">'.$estudios_biblicos.'</td>';
                        echo '  <td align="center">'.$visitas_misioneras.'</td>';
                        echo '  <td align="center">'.$conferencias_publicas.'</td>';
                        echo '  <td align="center">'.$seminarios.'</td>';
                        echo '  <td align="center">'.$congresos.'</td>';
                        echo '  <td align="center">'.$libros.'</td>';
                        echo '  <td align="center">'.$revistas.'</td>';
                        echo '  <td align="center">'.$volantes.'</td>';
                        echo '  <td align="center">'.$lecciones.'</td>';
                        echo '  <td align="center">'.$guard.'</td>';
                        echo '  <td align="center">'.$ancla_juvenil.'</td>';
                        echo '</tr>';

                    ?>
                    </tbody>
                </table>
            </div>
        </div>


        

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 50%; font-size: 12px !important; font-weight: bold;">
                <label for="">IV. {{ mayusculas(traducir("traductor.estimado_almas_interesadas_feligresia_juvenil")) }}</label>
            </div> 
            <div class="col" style="width: 50%; font-size: 12px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.actividades_juveniles")) }}</label>
            </div> 
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 50%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th rowspan="2">{{ traducir("traductor.nombre_asociacion") }}</th>
                            <th colspan="3">{{ traducir("traductor.almas_interesadas") }}</th>
                            <th colspan="2">{{ traducir("traductor.miembros") }}</th>
                          
                        </tr>
                        <tr>
                            <th >0-12</th>
                            <th >13-19</th>
                            <th >20-30</th>
                            <th>{{ traducir("traductor.hasta") }} 19</th>
                            <th>20-30</th>
                           
                        </tr>
                    </thead>
                    <tbody>
                    <?php 

                        $almas_0_12 = 0;
                        $almas_13_19 = 0;
                        $almas_20_30 = 0;
                        $miembros_19 = 0;
                        $miembros_20_30 = 0;
                  
                        foreach ($misiones as $key => $value) {
                            echo '<tr>';
                            echo '  <td >'.$value->descripcion.'</td>';
                            echo '  <td align="center">'.$value->almas_0_12.'</td>';
                            echo '  <td align="center">'.$value->almas_13_19.'</td>';
                            echo '  <td align="center">'.$value->almas_20_30.'</td>';
                            echo '  <td align="center">'.$value->miembros_19.'</td>';
                            echo '  <td align="center">'.$value->miembros_20_30.'</td>';
                     
                            echo '</tr>';

                            $almas_0_12 += intval($value->almas_0_12);
                            $almas_13_19 += intval($value->almas_13_19);
                            $almas_20_30 += intval($value->almas_20_30);
                            $miembros_19 += intval($value->miembros_19);
                            $miembros_20_30 += intval($value->miembros_20_30);
                      
                        }

                        echo '<tr>';
                        echo '  <td >'.traducir("traductor.total").'</td>';
                        echo '  <td align="center">'.$almas_0_12.'</td>';
                        echo '  <td align="center">'.$almas_13_19.'</td>';
                        echo '  <td align="center">'.$almas_20_30.'</td>';
                        echo '  <td align="center">'.$miembros_19.'</td>';
                        echo '  <td align="center">'.$miembros_20_30.'</td>';
                   
                        echo '</tr>';

                    ?>
                    </tbody>
                </table>
            </div>
            <div class="col" style="width: 50%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th >{{ traducir("traductor.reuniones_juveniles") }}</th>
                            <th >{{ traducir("traductor.sabados_juveniles") }}</th>
                            <th >{{ traducir("traductor.fines_semana_juveniles") }}</th>
                            <th >{{ traducir("traductor.seminarios_juveniles") }}</th>
                            <th >{{ traducir("traductor.congresos_juveniles") }}</th>
                          
                        </tr>
                  
                    </thead>
                    <tbody>
                        <?php 
                            $reuniones_juveniles = 0;
                            $sabados_juveniles = 0;
                            $semanas_juveniles = 0;
                            $seminarios_juveniles = 0;
                            $congresos_juveniles = 0;
                      
                            foreach ($misiones as $key => $value) {
                                echo '<tr>';
                                // echo '  <td >'.$value->descripcion.'</td>';
                                echo '  <td align="center">'.$value->reuniones_juveniles.'</td>';
                                echo '  <td align="center">'.$value->sabados_juveniles.'</td>';
                                echo '  <td align="center">'.$value->semanas_juveniles.'</td>';
                                echo '  <td align="center">'.$value->seminarios_juveniles.'</td>';
                                echo '  <td align="center">'.$value->congresos_juveniles.'</td>';
                         
                                echo '</tr>';
    
                                $reuniones_juveniles += intval($value->reuniones_juveniles);
                                $sabados_juveniles += intval($value->sabados_juveniles);
                                $semanas_juveniles += intval($value->semanas_juveniles);
                                $seminarios_juveniles += intval($value->seminarios_juveniles);
                                $congresos_juveniles += intval($value->congresos_juveniles);
                          
                            }
    
                            echo '<tr>';
                            // echo '  <td >'.traducir("traductor.total").'</td>';
                            echo '  <td align="center">'.$reuniones_juveniles.'</td>';
                            echo '  <td align="center">'.$sabados_juveniles.'</td>';
                            echo '  <td align="center">'.$semanas_juveniles.'</td>';
                            echo '  <td align="center">'.$seminarios_juveniles.'</td>';
                            echo '  <td align="center">'.$congresos_juveniles.'</td>';
                       
                            echo '</tr>';
    
                        ?>
                    </tbody>
                </table>
            </div>
        </div>


        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 12px !important; font-weight: bold;">
                <label for="">V. {{ mayusculas(traducir("traductor.edificaciones")) }}</label>
            </div> 
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th >{{ traducir("traductor.nombre_asociacion") }}</th>
                            <th >{{ traducir("traductor.iglesias") }}</th>
                            <th >{{ traducir("traductor.oficinas") }}</th>
                            <th >{{ traducir("traductor.casas") }}</th>
                            <th >{{ traducir("traductor.apartamentos") }}</th>
                            <th >{{ traducir("traductor.escuelas") }}</th>
                            <th >{{ traducir("traductor.centros_salud") }}</th>
                            <th >{{ traducir("traductor.editoriales") }}</th>
                        </tr>
                       
                    </thead>
                    <tbody>
                        <?php 
                       
                            $iglesias = 0;
                            $oficinas = 0;
                            $casas = 0;
                            $apartamentos = 0;
                            $escuelas = 0;
                            $centros_salud = 0;
                            $editoriales = 0;
                      
                            foreach ($misiones as $key => $value) {
                                echo '<tr>';
                                // echo '  <td >'.$value->descripcion.'</td>';
                                echo '  <td>'.$value->descripcion.'</td>';
                                echo '  <td align="center">'.$value->iglesias.'</td>';
                                echo '  <td align="center">'.$value->oficinas.'</td>';
                                echo '  <td align="center">'.$value->casas.'</td>';
                                echo '  <td align="center">'.$value->apartamentos.'</td>';
                                echo '  <td align="center">'.$value->escuelas.'</td>';
                                echo '  <td align="center">'.$value->centros_salud.'</td>';
                                echo '  <td align="center">'.$value->editoriales.'</td>';
                         
                                echo '</tr>';
    
                                $reuniones_juveniles += intval($value->reuniones_juveniles);
                                $iglesias += intval($value->iglesias);
                                $oficinas += intval($value->oficinas);
                                $casas += intval($value->casas);
                                $apartamentos += intval($value->apartamentos);
                                $escuelas += intval($value->escuelas);
                                $centros_salud += intval($value->centros_salud);
                                $editoriales += intval($value->editoriales);
                          
                            }
    
                            echo '<tr>';
                            echo '  <td >'.traducir("traductor.total").'</td>';
                            echo '  <td align="center">'.$iglesias.'</td>';
                            echo '  <td align="center">'.$oficinas.'</td>';
                            echo '  <td align="center">'.$casas.'</td>';
                            echo '  <td align="center">'.$apartamentos.'</td>';
                            echo '  <td align="center">'.$escuelas.'</td>';
                            echo '  <td align="center">'.$centros_salud.'</td>';
                            echo '  <td align="center">'.$editoriales.'</td>';
                       
                            echo '</tr>';
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 12px !important; font-weight: bold;">
                <label for="">VI. {{ mayusculas(traducir("traductor.instituciones")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th >{{ traducir("traductor.nombre_asociacion") }}</th>
                            <th >{{ traducir("traductor.distrito") }}</th>
                            <th >{{ traducir("traductor.descripcion") }}</th>
                          
                        </tr>
                       
                    </thead>
                    <tbody>
                        <?php 
                            foreach ($instituciones as $key => $value) {
                                echo '<tr>';
                                // echo '  <td >'.$value->descripcion.'</td>';
                                echo '  <td>'.$value->descripcion.'</td>';
                                echo '  <td align="center">'.$value->distrito_misionero.'</td>';
                                echo '  <td align="center">'.$value->tipo.'</td>';
                              
                         
                                echo '</tr>';
    
                               
                          
                            }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 12px !important; font-weight: bold;">
                <label for="">VII. {{ mayusculas(traducir("traductor.otros")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 150px;">
            <div class="col" style="width: 100%;">
                <table border="1" style="width: 100%; margin-bottom: 25px;">
                    <thead>
                        <tr>
                            <th >{{ traducir("traductor.propiedad") }}</th>
                            <th >{{ traducir("traductor.distrito") }}</th>
                            <th >{{ traducir("traductor.cantidad") }}</th>
                            <th >{{ traducir("traductor.descripcion") }}</th>
                          
                        </tr>
                       
                    </thead>
                    <tbody>
                        <?php 
                            foreach ($otras as $key => $value) {
                                echo '<tr>';
                                // echo '  <td >'.$value->descripcion.'</td>';
                                echo '  <td>'.$value->tipo.'</td>';
                                echo '  <td align="center">'.$value->distrito_misionero.'</td>';
                                echo '  <td align="center">'.$value->cantidad  .'</td>';
                                echo '  <td align="center">'.$value->descripcion.'</td>';
                              
                         
                                echo '</tr>';
    
                               
                          
                            }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
        

        

        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 30%; text-align: center;">
                <label for=""><strong>{{ $nivel_organizativo }} &nbsp;&nbsp; {{ fecha_actual_idioma() }}</strong></label>
            </div>
        </div>
        <div class="clear"></div>
        
        <div class="row" style="">
            <div class="col" style="width: 30%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.lugar_fecha") }}</label>
            </div>

            <div class="col" style="width: 5%;">
                <label for=""></label>
            </div>

            <div class="col" style="width: 30%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_presidente_union") }}</label>
            </div>

            <div class="col" style="width: 5%;">
                <label for=""></label>
            </div>
            <div class="col" style="width: 30%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_secretario_union") }}</label>
            </div>
        </div>
        
   
      
    

    </main>
    
    
</body>
</html>