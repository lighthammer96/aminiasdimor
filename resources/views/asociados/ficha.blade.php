<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ficha Asociado</title>
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
        hr{
            page-break-after: always;
            border: none;
            margin: 0;
            padding: 0;
        }
	</style>
   
</head>
<body>
    @include('layouts.cabecera')
    <main>
        
        <div class="row" style="margin-top: 30px">
            <div class="col" style="width: 100%;">
                <h4><?php echo strtoupper(traducir("traductor.datos_personales")); ?></h4>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" >
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.apellidos") }}: </label>
            </div>
            <div class="col" style="width: 30%;">
                <label for="">{{ $miembro[0]->apellidos }}</label>
            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.nombres") }}: </label>
            </div>
            <div class="col" style="width: 30%;">
                <label for="">{{ $miembro[0]->nombres }}</label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-top: 20px">
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.apellido_soltera") }}: </label>
            </div>
            <div class="col" style="width: 30%;">
                <label for="">{{ $miembro[0]->apellido_soltera }}</label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.lugar_nacimiento") }}: </label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ $miembro[0]->ciudadnacextranjero }}</label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-top: 20px">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}: </label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ $miembro[0]->fechanacimiento }}</label>
            </div>
            <div class="col" style="width: 50%;">
                <?php 
                    // $checkedm = "";
                    // $checkedf = "";

                    // if($miembro[0]->sexo == "M") {
                    //     $checkedm = 'checked="checked"';
                    // }   

                    // if($miembro[0]->sexo == "F") {
                    //     $checkedf = 'checked="checked"';
                    // }   

                ?>
                <label for="">
                    <!-- <input {{-- $checkedm --}} type="radio" >&nbsp;&nbsp;{{-- traducir("traductor.hombre") --}} &nbsp;&nbsp;&nbsp;&nbsp;
                    <input {{-- $checkedf --}} type="radio" >&nbsp;&nbsp;{{-- traducir("traductor.mujer") --}} -->
                    {{ $miembro[0]->sexo }}
                </label>
             
            </div>
           
        </div>
        <div class="clear"></div>
        <div class="row">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.estado_civil") }}: </label>
                
            </div>
            <div class="col" style="width: 75%;">
                <label>
                    <?php 
                    
                        // foreach ($estado_civil as $kec => $vec) {
                        //     if($vec->idestadocivil == $miembro[0]->idestadocivil) {
                        //         echo '<input checked="checked" type="radio" >&nbsp;&nbsp;'.$vec->descripcion."&nbsp;&nbsp;&nbsp;";
                        //     } else {
                        //         echo '<input  type="radio" >&nbsp;&nbsp;'.$vec->descripcion."&nbsp;&nbsp;&nbsp;";
                        //     }
                           
                        // }
                    
                    ?>
                    {{ $miembro[0]->estado_civil }}
                </label>
            </div>
        </div>

        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.ocupacion") }}: </label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ $miembro[0]->ocupacion }}</label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.educacion") }}: </label>
            </div>
            <div class="col" style="width: 25%;">
                <label for="">{{ $miembro[0]->educacion }}</label>
            </div>
        </div>

        <div class="row" style="margin-top: 30px">
            <div class="col" style="width: 100%;">
                <h4><?php echo strtoupper(traducir("traductor.afiliacion_cargos")); ?></h4>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 30%;">
                <label for="">{{ traducir("traductor.procedencia_religiosa") }}: </label>
            </div>
            <div class="col" style="width: 70%;">
                <label for="">{{ $miembro[0]->religion }}</label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_bautismo") }}: </label>
            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ $miembro[0]->fechabautizo }}</label>
            </div>
            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.bautizado_por") }}: </label>
            </div>
            <div class="col" style="width: 40%;">
                <label for="">{{ $miembro[0]->bautizador }}</label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.fecha_aceptacion") }}: </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ $fecha_aceptacion }}</label>
            </div>
            <div class="col" style="width: 45%;">
                <label for="">{{ traducir("traductor.fecha_aceptacion_iglesia") }}: </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ $fecha_aceptacion_local }}</label>
            </div>
            
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width:35%;">
                <label for="">{{ traducir("traductor.fecha_baja") }}: </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for=""><?php echo (isset($baja[0]->fecha)) ? $baja[0]->fecha : "" ; ?></label>
            </div>
            <div class="col" style="width: 5%;">
                <label for="">{{ traducir("traductor.por") }}: </label>
            </div>
            <div class="col" style="width: 45%;">
                <label for=""><?php echo (isset($baja[0]->motivo_baja)) ? $baja[0]->motivo_baja : ""; ?><label>
            </div>
            
        </div>
        <!-- <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 100%;">
                <label> -->
                    <?php 
                    
                        // foreach ($motivos_baja as $kmb => $vmb) {
                        //     if(isset($baja[0]->idmotivobaja) && $vmb->idmotivobaja == $baja[0]->idmotivobaja) {
                        //         echo '<input checked="checked" type="radio" >&nbsp;&nbsp;'.$vmb->descripcion."&nbsp;&nbsp;&nbsp;&nbsp;";
                        //     } else {
                        //         echo '<input  type="radio" >&nbsp;&nbsp;'.$vmb->descripcion."&nbsp;&nbsp;&nbsp;&nbsp;";
                        //     }
                           
                        // }
                    
                    ?>
                <!-- </label>
            </div>
        </div> -->
        <div class="clear"></div>
        <div class="row" >
            <div class="col" style="width: 35%;">
                <label style="border-bottom: 1px solid black">{{ traducir("traductor.cargos_iglesia") }}</label>
            </div>
            <div class="col" style="width: 25%;">
                <label style="border-bottom: 1px solid black">{{ traducir("traductor.lugar") }}</label>
            </div>
            <div class="col" style="width: 20%;">
                <label style="border-bottom: 1px solid black">{{ traducir("traductor.f_desde") }}</label>
            </div>
            <div class="col" style="width: 20%;">
                <label style="border-bottom: 1px solid black">{{ traducir("traductor.f_hasta") }}</label>
            </div>
        </div>

        <?php 
            foreach($cargos as $kc => $vc) {
                echo '  <div class="clear"></div>
                        <div class="row">
                            <div class="col" style="width: 35%;">
                                <label style="">'.$vc->cargo.'</label>
                            </div>
                            <div class="col" style="width: 25%;">
                                <label style="">'.$vc->lugar.'</label>
                            </div>
                            <div class="col" style="width: 20%;">
                                <label style="">'.$vc->periodoini.'</label>
                            </div>
                            <div class="col" style="width: 20%;">
                                <label style="">'.$vc->periodofin.'</label>
                            </div>
                        </div>';
            }
        
        ?>

        <div class="row" style="margin-top: 30px">
            <div class="col" style="width: 100%;">
                <h4><?php echo strtoupper(traducir("traductor.comentarios")); ?></h4>
            </div>
        </div>
        <div class="row" >
            <div class="col" style="width: 100%;">
                <label for="">{{ $miembro[0]->observaciones }}</label>
            </div>
        </div>

    </main>
    
    
</body>
</html>