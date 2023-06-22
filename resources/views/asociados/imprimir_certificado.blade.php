<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificado</title>
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
            height: 4cm;
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
        <div class="row" style="margin-top: 0px; margin-bottom: 10px; text-align: center; font-size: 20px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo mayusculas(traducir("asambleas.certificacion_delegado")); ?></h3>

            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-top: 0px; margin-bottom: 10px; text-align: center; font-size: 16px !important;">
            <div class="col" style="width: 100%;">

                <h4>{{ $miembro[0]->asamblea_descripcion }}</h4>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important;">
                <label> {{ mayusculas(traducir("asambleas.para_delegados_asociaciones_uniones")) }}</label>
            </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <?php
                    $date = explode("/", $miembro[0]->asamblea_fecha_inicio);
                    $meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
                    $date_fin = explode("/", $miembro[0]->asamblea_fecha_fin);
                    $dia_inicio = $date[0];
                    $dia_fin = $date_fin[0];

                    if(session("idioma_codigo") == "en") {
                        $date = explode("-", $miembro[0]->asamblea_fecha_inicio);
                        $date_fin = explode("-", $miembro[0]->asamblea_fecha_fin);
                        $dia_inicio = $date[count($date) - 1];
                        $dia_fin = $date_fin[count($date_fin) - 1];
                    }
                    print_r(session("idioma_codigo"));
                    echo "<pre>";
                    print_r($date);
                    print_r($date_fin);
                    print_r($dia_inicio);
                    print_r($dia_fin);
                     exit;
                ?>
                <label> {{ traducir("asambleas.abajo_firmantes_asociaciones_uniones") }} _________________ {{ traducir("asambleas.por_la_presente") }} {{ $miembro[0]->asamblea_descripcion }} {{ traducir("asambleas.del_anio") }} {{ $miembro[0]->asamblea_anio }} {{ traducir("asambleas.a_realizarse_en") }} {{ $miembro[0]->asamblea_ciudad }}, {{ $miembro[0]->pais }} {{ traducir("asambleas.del") }} <?php echo $dia_inicio; ?> {{ traducir("asambleas.al") }} <?php echo $dia_fin; ?> {{ traducir("asambleas.de_") }} <?php echo $meses[$date_fin[1]-1]; ?> {{ traducir("asambleas.de_") }} {{ $miembro[0]->asamblea_anio }} {{ traducir("asambleas.a_esta_asociacion_union") }} </label>
            </div>

        </div>


        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important;">
                <label> {{ mayusculas(traducir("asambleas.para_delegados_asociacion_general")) }}</label>
            </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label> {{ traducir("asambleas.abajo_firmantes_asociacion_general") }} {{ $miembro[0]->asamblea_descripcion }} {{ traducir("asambleas.del_anio") }} {{ $miembro[0]->asamblea_anio }} {{ traducir("asambleas.a_realizarse_en") }} {{ $miembro[0]->asamblea_ciudad }}, {{ $miembro[0]->pais }} {{ traducir("asambleas.del") }}  <?php echo $date[0]; ?> {{ traducir("asambleas.al") }} <?php echo $date_fin[0]; ?> {{ traducir("asambleas.de_") }} <?php echo $meses[$date_fin[1]-1]; ?> {{ traducir("asambleas.de_") }} {{ $miembro[0]->asamblea_anio }}</label>
            </div>

        </div>


        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label> {{ traducir("asambleas.nombre_representante_asociacion_general") }} ________________________________</label>
            </div>

        </div>
        <div class="clear"></div>

        <div class="row" style="">
            <div class="col" style="width: 100%; text-align: justify;">
                <label> {{ traducir("asambleas.fecha_eleccion") }} ________________________________{{ traducir("asambleas.lugar_eleccion") }} ________________________________</label>
            </div>

        </div>


        <div class="clear"></div>
        <br><br>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label> {{ traducir("asambleas.apellidos_delegado") }} {{ $miembro[0]->apellidos }}</label>
           </div>

        </div>
        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label> {{ traducir("asambleas.nombres_delegado") }} {{ $miembro[0]->nombres }}</label>
           </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>[ ] Hombre [ ] Mujer [ ] Delegado [ ] Suplente [ ] Delegado del Comité Plenario de la Asociación General</label>
           </div>
        </div>

        <?php
            $suplentes = 0;
            $total = 0;
            foreach ($totales as $key => $value) {
                if($value->delegado_tipo == 'S') {
                    $suplentes = $value->total;
                }
                $total += $value->total;
            }
        ?>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.total_delegados_dela") }} {{ $miembro[0]->tipconv_descripcion }}: {{ $total }}</label>
           </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.total_suplentes_dela") }} {{ $miembro[0]->tipconv_descripcion }}: {{ $suplentes }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.correo_delegado") }}: {{ $miembro[0]->email }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.celular_delegado") }}: {{ $miembro[0]->celular }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.wsp_delegado") }}: {{ $miembro[0]->celular }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.direccion_delegado") }}: {{ $miembro[0]->direccion }}</label>
           </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.ciudad_pais") }}: {{ $miembro[0]->ciudadnacextranjero }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("traductor.fecha_nacimiento") }}: {{ $miembro[0]->fechanacimiento }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.ciudadania_pais") }}: {{ $miembro[0]->pais_ciudadania }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.pasaporte") }}: {{ $miembro[0]->nropasaporte }}</label>
           </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.fecha_emision") }}: {{ $miembro[0]->fecha_emision_pasaporte }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.fecha_expiracion") }}: {{ $miembro[0]->fecha_vencimiento_pasaporte }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.expedido_por") }}: {{ $miembro[0]->pasaporte_expedido_por }}</label>
           </div>

        </div>



        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.estado_pasaporte") }}: {{ $miembro[0]->estado_pasaporte }}</label>
           </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("traductor.estado_civil") }}: {{ $miembro[0]->estado_civil }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.edades_hijos") }}: </label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important;">
                <label> {{ mayusculas(traducir("traductor.titulo_curriculum")) }}</label>
            </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.lengua_materna") }}: </label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.idiomas_adicionales") }}: {{ $miembro[0]->idiomas }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.miembro_smi_desde") }}: {{ $miembro[0]->anio_ingreso }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.miembro_iglesia") }}: {{ $miembro[0]->iglesia }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.consagrado_smi") }}: </label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.anio_consagracion") }}: </label>
           </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.profesion_cargo_actual") }}: {{ $miembro[0]->ocupacion }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.nombre_empleador") }}: </label>
           </div>
        </div>


        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.empeado_desde") }}: </label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.direccion_empleador") }}: </label>
           </div>
        </div>



        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.ocupaciones_adicionales") }}: {{ $miembro[0]->ocupacion }}</label>
           </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.nivel_educacion_alto") }}: {{ $miembro[0]->educacion }}</label>
           </div>

        </div>

        <div class="clear"></div>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.grado_alto") }}: </label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.areas_estudio") }}: </label>
           </div>
        </div>


        <div class="clear"></div>
        <br>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.recientes_cargos") }}: {{ $miembro[0]->tipconv_descripcion }} {{ traducir("asambleas.dentro_smi") }}:</label>
           </div>

        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%; font-weight: bold;">
                <label for="">{{ traducir("asambleas.nivel_organizativo") }}</label>
            </div>
            <div class="col" style="width: 50%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.cargo") }}</label>
            </div>
            <div class="col" style="width: 25%; font-weight: bold;"">
                <label for="">{{ traducir("asambleas.anios") }}</label>
            </div>


        </div>

        <?php
            foreach ($cargos as $kc => $vc) {
                echo '<div class="clear"></div>
                        <div class="row" style="">
                            <div class="col" style="width: 25%;">
                                <label for="">'.$vc->nivel.'</label>
                            </div>
                            <div class="col" style="width: 50%;"">
                                <label for="">'.$vc->cargo.'</label>
                            </div>
                            <div class="col" style="width: 25%;"">
                                <label for="">'.$vc->anios.'</label>
                            </div>
                        </div>';
            }

        ?>

        <div class="clear"></div>
        <br>
        <div class="row" style="">
           <div class="col" style="width: 100%; text-align: justify;">
               <label>{{ traducir("asambleas.texto_covid_certificado_delegado_1") }}</label><br>
               <label>{{ traducir("asambleas.texto_covid_certificado_delegado_2") }}</label><br>
               <label>{{ traducir("asambleas.texto_covid_certificado_delegado_3") }}</label><br>
               <label>{{ traducir("asambleas.texto_covid_certificado_delegado_4") }}</label><br>
               <label>{{ traducir("asambleas.texto_covid_certificado_delegado_5") }}</label><br>
               <label>{{ traducir("asambleas.texto_covid_certificado_delegado_6") }}</label><br>
           </div>

        </div>

        <div class="clear"></div>
        <br>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label><strong>{{ traducir("asambleas.adjunte_informacion") }}:</strong> </label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.pasaporte_vigente") }}</label>
           </div>
        </div>


        <div class="clear"></div>
        <br>
        <div class="row" style="">
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.certificacion_emitida") }}: {{ $miembro[0]->delegado_fecha }}</label>
           </div>
           <div class="col" style="width: 50%; text-align: justify;">
               <label>{{ traducir("asambleas.en_lugar") }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <br><br><br><br>
        <div class="row" style="">
           <div class="col" style="width: 48%; text-align: justify; border-top: 1px dashed black;">
               <label>{{ traducir("asambleas.nombre_letras_presidente") }}</label>
           </div>
           <div class="col"  style="width: 4%;"></div>
           <div class="col" style="width: 48%; text-align: justify; border-top: 1px dashed black;">
               <label>{{ traducir("asambleas.nombre_letras_secretario") }}</label>
           </div>
        </div>

        <div class="clear"></div>
        <br><br><br><br>
        <div class="row" style="">
           <div class="col" style="width: 48%; text-align: justify; border-top: 1px dashed black;">
               <label>{{ traducir("traductor.firma_presidente") }}</label>
           </div>
           <div class="col"  style="width: 4%;"></div>
           <div class="col" style="width: 48%; text-align: justify; border-top: 1px dashed black;">
               <label>{{ traducir("traductor.firma_secretario") }}</label>
           </div>
        </div>

        <br><br><br><br>
        <div class="row" style="">
           <div class="col" style="width: 48%; text-align: justify; border-top: 1px dashed black;">
               <label>{{ traducir("asambleas.correo_presidente") }}</label>
           </div>
           <div class="col"  style="width: 4%;"></div>
           <div class="col" style="width: 48%; text-align: justify; border-top: 1px dashed black;">
               <label>{{ traducir("asambleas.correo_secretario") }}</label>
           </div>
        </div>


        <div class="clear"></div>
        <br>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important;">
                <label> {{ mayusculas(traducir("asambleas.revision_envio")) }}</label>
            </div>

        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <label> {{ traducir("asambleas.revision_envio_1") }}</label>
            </div>

        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <label> {{ traducir("asambleas.revision_envio_2") }}</label>
            </div>

        </div>
        <div class="clear"></div>
        <br><br>
        <div class="row" style="">
            <div class="col" style="width: 88%;">
                <label for=""></label>

            </div>

            <div class="col" style="width: 12%; text-align: center">
                <label for=""><strong>{{ fecha_actual_idioma() }}</strong></label><br>

            </div>
        </div>




    </main>

</body>
</html>
