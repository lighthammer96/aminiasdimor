@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-propuestas_elecciones" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-propuestas_elecciones" class="form-horizontal" role="form">

                <div class="modal-body">
                    <input type="hidden" name="pe_id" class="input-sm entrada">
                    <div class="row cambiar-row-1">
                        <div class="col-md-6 origen" style="padding-right: 5px;">
                            <label class="control-label">{{ traducir("traductor.descripcion") }}</label>
                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="tpe_descripcion" placeholder="" />
                        </div>

                       

                        <div class="col-md-3" style="padding-left: 5px; padding-right: 5px;">
                            <label class="control-label">{{ traducir("traductor.idioma") }}</label>
                            <select class="entrada form-control input-sm select" name="tpe_idioma" id="tpe_idioma">
                                <option value="es">{{ traducir("asambleas.espaniol") }}</option>
                                <option value="en">{{ traducir("asambleas.ingles") }}</option>
                                <option value="fr">{{ traducir("asambleas.frances") }}</option>

                            </select>
                        </div>
                       
                        
                    </div>
                    <div class="row">
                        <div class="col-md-6 traduccion" style="padding-right: 5px; display: none;">
                            <label class="control-label">{{ traducir("traductor.descripcion") }}</label>
                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="tpe_descripcion_traduccion" placeholder="" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 origen">
                            <label class="control-label">{{ traducir("asambleas.detalle_propuesta") }}</label>
                          

                            <textarea class="form-control input-sm entrada" name="tpe_detalle_propuesta"  cols="30" rows="2" ></textarea>
                            
                        </div>
                        <div class="col-md-12 traduccion" style="display: none;">
                            <label class="control-label">{{ traducir("asambleas.detalle_propuesta") }}</label>
                          

                            <textarea class="form-control input-sm entrada" name="tpe_detalle_propuesta_traduccion"  cols="30" rows="2" ></textarea>
                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-md-offset-5">
                            <label class="control-label">{{ traducir('asambleas.estado_propuesta')}}</label>
                            <select name="pe_estado" id="pe_estado" class="form-control input-sm entrada select" default-value="1">
                                <option value="1">{{ traducir("asambleas.proceso_registro") }}</option>
                                <option value="2">{{ traducir("asambleas.enviado_traduccion") }}</option>
                                <option value="3">{{ traducir("asambleas.traduccion_completa") }}</option>
                            </select>
                        </div>
                        <div class="col-md-3" style="padding-left: 5px;">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada select" default-value="A">
                                <option value="A">{{ traducir("traductor.estado_activo") }}</option>
                                <option value="I">{{ traducir("traductor.estado_inactivo") }}</option>
                            </select>
                        </div>
                    </div>
                 
                    <div class="row sin-traduccion">
                       
                        <div class="col-md-6 origen">
                            <label class="control-label">{{ traducir('asambleas.propuesta')}}</label>
                            <input type="text" class="form-control input-sm entrada limpiar" name="propuesta" />
                        </div>

                    
                        

                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-12 origen">
                            <table class="table table-striped table-bordered display compact" id="detalle-propuesta" style="font-size: 13px;">
                                <thead>
                                    <tr>
                                        <th style="width: 500px;">{{ traducir('asambleas.propuesta')}}</th>
                                        
                                        <th style="width: 30px;">{{ traducir('traductor.eliminar')}}</th>
                                    </tr>

                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>

                   
                </div>

                
                <div class="row con-traduccion" style="display: none;">
                       

                       <div class="col-md-6 traduccion" >
                           <label class="control-label">{{ traducir('asambleas.propuesta')}}</label>
                           <input type="text" class="form-control input-sm entrada limpiar" name="propuesta_traduccion" />
                       </div>
                       

                </div>
                <div class="row con-traduccion" style="margin-top: 15px; display:none;">
                        

                        <div class="col-md-12 traduccion" style="display: none;">
                            <table class="table table-striped table-bordered display compact" id="detalle-propuesta-traduccion" style="font-size: 13px;">
                                <thead>
                                    <tr>
                                        <th style="width: 500px;">{{ traducir('asambleas.propuesta')}}</th>
                                        
                                        <th style="width: 30px;">{{ traducir('traductor.eliminar')}}</th>
                                    </tr>

                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                   
                </div>
                <div class="modal-footer">

                    <div class="pull-left" id="someter-votacion">
                        <label class="control-label">
                                
                            <input class="minimal entrada" type="checkbox" name="pe_someter_votacion" id="pe_someter_votacion">
                            
                            {{ traducir('asambleas.someter_votacion')}}
                        </label>
                    </div>

                    <div class="pull-right">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-propuesta-eleccion">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                        <button type="button" id="guardar-propuesta-eleccion" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>



<div class="modal fade" id="modal-votaciones" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm" role="document">
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
                    <!-- <div class="row">
                        <div class="col-md-12">
                    
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <input type="text" class="form-control input-sm entrada" name="convocatoria" id="convocatoria" readonly="readonly" />
                            
                        </div>
                        
                    </div> -->
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
                    <div class="row">
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
            
                    </div>
                </div>
                <div class="modal-footer">
                    
            
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-votaciones">[{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-votaciones" class="btn btn-primary btn-sm">[{{ traducir('traductor.guardar')}}]</button>
                
                        
                </div>
            </form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

@endsection

