<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curriculun Vitae</title>
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
        <div class="row" style="margin-top: 0px; margin-bottom: 10px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo mayusculas(traducir("traductor.curriculum")); ?></h3>
            </div>
        </div>
    
        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important;">
            <div class="col" style="width: 100%; border: 1px solid black; background-color: #bfbfbf;">
                <h4>I. <?php echo mayusculas(traducir("traductor.datos_personales")); ?></h4>
            </div>
        
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.apellidos") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->apellidos }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.nombres") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->nombres }}</label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.sexo") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->sexo }}</label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.numero_documento") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->nrodoc }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.religion") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->religion }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->fechanacimiento }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.idiomas") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->idiomas }}</label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->email }}</label>
            </div>
        </div>
    
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->direccion }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%; font-weight: bold;">
                <label for="">{{ traducir("traductor.observacion") }}</label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->observaciones }}</label>
            </div>
        </div>
    
    


        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important;">
            <div class="col" style="width: 100%; border: 1px solid black; background-color: #bfbfbf;">
                <h4>II. <?php echo mayusculas(traducir("traductor.datos_bautizo")); ?></h4>
            </div>
        
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 20%; font-weight: bold;">
                <label for="">{{ traducir("traductor.pastor_oficiante") }}</label>
            </div>
            <div class="col" style="width: 30%;">
                <label for="">{{ $miembro[0]->bautizador }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;">
                <label for="">{{ traducir("traductor.fecha_bautizo") }}</label>
            </div>
            <div class="col" style="width: 30%;">
                <label for="">{{ $miembro[0]->fechabautizo }}</label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%; font-weight: bold;">
                <label for="">{{ traducir("traductor.observacion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">{{ $miembro[0]->observaciones_bautizo }}</label>
            </div>
        </div>
    

        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important;">
            <div class="col" style="width: 100%; border: 1px solid black; background-color: #bfbfbf;">
                <h4>III. <?php echo mayusculas(traducir("traductor.datos_familiares")); ?></h4>
            </div>
        
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%; font-weight: bold;">
                <label for="">{{ traducir("traductor.parentesco") }}</label>
            </div>
            <div class="col" style="width: 25%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.nombres") }}</label>
            </div>
            <div class="col" style="width: 17%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.doc_identidad") }}</label>
            </div>
            <div class="col" style="width: 16%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.fecha_nac") }}</label>
            </div>
            <div class="col" style="width: 12%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.pais") }}</label>
            </div>
            <div class="col" style="width: 15%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.lugar_nac") }}</label>
            </div>
        </div>
    
        <?php 
            foreach ($parentesco as $kp => $vp) {
                echo '<div class="clear"></div>
                        <div class="row" style="">
                            <div class="col" style="width: 15%;">
                                <label for="">'.$vp->parentesco.'</label>
                            </div>
                            <div class="col" style="width: 25%;"">
                                <label for="">'.$vp->nombres.'</label>
                            </div>
                            <div class="col" style="width: 17%;"">
                                <label for="">'.$vp->nrodoc.'</label>
                            </div>
                            <div class="col" style="width: 16%;"">
                                <label for="">'.$vp->fechanacimiento.'</label>
                            </div>
                            <div class="col" style="width: 12%;"">
                                <label for="">'.$vp->pais.'</label>
                            </div>
                            <div class="col" style="width: 15%;"">
                                <label for="">'.$vp->lugarnacimiento.'</label>
                            </div>
                        </div>';
            }
        
        ?>


        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important;">
            <div class="col" style="width: 100%; border: 1px solid black; background-color: #bfbfbf;">
                <h4>IV. <?php echo mayusculas(traducir("traductor.informacion_educacion")); ?></h4>
            </div>
        
        </div>
        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 20%; font-weight: bold;">
                <label for="">{{ traducir("traductor.institucion") }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.nivel_estudios") }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.profesion") }}</label>
            </div>
            <div class="col" style="width: 15%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.estado") }}</label>
            </div>
            <div class="col" style="width: 25%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.observacion") }}</label>
            </div>
        
        </div>
    
        <?php 
            foreach ($educacion as $ke => $ve) {
                echo '<div class="clear"></div>
                        <div class="row" style="">
                            <div class="col" style="width: 20%;">
                                <label for="">'.$ve->institucion.'</label>
                            </div>
                            <div class="col" style="width: 20%;"">
                                <label for="">'.$ve->nivelestudios.'</label>
                            </div>
                            <div class="col" style="width: 20%;"">
                                <label for="">'.$ve->profesion.'</label>
                            </div>
                            <div class="col" style="width: 15%;"">
                                <label for="">'.$ve->estado.'</label>
                            </div>
                            <div class="col" style="width: 25%;"">
                                <label for="">'.$ve->observacion.'</label>
                            </div>
                            
                        </div>';
            }
        
        ?>

        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important;">
            <div class="col" style="width: 100%; border: 1px solid black; background-color: #bfbfbf;">
                <h4>V. <?php echo mayusculas(traducir("traductor.experiencia_ministerial")); ?></h4>
            </div>
        
        </div>
        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%; font-weight: bold;">
                <label for="">{{ traducir("traductor.cargo") }}</label>
            </div>
            <div class="col" style="width: 25%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.lugar") }}</label>
            </div>
            <div class="col" style="width: 25%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.fecha_inicio") }}</label>
            </div>
            <div class="col" style="width: 25%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.fecha_fin") }}</label>
            </div>
        
        
        </div>
    
        <?php 
            foreach ($cargos as $kc => $vc) {
                echo '<div class="clear"></div>
                        <div class="row" style="">
                            <div class="col" style="width: 25%;">
                                <label for="">'.$vc->cargo.'</label>
                            </div>
                            <div class="col" style="width: 25%;"">
                                <label for="">'.$vc->lugar.'</label>
                            </div>
                            <div class="col" style="width: 25%;"">
                                <label for="">'.$vc->periodoini.'</label>
                            </div>
                            <div class="col" style="width: 25%;"">
                                <label for="">'.$vc->periodofin.'</label>
                            </div>
                        
                        </div>';
            }
        
        ?>
        <div class="clear"></div>
        <div class="row" style="font-size: 16px !important;">
            <div class="col" style="width: 100%; border: 1px solid black; background-color: #bfbfbf;">
                <h4>VI. <?php echo mayusculas(traducir("traductor.experiencia_laboral")); ?></h4>
            </div>
        
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 20%; font-weight: bold;">
                <label for="">{{ traducir("traductor.cargo") }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.sector") }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.institucion") }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.fecha_inicio") }}</label>
            </div>
            <div class="col" style="width: 20%; font-weight: bold;"">
                <label for="">{{ traducir("traductor.fecha_fin") }}</label>
            </div>
        
        
        </div>
    
        <?php 
            foreach ($laboral as $kl => $vl) {
                echo '<div class="clear"></div>
                        <div class="row" style="">
                            <div class="col" style="width: 20%;">
                                <label for="">'.$vl->cargo.'</label>
                            </div>
                            <div class="col" style="width: 20%;">
                                <label for="">'.$vl->sector.'</label>
                            </div>
                            <div class="col" style="width: 20%;"">
                                <label for="">'.$vl->institucionlaboral.'</label>
                            </div>
                            <div class="col" style="width: 20%;"">
                                <label for="">'.$vl->periodoini.'</label>
                            </div>
                            <div class="col" style="width: 20%;"">
                                <label for="">'.$vl->periodofin.'</label>
                            </div>
                        
                        </div>';
            }
        
        ?>
       
           
    </main>
    
</body>
</html>