@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-propuestas_temas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-propuestas_temas" class="form-horizontal" role="form">
 
                <div class="modal-body" style="max-height: 535px !important; overflow-y: scroll; overflow-x: hidden;" >
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#datos-generales" data-toggle="tab">{{ traducir("traductor.datos_generales") }}</a></li>
                            <li><a href="#tpropuesta" data-toggle="tab">{{ traducir("asambleas.propuesta") }}</a></li>
                            <li><a href="#detalle-otros-asuntos" data-toggle="tab">{{ traducir("asambleas.otros_asuntos") }}</a></li>
                            <li><a href="#descripcion-documentos-apoyo" data-toggle="tab">{{ traducir("asambleas.documentos_apoyo") }}</a></li>
                            <li><a href="#ventas-desventajas" data-toggle="tab">{{ traducir("asambleas.ventajas_desventajas") }}</a></li>
                            <li><a href="#justificacion-propuesta" data-toggle="tab">{{ traducir("asambleas.justificacion") }}</a></li>
                            <li><a href="#comentarios" data-toggle="tab">{{ traducir("traductor.comentarios_") }}</a></li>
                          
                            
                          
                           
                        </ul>
                    </div>
                    <div class="tab-content">
                        <div class="tab-pane active" id="datos-generales">
                            <input type="hidden" name="pt_id" class="input-sm entrada">
                            <input type="hidden" name="idlugar" id="idlugar" class="input-sm entrada">
                            <input type="hidden" name="lugar" id="lugar" class="input-sm entrada">
                            <input type="hidden" name="tabla" id="tabla" class="input-sm entrada">
                            <div class="row cambiar-row-1" >
                                <div class="col-md-2">
                                    <label class="control-label">{{ traducir("asambleas.correlativo") }}</label>
                                    <input type="text" class="form-control input-sm entrada" name="pt_correlativo" placeholder="" readonly="readonly"/>
                                </div>
                                <div class="col-md-7">
                                    <label class="control-label">{{ traducir("asambleas.convocatoria") }}</label>
                                    <select class="entrada form-control input-sm select" name="asamblea_id" id="asamblea_id">
                                        
                                    </select>
                                </div>
                                <div class="col-md-3" style="">
                                    <label class="control-label">{{ traducir("traductor.idioma") }}</label>
                                    <select class="entrada form-control input-sm select"  name="tpt_idioma" id="tpt_idioma">
                                        <option value="es">{{ traducir("asambleas.espaniol") }}</option>
                                        <option value="en">{{ traducir("asambleas.ingles") }}</option>
                                        <option value="fr">{{ traducir("asambleas.frances") }}</option>

                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <label class="control-label">{{ traducir("asambleas.propuesta_origen") }}</label>
                                    <select class="entrada selectizejs"  multiple="multiple" name="pt_id_origen[]" id="pt_id_origen">
                                        
                                    </select>
                                </div>

                            
                            </div>
                    
                            <div class="row">
                                <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("asambleas.titulo") }}</label>
                                    <input type="text" class="form-control input-sm entrada" name="tpt_titulo" placeholder=""/>
                                </div>

                                <div class="col-md-12 traduccion" style="display: none;">
                                    <label class="control-label">{{ traducir("asambleas.titulo") }}</label>
                                    <input type="text" class="form-control input-sm entrada" name="tpt_titulo_traduccion" placeholder=""/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <fieldset>
                                        <legend>{{ traducir("asambleas.de") }} : </legend>
                                        <div class="row">
                                            <div class="col-md-4 col-md-offset-4" style="">
                                                <label class="control-label">
                                                    <!-- <input type="hidden" name="posee_seguro" id="posee_seguro" class="input-sm entrada"> -->
                                                    <input class="minimal entrada" type="checkbox" name="pt_digitar" id="pt_digitar">
                                                
                                                    {{ traducir('asambleas.digitar')}}
                                                </label>
                                            
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3" style="padding-right: 5px;">
                                                <label class="control-label">{{ traducir("traductor.pais") }}</label>
                                                <select class="entrada form-control input-sm select" name="pais_id" id="pais_id">
                                                    
                                                </select>
                                            </div>
                                            <div class="col-md-3 union no-digitar"  style="padding-left: 5px; padding-right: 5px;">
                                                <label class="control-label">{{ traducir("traductor.union") }}</label>
                                                <select class="entrada form-control input-sm select" name="idunion" id="idunion">
                                                    
                                                </select>
                                            </div>
                                            <div class="col-md-3 mision no-digitar" style="padding-left: 5px; padding-right: 5px;">
                                                <label class="control-label">{{ traducir("traductor.asociacion") }}</label>
                                                <select class="entrada form-control input-sm select" name="idmision" id="idmision">
                                                    
                                                </select>
                                            </div>

                                            <div class="col-md-3 digitar" style="padding-left: 5px; padding-right: 5px; display: none;">
                                                <label class="control-label">{{ traducir("traductor.union") }}</label>
                                                <input type="text" class="form-control input-sm entrada" name="pt_union" placeholder=""/>
                                            </div>
                                            <div class="col-md-3 digitar" style="padding-left: 5px; padding-right: 5px; display: none;">
                                                <label class="control-label">{{ traducir("traductor.asociacion") }}</label>
                                                <input type="text" class="form-control input-sm entrada" name="pt_mision" placeholder=""/>
                                            </div>

                                            <div class="col-md-3" style="padding-left: 5px;">
                                                <label class="control-label">{{ traducir("traductor.email") }}</label>
                                                <input type="text" class="form-control input-sm entrada" name="pt_email" placeholder=""/>
                                            </div>
                                        </div>
                                      
                                    </fieldset>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <fieldset>
                                        <legend>{{ traducir("asambleas.certificacion_propuestas_asociaciones_uniones") }} : </legend>
                                        <div class="row">
                                            <div class="col-md-1" style="margin-top: 15px;">
                                                <center>
                                                    <label for="" class="control-label">{{ traducir("asambleas.votos") }}</label>
                                                </center>
                                            </div>
                                            <div class="col-md-1" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.si") }}</label>
                                                <input type="number" class="form-control input-sm entrada" name="pt_votos_si_uya" placeholder=""/>
                                            </div>
                                            <div class="col-md-1" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.no") }}</label>
                                                <input type="number" class="form-control input-sm entrada" name="pt_votos_no_uya" placeholder=""/>
                                            </div>
                                            <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.abstenciones") }}</label>
                                                <input type="number" class="form-control input-sm entrada" name="pt_abstenciones_uya" placeholder=""/>
                                            </div>
                                            <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.fecha_reunion") }}</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm entrada" name="pt_fecha_reunion_uya" id="pt_fecha_reunion_uya" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                                    <div class="input-group-addon"  id="calendar-pt_fecha_reunion_uya" style="cursor: pointer;">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-5" style="padding-left: 5px;">
                                                <input type="hidden" name="pt_dirigido_por_uya" class="input-sm entrada datos-asociado" >
                                                <label for="" class="control-label">{{ traducir("asambleas.dirigido_por") }}:</label>
                                                <div class="input-group">
                                                    <input readonly="readonly" type="text" class="form-control input-sm entrada datos-asociado" name="asociado" placeholder="{{ traducir('asambleas.buscar_asociado') }}...">
                                                    <span class="input-group-btn">
                                                        <button type="button" id="buscar_asociado" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>
                                                    
                                                    </span>

                                                </div>
                                            </div>

                                        </div>
                                     
                                    </fieldset>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <fieldset>
                                        <legend>{{ traducir("asambleas.certificacion_propuestas_comite_plenario_asociacion_general") }} : </legend>
                                        <div class="row">
                                            <div class="col-md-1" style="margin-top: 15px">
                                                <center>
                                                    <label for="" class="control-label">{{ traducir("asambleas.votos") }}</label>
                                                </center>
                                            </div>
                                            <div class="col-md-1" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.si") }}</label>
                                                <input type="number" class="form-control input-sm entrada" name="pt_votos_si_cpag" placeholder=""/>
                                            </div>
                                            <div class="col-md-1" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.no") }}</label>
                                                <input type="number" class="form-control input-sm entrada" name="pt_votos_no_cpag" placeholder=""/>
                                            </div>
                                            <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.abstenciones") }}</label>
                                                <input type="number" class="form-control input-sm entrada" name="pt_abstenciones_cpag" placeholder=""/>
                                            </div>
                                            <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                                <label for="" class="control-label">{{ traducir("asambleas.fecha_reunion") }}</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm entrada" name="pt_fecha_reunion_cpag" id="pt_fecha_reunion_cpag" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                                    <div class="input-group-addon"  id="calendar-pt_fecha_reunion_cpag" style="cursor: pointer;">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            

                                        
                                            
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                           

                        

                            <div class="row">
                                <div class="col-md-3 col-md-offset-6">
                                    <label class="control-label">{{ traducir('asambleas.estado_propuesta')}}</label>
                                    <select name="pt_estado" id="pt_estado" class="form-control input-sm entrada select" default-value="1">
                                        <option value="1">{{ traducir("asambleas.proceso_registro") }}</option>
                                        <option value="2">{{ traducir("asambleas.enviado_traduccion") }}</option>
                                        <option value="3">{{ traducir("asambleas.traduccion_completa") }}</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="control-label">{{ traducir('traductor.estado')}}</label>
                                    <select name="estado" id="estado" class="form-control input-sm entrada select" default-value="A">
                                        <option value="A">{{ traducir("traductor.estado_activo") }}</option>
                                        <option value="I">{{ traducir("traductor.estado_inactivo") }}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="detalle-otros-asuntos">
                            <div class="row">
                                <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("asambleas.detalle_otros_asuntos") }}</label>
                                    <!-- <input type="text" class="form-control input-sm entrada" name="pt_detalle_otros_asuntos" placeholder=""/> -->

                                    <textarea class="form-control input-sm entrada" name="tpt_detalle_otros_asuntos"  cols="30" rows="9"></textarea>
                                    
                                </div>
                                <div class="col-md-12 traduccion" style="display: none">
                                    <label class="control-label">{{ traducir("asambleas.detalle_otros_asuntos") }}</label>
                                    <!-- <input type="text" class="form-control input-sm entrada" name="pt_detalle_otros_asuntos" placeholder=""/> -->

                                    <textarea class="form-control input-sm entrada" name="tpt_detalle_otros_asuntos_traduccion"  cols="30" rows="9"></textarea>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tpropuesta">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="control-label">{{ traducir("asambleas.categoria_propuesta") }}</label>
                                    <select class="entrada form-control input-sm select" name="cp_id" id="cp_id">
                                        
                                    </select>
                                </div>
                               
                            </div>
                            <div class="row">
                                
                                <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("asambleas.propuesta") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_propuesta"  cols="30" rows="9"></textarea>
                                </div>

                                <div class="col-md-12 traduccion" style="display: none">
                                    <label class="control-label">{{ traducir("asambleas.propuesta") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_propuesta_traduccion"  cols="30" rows="9"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="descripcion-documentos-apoyo">
                            <div class="row">
           

                                <div class="col-md-12">
                                    <label class="control-label">{{ traducir("asambleas.documentos_apoyo_propuesta") }}</label>
                                    <select class="entrada form-control input-sm select" name="pt_documentos_apoyo" id="pt_documentos_apoyo">
                                        <option value="1">{{ traducir("asambleas.no_presentaran_otros_documentos") }}</option>
                                        <option value="2">{{ traducir("asambleas.si_enviar_documentos_adicionales") }}</option>
                                    
                                    </select>
                                </div>
                               

                               
                            </div>
                            <div class="row">
                                <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("asambleas.descripcion_documentos_apoyo") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_descripcion_documentos_apoyo"  cols="30" rows="9"></textarea>
                                </div>

                                <div class="col-md-12 traduccion" style="display: none">
                                    <label class="control-label">{{ traducir("asambleas.descripcion_documentos_apoyo") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_descripcion_documentos_apoyo_traduccion"  cols="30" rows="9"></textarea>
                                </div>
                            </div>
                        </div>


                        <div class="tab-pane" id="ventas-desventajas">
                            <div class="row">
                            <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("asambleas.ventajas_desventajas_propuesta") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_ventas_desventajas"  cols="30" rows="9"></textarea>
                                    
                                </div>

                                <div class="col-md-12 traduccion" style="display: none">
                                    <label class="control-label">{{ traducir("asambleas.ventajas_desventajas_propuesta") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_ventas_desventajas_traduccion"  cols="30" rows="9"></textarea>
                                    
                                </div>

                            </div>
                        </div>

                        <div class="tab-pane" id="justificacion-propuesta">
                            <div class="row">
                                <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("asambleas.justificacion_propuesta") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_justificacion_propuesta"  cols="30" rows="9"></textarea>
                                    
                                </div>

                                <div class="col-md-12 traduccion" style="display: none">
                                    <label class="control-label">{{ traducir("asambleas.justificacion_propuesta") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_justificacion_propuesta_traduccion"  cols="30" rows="9"></textarea>
                                    
                                </div>

                            </div>
                        </div>
                        
                        <div class="tab-pane" id="comentarios">
                            <div class="row">
                                <div class="col-md-12 origen">
                                    <label class="control-label">{{ traducir("traductor.comentarios_") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_comentarios"  cols="30" rows="9"></textarea>
                                    
                                </div>

                                <div class="col-md-12 traduccion" style="display: none">
                                    <label class="control-label">{{ traducir("traductor.comentarios_") }}</label>
                                    <textarea class="form-control input-sm entrada" name="tpt_comentarios_traduccion"  cols="30" rows="9"></textarea>
                                    
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-left" id="someter-votacion">
                        <label class="control-label" id="checkbox-someter-votacion">
                                
                            <input class="minimal entrada" type="checkbox" name="pt_someter_votacion" id="pt_someter_votacion">
                            
                            {{ traducir('asambleas.someter_votacion')}}
                        </label>

                        &nbsp;&nbsp;
                        <button type="button" class="btn btn-default btn-sm" id="ver-votacion-activa" style="display: none;"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/documento.png') }}" ><br>[{{ traducir('asambleas.ver_votacion_activa')}}]</button>
    
                        &nbsp;&nbsp;
                        <button type="button" class="btn btn-default btn-sm" id="ver-resultados"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/documento.png') }}" ><br>[{{ traducir('asambleas.ver_resultados')}}]</button>

                        &nbsp;&nbsp;
                        <button type="button" class="btn btn-default btn-sm" id="imprimir"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/printer.png') }}" ><br>{{ traducir('traductor.imprimir')}}</button>
                    </div>
                    <div class="pull-right">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-propuesta-tema"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                        <button type="button" id="guardar-propuesta-tema" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar')}}]</button>
                    </div>
                    
                </div>
            </form>

        </div>
    </div>
</div>



<div class="modal fade" id="modal-lista-asociados" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">{{ traducir("asambleas.listado_asociados") }}</h4>

			</div>
			<div class="modal-body">
				<?php echo $tabla_asociados; ?>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<div class="modal fade" id="modal-votaciones" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                <button style="float: right;" type="button" class="btn btn-primary btn-sm" id="cerrar-votaciones"><i class="fa fa-close"></i></button>
				<h4 class="modal-title">{{ traducir("asambleas.configuracion_votacion") }}</h4>

			</div>
            <form id="formulario-votaciones" class="form-horizontal" role="form">
                <div class="modal-body">
                    <input type="hidden" name="votacion_id" class="entrada input-sm">
                    <input type="hidden" name="propuesta_id" class="entrada input-sm">
                    <input type="hidden" name="tabla" class="entrada input-sm">
                    <input type="hidden" name="asamblea_id" class="entrada input-sm">
                    <input type="hidden" name="estado" class="entrada input-sm">
                    <div class="row">
                        <div class="col-md-12">
                    
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <input type="text" class="form-control input-sm entrada" name="convocatoria" id="convocatoria" readonly="readonly" />
                            
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                        
                            <label class="control-label">{{ traducir('asambleas.votacion_por')}}</label>
                            <input type="text" readonly="readonly" class="form-control input-sm entrada" name="propuesta" id="propuesta" />
                            
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('asambleas.forma_votar')}}</label>
                            <select name="fv_id" id="fv_id" class="form-control input-sm entrada select">
                                
                            </select>
                        </div>
            
                    </div>
                    <!-- <div class="row">
                        <div class="col-md-6">
                            
                            <label class="control-label">{{ traducir('asambleas.hora_apertura')}}</label>
                    
                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada limpiar" name="votacion_hora_apertura" />
                                <div class="input-group-addon" style="cursor: pointer;">
                                    <i class="fa fa-clock-o" id="time-votacion_hora_apertura"></i>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6">
                            
                            <label class="control-label">{{ traducir('asambleas.hora_cierre')}}</label>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada limpiar" name="votacion_hora_cierre" />
                                <div class="input-group-addon" style="cursor: pointer;">
                                    <i class="fa fa-clock-o" id="time-votacion_hora_cierre"></i>
                                </div>
                            </div>
                            
                        </div>
            
                    </div> -->
                </div>
                <div class="modal-footer">
                    <div class="pull-left">
                        <button style="display: none;" type="button" class="btn btn-default btn-sm" id="abrir-votacion"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/open.png') }}" ><br>[{{ traducir('asambleas.abrir_votacion')}}]</button>

                        <button style="display: none;" type="button" class="btn btn-default btn-sm" id="cerrar-votacion"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cerrar-sesion.png') }}" ><br>[{{ traducir('asambleas.cerrar_votacion')}}]</button>
                    </div>

            
                    <div class="pull-right">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-votaciones"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[{{ traducir('traductor.cancelar')}}]</button>

                        <button type="button" id="guardar-votaciones" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[{{ traducir('traductor.guardar')}}]</button>
                    </div>
                
                        
                </div>
            </form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div class="modal fade" id="modal-resultados" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                <button style="float: right;" type="button" class="btn btn-primary btn-sm" id="cerrar-resultados"><i class="fa fa-close"></i></button>
				<h4 class="modal-title">{{ traducir("asambleas.resultados") }}</h4>

			</div>
            <form id="formulario-resultados" class="form-horizontal" role="form">
                <div class="modal-body">
                    <table class="table table-striped table-bordered display compact" id="detalle-resultados" style="font-size: 13px;">
                        <thead>
                            <tr>
                                <th style="width: 200px;">{{ traducir('asambleas.resultados')}}</th>
                                <th style="width: 50px;">{{ traducir('asambleas.votos')}}</th>
                                <th style="width: 60px;">{{ traducir('asambleas.mano_alzada')}}</th>
                                <th style="width: 50px;">{{ traducir('traductor.total')}}</th>
                                <!-- <th style="width: 50px;">{{ traducir('asambleas.ganador')}}</th> -->
                            </tr>

                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
                
            </form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div class="row">

    <div class="col-md-2" >
        <label class="control-label">{{ traducir("traductor.fecha_inicio") }}</label>
        <div class="input-group">
            <input type="text" class="form-control input-sm entrada" name="fecha-inicio" data-inputmask="\'alias\': \'dd/mm/yyyy\'" data-mask placeholder="" />
            <div class="input-group-addon"  id="calendar-fecha-inicio" style="cursor: pointer;">
                <i class="fa fa-calendar"></i>
            </div>
        </div> 
    </div>
    <div class="col-md-2">
        <label class="control-label">{{ traducir("traductor.fecha_fin") }}</label>
        <div class="input-group">
            <input type="text" class="form-control input-sm entrada" name="fecha-fin" data-inputmask="\'alias\': \'dd/mm/yyyy\'" data-mask placeholder="" />
            <div class="input-group-addon"  id="calendar-fecha-fin" style="cursor: pointer;">
                <i class="fa fa-calendar"></i>
            </div>
        </div> 
    </div>
    <div class="col-md-3 ">
        <label class="control-label">{{ traducir("traductor.pais") }}</label>
        
        <!-- <input type="text" class="form-control input-sm entrada" name="pais" /> -->
        <select class="entrada form-control input-sm select" name="pais_id_filtro" id="pais_id_filtro">
                                            
        </select>
            
    </div>
    <div class="col-md-1 " style="margin-top: 7px;">
        <!-- <label class="control-label">{{ traducir("asambleas.filtrar") }}</label> -->
        <button type="button" id="filtrar" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/lupa.png') }}" ><br>[{{ traducir('asambleas.filtrar')}}]</button>
            
    </div>
</div>
@endsection

