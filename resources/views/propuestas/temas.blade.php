@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-propuestas_temas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-propuestas_temas" class="form-horizontal" role="form">
 
                <div class="modal-body" style="max-height: 570px !important; overflow-y: scroll; overflow-x: hidden;" >
                    <input type="hidden" name="pt_id" class="input-sm entrada">
                    <input type="hidden" name="idlugar" id="idlugar" class="input-sm entrada">
                    <input type="hidden" name="lugar" id="lugar" class="input-sm entrada">
                    <input type="hidden" name="tabla" id="tabla" class="input-sm entrada">
                    <div class="row">
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
                            <select class="entrada form-control input-sm select" name="pt_idioma" id="pt_idioma">
                                <option value="es">{{ traducir("asambleas.espaniol") }}</option>
                                <option value="en">{{ traducir("asambleas.ingles") }}</option>
                                <option value="fr">{{ traducir("asambleas.frances") }}</option>

                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("asambleas.titulo") }}</label>
                            <input type="text" class="form-control input-sm entrada" name="pt_titulo" placeholder=""/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <fieldset>
                                <legend>{{ traducir("asambleas.de") }} : </legend>
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="control-label">{{ traducir("traductor.pais") }}</label>
                                        <select class="entrada form-control input-sm select" name="pais_id" id="pais_id">
                                            
                                        </select>
                                    </div>
                                    <div class="col-md-4 union">
                                        <label class="control-label">{{ traducir("traductor.union") }}</label>
                                        <select class="entrada form-control input-sm select" name="idunion" id="idunion">
                                            
                                        </select>
                                    </div>
                                    <div class="col-md-4 mision">
                                        <label class="control-label">{{ traducir("traductor.asociacion") }}</label>
                                        <select class="entrada form-control input-sm select" name="idmision" id="idmision">
                                            
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
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
                                    <div class="col-md-3" style="margin-top: 15px;">
                                        <center>
                                            <label for="" class="control-label">{{ traducir("asambleas.votos") }}</label>
                                        </center>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.si") }}</label>
                                        <input type="number" class="form-control input-sm entrada" name="pt_votos_si_uya" placeholder=""/>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.no") }}</label>
                                        <input type="number" class="form-control input-sm entrada" name="pt_votos_no_uya" placeholder=""/>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.abstenciones") }}</label>
                                        <input type="number" class="form-control input-sm entrada" name="pt_abstenciones_uya" placeholder=""/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.fecha_reunion") }}</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm entrada" name="pt_fecha_reunion_uya" id="pt_fecha_reunion_uya" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                            <div class="input-group-addon"  id="calendar-pt_fecha_reunion_uya" style="cursor: pointer;">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-9">
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
                                    <div class="col-md-3" style="margin-top: 15px;">
                                        <center>
                                            <label for="" class="control-label">{{ traducir("asambleas.votos") }}</label>
                                        </center>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.si") }}</label>
                                        <input type="number" class="form-control input-sm entrada" name="pt_votos_si_cpag" placeholder=""/>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.no") }}</label>
                                        <input type="number" class="form-control input-sm entrada" name="pt_votos_no_cpag" placeholder=""/>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.abstenciones") }}</label>
                                        <input type="number" class="form-control input-sm entrada" name="pt_abstenciones_cpag" placeholder=""/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="" class="control-label">{{ traducir("asambleas.fecha_reunion") }}</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm entrada" name="pt_fecha_reunion_cpag" id="pt_fecha_reunion_cpag" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                            <div class="input-group-addon"  id="calendar-pt_fecha_reunion_cpag" style="cursor: pointer;">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>

                                 
                                    
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("asambleas.categoria_propuesta") }}</label>
                            <select class="entrada form-control input-sm select" name="cp_id" id="cp_id">
                                
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("asambleas.detalle_otros_asuntos") }}</label>
                            <!-- <input type="text" class="form-control input-sm entrada" name="pt_detalle_otros_asuntos" placeholder=""/> -->

                            <textarea class="form-control input-sm entrada" name="pt_detalle_otros_asuntos"  cols="30" rows="2"></textarea>
                            
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("asambleas.propuesta") }}</label>
                            <textarea class="form-control input-sm entrada" name="pt_propuesta"  cols="30" rows="2"></textarea>
                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("asambleas.ventajas_desventajas_propuesta") }}</label>
                            <textarea class="form-control input-sm entrada" name="pt_ventas_desventajas"  cols="30" rows="2"></textarea>
                            
                        </div>
                    </div>
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
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("asambleas.descripcion_documentos_apoyo") }}</label>
                            <textarea class="form-control input-sm entrada" name="pt_descripcion_documentos_apoyo"  cols="30" rows="2"></textarea>
                        </div>
                        <div class="col-md-12">
                        <label class="control-label">{{ traducir("traductor.comentarios_") }}</label>
                            <textarea class="form-control input-sm entrada" name="pt_comentarios"  cols="30" rows="2"></textarea>
                            
                        </div>
                    </div>

                    <div class="row">

                        <div class="col-md-3 col-md-offset-9">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">{{ traducir("traductor.estado_activo") }}</option>
                                <option value="I">{{ traducir("traductor.estado_inactivo") }}</option>
                            </select>
                        </div>
                    </div>

                  
                 
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-propuesta-tema">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-propuesta-tema" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>
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
				<h4 class="modal-title">{{ traducir("traductor.listado_asociados") }}</h4>

			</div>
			<div class="modal-body">
				<?php echo $tabla_asociados; ?>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

   
@endsection

