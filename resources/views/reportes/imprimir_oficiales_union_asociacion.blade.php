<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oficiales de Unión/Asociación</title>
    <style>

        /* referencia: https://ourcodeworld.co/articulos/leer/687/como-configurar-un-encabezado-y-pie-de-pagina-en-dompdf */
        @page {
            margin: 0cm 0cm;
        }

        /** Defina ahora los márgenes reales de cada página en el PDF **/
        body {
            margin-top: 4cm;
            margin-left: 1cm;
            margin-right: 1cm;
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
        
        <div class="clear"></div>
        <div class="row" style="margin-top: 10px; margin-bottom: 20px; text-align: center; font-size: 25px !important;">
            <div class="col" style="width: 100%;">
                <h3><?php echo mayusculas(traducir("traductor.eleccion_oficiales_union_asociacion")); ?></h3>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="">{{ traducir("traductor.nombre_de_la") }} {{ $nombre }}</label>
            </div>

            <div class="col" style="width: 25%;">
                <label for=""><strong>{{ $lugar }}</strong></label>
            </div>

            <div class="col" style="width: 50%;">
                <label for="">{{ traducir("traductor.para_periodo_de2anios") }} {{ traducir("traductor.desde") }} <strong>{{ $periodoini }}</strong> {{ traducir("traductor.hasta") }} <strong>{{ $periodofin }}</strong></label>
            </div>  
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.sede")) }}</label>
            </div> 
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>

            <div class="col" style="width: 90%;">
                <label for=""><strong>{{ $sede[0]->direccion }}</strong></label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 10px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>

            <div class="col" style="width: 15%;">
                <label for=""><strong>{{ $sede[0]->telefono }}</strong></label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for=""><strong>{{ $sede[0]->fax }}</strong></label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>

            <div class="col" style="width:45%;">
                <label for=""><strong>{{ $sede[0]->email }}</strong></label>
            </div>
        </div>
        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.datos_relativos_eleccion")) }}</label>
            </div> 
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 40%;">
                <label for="" style="">{{ traducir("traductor.fecha_elecciones_anteriores") }}</label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->fechaanterior }}</strong>
                        @endisset
                </label>
            </div>
            <div class="col" style="width: 40%; text-align: center;">
                <label for="" style="">{{ traducir("traductor.feligresia_para_fecha") }}</label>
            </div>
            <div class="col" style="width: 10%; text-align: center;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->feligresiaanterior }}</strong>
                        @endisset
                </label>
            </div>
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 40%;">
                <label for="" style="">{{ traducir("traductor.fecha_estas_elecciones") }}</label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->fecha }}</strong>
                        @endisset
                </label>
            </div>
          
            <div class="col" style="width: 50%; text-align: center;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->tiporeunion }}</strong>
                        @endisset
                </label>
            </div>
        </div>

        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 25%;">
                <label for="" style="">{{ traducir("traductor.elecciones_supervisadas_por") }}</label>
            </div>
            <div class="col" style="width: 75%;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->supervisor }}</strong>
                        @endisset
                </label>
            </div>
            
        </div>


        <div class="clear"></div>
        <div class="row" style="margin-bottom: 10px;">
            <div class="col" style="width: 35%;">
                <label for="" style="">{{ traducir("traductor.numero_delegados_derecho") }}</label>
            </div>
            <div class="col" style="width: 20%;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->delegados }}</strong>
                        @endisset
                </label>
            </div>
            <div class="col" style="width: 30%;">
                <label for="" style="">{{ traducir("traductor.feligresia_esta_fecha") }}</label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="" style="">
                        @isset($eleccion[0])
                            <strong>{{ $eleccion[0]->feligresiaactual }}</strong>
                        @endisset
                </label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.composicion_union")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 10px;">
            <div class="col" style="width: 100%;">
                <label for="" style="">{{ traducir("traductor.union_esta_compuesta") }} 
                    <strong>{{ $asociaciones }}</strong>
                </label>
            </div>
           
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.oficiales_elegidos")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($presidente[0])
                            {{ mayusculas($presidente[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($presidente[0])
                            {{ $presidente[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($presidente[0])
                            {{ $presidente[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($presidente[0])
                            {{ $presidente[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($presidente[0])
                            {{ $presidente[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($presidente[0])
                            {{ $presidente[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($presidente[0])
                            {{ $presidente[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($vicepresidente[0])
                            {{ mayusculas($vicepresidente[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($vicepresidente[0])
                            {{ $vicepresidente[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($vicepresidente[0])
                            {{ $vicepresidente[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($vicepresidente[0])
                            {{ $vicepresidente[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($vicepresidente[0])
                            {{ $vicepresidente[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($vicepresidente[0])
                            {{ $vicepresidente[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($vicepresidente[0])
                            {{ $vicepresidente[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($secretario[0])
                            {{ mayusculas($secretario[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($secretario[0])
                            {{ $secretario[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($tesorero[0])
                            {{ mayusculas($tesorero[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($tesorero[0])
                            {{ $tesorero[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>






        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($colportaje[0])
                            {{ mayusculas($colportaje[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($colportaje[0])
                            {{ $colportaje[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($colportaje[0])
                            {{ $colportaje[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($colportaje[0])
                            {{ $colportaje[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($colportaje[0])
                            {{ $colportaje[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($colportaje[0])
                            {{ $colportaje[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($colportaje[0])
                            {{ $colportaje[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>







        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($obra[0])
                            {{ mayusculas($obra[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($obra[0])
                            {{ $obra[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($obra[0])
                            {{ $obra[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($obra[0])
                            {{ $obra[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($obra[0])
                            {{ $obra[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($obra[0])
                            {{ $obra[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($obra[0])
                            {{ $obra[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>







        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($jovenes[0])
                            {{ mayusculas($jovenes[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($jovenes[0])
                            {{ $jovenes[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($jovenes[0])
                            {{ $jovenes[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($jovenes[0])
                            {{ $jovenes[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($jovenes[0])
                            {{ $jovenes[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($jovenes[0])
                            {{ $jovenes[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($jovenes[0])
                            {{ $jovenes[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>


        





        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($director_editorial[0])
                            {{ mayusculas($director_editorial[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_editorial[0])
                            {{ $director_editorial[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($director_editorial[0])
                            {{ $director_editorial[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($director_editorial[0])
                            {{ $director_editorial[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_editorial[0])
                            {{ $director_editorial[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($director_editorial[0])
                            {{ $director_editorial[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($director_editorial[0])
                            {{ $director_editorial[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>









        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($nombre_editorial[0])
                            {{ mayusculas($nombre_editorial[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($nombre_editorial[0])
                            {{ $nombre_editorial[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($nombre_editorial[0])
                            {{ $nombre_editorial[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($nombre_editorial[0])
                            {{ $nombre_editorial[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($nombre_editorial[0])
                            {{ $nombre_editorial[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($nombre_editorial[0])
                            {{ $nombre_editorial[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($nombre_editorial[0])
                            {{ $nombre_editorial[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>









        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($dorca[0])
                            {{ mayusculas($dorca[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($dorca[0])
                            {{ $dorca[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($dorca[0])
                            {{ $dorca[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($dorca[0])
                            {{ $dorca[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($dorca[0])
                            {{ $dorca[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($dorca[0])
                            {{ $dorca[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($dorca[0])
                            {{ $dorca[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>



        




        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($salud[0])
                            {{ mayusculas($salud[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($salud[0])
                            {{ $salud[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($salud[0])
                            {{ $salud[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($salud[0])
                            {{ $salud[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($salud[0])
                            {{ $salud[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($salud[0])
                            {{ $salud[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($salud[0])
                            {{ $salud[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>








        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($educacion[0])
                            {{ mayusculas($educacion[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($educacion[0])
                            {{ $educacion[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($educacion[0])
                            {{ $educacion[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($educacion[0])
                            {{ $educacion[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($educacion[0])
                            {{ $educacion[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($educacion[0])
                            {{ $educacion[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($educacion[0])
                            {{ $educacion[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>






        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($auditor_1[0])
                            {{ mayusculas($auditor_1[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($auditor_1[0])
                            {{ $auditor_1[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($auditor_1[0])
                            {{ $auditor_1[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($auditor_1[0])
                            {{ $auditor_1[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($auditor_1[0])
                            {{ $auditor_1[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($auditor_1[0])
                            {{ $auditor_1[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($auditor_1[0])
                            {{ $auditor_1[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>










        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 35%;">
                <label for="" style="font-size: 13px !important; font-weight: bold;">
                        @isset($auditor_2[0])
                            {{ mayusculas($auditor_2[0]->cargo) }} 
                        @endisset
                </label>
            </div>

            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($auditor_2[0])
                            {{ $auditor_2[0]->nombres }}
                        @endisset
                    </strong>
                </label>
            </div>

            <div class="col" style="width: 20%;">
                <label for="">{{ traducir("traductor.fecha_nacimiento") }}</label>
            </div>

            <div class="col" style="width: 10%;">
                <label for="">
                    <strong>
                        @isset($auditor_2[0])
                            {{ $auditor_2[0]->fechanacimiento }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.direccion") }}</label>
            </div>
            <div class="col" style="width: 85%;">
                <label for="">
                    <strong>
                        @isset($auditor_2[0])
                            {{ $auditor_2[0]->direccion }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>
        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.telefono") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($auditor_2[0])
                            {{ $auditor_2[0]->telefono }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 10%;">
                <label for="">{{ traducir("traductor.fax") }}</label>
            </div>
            <div class="col" style="width: 15%; text-align: center;">
                <label for="">
                    <strong>
                        @isset($auditor_2[0])
                            {{ $auditor_2[0]->celular }}
                        @endisset
                    </strong>
                </label>
            </div>
            <div class="col" style="width: 15%;">
                <label for="">{{ traducir("traductor.email") }}</label>
            </div>
            <div class="col" style="width: 35%;">
                <label for="">
                    <strong>
                        @isset($auditor_2[0])
                            {{ $auditor_2[0]->email }}
                        @endisset
                    </strong>
                </label>
            </div>
        </div>




        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.comites")) }}</label>
            </div> 
        </div>



        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($comite_union_asociacion[0])
                            {{ mayusculas($comite_union_asociacion[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($comite_union_asociacion);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($comite_union_asociacion[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$comite_union_asociacion[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$comite_union_asociacion[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>


        





        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($comite_ejecutivo[0])
                            {{ mayusculas($comite_ejecutivo[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($comite_ejecutivo);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($comite_ejecutivo[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$comite_ejecutivo[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$comite_ejecutivo[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>








        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($comite_finanzas[0])
                            {{ mayusculas($comite_finanzas[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($comite_finanzas);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($comite_finanzas[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$comite_finanzas[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$comite_finanzas[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>

                





        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($comite_literario[0])
                            {{ mayusculas($comite_literario[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($comite_literario);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($comite_literario[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$comite_literario[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$comite_literario[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>









        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($comite_salud[0])
                            {{ mayusculas($comite_salud[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($comite_salud);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($comite_salud[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$comite_salud[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$comite_salud[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>


        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.delegados")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%;">
                <label for="">{{ traducir("traductor.para") }} <strong>{{ $nombre }}</strong></label>
            </div> 
        </div>

        
        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($delegado[0])
                            {{ mayusculas($delegado[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($delegado);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($delegado[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$delegado[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$delegado[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 13px !important; font-weight: bold;">
                <label for="">
                    <strong>
                        @isset($delegado_subs[0])
                            {{ mayusculas($delegado_subs[0]->cargo) }}
                        @endisset
                    </strong>
                </label>
               
            </div>
            
        </div>

        <div class="clear"></div>
        <div class="row" style="margin-bottom: 15px;">
            <div class="col" style="width: 50%;">
                <?php 
                    $cant = count($delegado_subs);
                    $mitad = round($cant / 2);
                  
                    for ($i=0; $i < $mitad; $i++) { 
                        if(isset($delegado_subs[$i]->nombres)) {
                            echo '<label for="">'.($i+1).". ".$delegado_subs[$i]->nombres.'</label>';
                        }
                    }
                ?>
            </div>

            <div class="col" style="width: 50%;">
                <?php 
                    for ($j=$mitad; $j < $cant; $j++) { 
                        echo '<label for="">'.($j+1).". ".$delegado_subs[$i]->nombres.'</label>';
                    }
                ?>
            </div>
            
        </div>

        

        <div class="clear"></div>
        <div class="row" style="">
            <div class="col" style="width: 100%; font-size: 16px !important; font-weight: bold;">
                <label for="">{{ mayusculas(traducir("traductor.comentarios_")) }}</label>
            </div> 
        </div>

        <div class="clear"></div>
        <div class="row" style="">
           
            <div class="col" style="width: 100%;">
                <label for="" style="">
                        @isset($eleccion[0])
                            {{ $eleccion[0]->comentarios }}
                        @endisset
                </label>
            </div>
           
        </div>


        <div class="clear"></div>
        <div class="row" style="">
           
            <div class="col" style="width: 50%; text-align: center;">
                <label for="" style="">
                        {{ traducir("traductor.lugar")  }}: 
                        <strong>{{ $lugar }}</strong>
                </label>
            </div>

            
            <div class="col" style="width: 50%; text-align: center;">
                <label for="" style="">
                        {{ traducir("traductor.fecha")  }} :
                        <strong>{{ fecha_actual_idioma() }}</strong>
                </label>
            </div>
           
        </div>




        <div class="clear"></div>
        <br><br><br>
        <div class="row" style="margin-top: 100px;">
            <div class="col" style="width: 30%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_presidente") }}</label>
               
            </div>
            <div class="col" style="width: 5%;"></div>
            <div class="col" style="width: 30%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_secretario") }}</label>
            </div>
            <div class="col" style="width: 5%;"></div>
            <div class="col" style="width: 30%; border-top: 1px solid dashed; text-align: center;">
                <label for="">{{ traducir("traductor.firma_supervisor") }}</label>
            </div>
        </div>

     
   
      
    

    </main>
    
    
</body>
</html>