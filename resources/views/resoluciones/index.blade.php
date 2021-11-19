@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-resoluciones" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-resoluciones" class="form-horizontal" role="form">

                <div class="modal-body">
                    <input type="hidden" name="resolucion_id" class="input-sm entrada">
                    <input type="hidden" name="resultado_ids" class="input-sm entrada">
                    <div class="row cambiar-row-1">
<!--                         
                        <div class="col-md-3  col-md-offset-6">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada select" default-value="A">
                                <option value="A">{{ traducir("traductor.estado_activo") }}</option>
                                <option value="I">{{ traducir("traductor.estado_inactivo") }}</option>
                            </select>
                        </div> -->
                        <div class="col-md-3 col-md-offset-6" style="padding-left: 5px;">
                            <label class="control-label">{{ traducir("traductor.idioma") }}</label>
                            <select class="entrada form-control input-sm select" name="tr_idioma" id="tr_idioma">
                                <option value="es">{{ traducir("asambleas.espaniol") }}</option>
                                <option value="en">{{ traducir("asambleas.ingles") }}</option>
                                <option value="fr">{{ traducir("asambleas.frances") }}</option>

                            </select>
                        </div>
                        
                    </div>

                    <div class="row">
                        <div class="col-md-3" style="padding-right: 5px;">
                            <label class="control-label">{{ traducir("traductor.tipo") }}</label>
                            <select autofocus="autofocus" name="tabla" id="tabla" class="form-control input-sm entrada">
                                <option value="">{{ traducir('traductor.seleccione') }}</option>
                                <option value="asambleas.propuestas_temas">{{ traducir('asambleas.temas') }}</option>
                                <option value="asambleas.propuestas_elecciones">{{ traducir('asambleas.elecciones') }}</option>
                            </select>
                        </div>

                        <div class="col-md-3" style="padding-left: 5px; padding-right: 5px;">
                            <label class="control-label">{{ traducir("asambleas.anio_correlativo") }}</label>
                            <input  type="text" class="form-control input-sm entrada datos-propuesta" name="resolucion_anio_correlativo" placeholder="" readonly="readonly" />
                        </div>
                        <div class="col-md-6" style="padding-left: 5px;">
                            <label class="control-label">{{ traducir("asambleas.propuesta") }}</label>
                            <input type="hidden" name="propuesta_id" class="input-sm entrada datos-propuesta" >
                            <input type="hidden" name="tr_propuesta" class="input-sm entrada datos-propuesta" >
                            <!-- <input type="hidden" name="tabla" class="input-sm entrada datos-propuesta" > -->
                            <div class="input-group">
                                <input readonly="readonly" type="text" class="form-control input-sm entrada datos-propuesta" name="tr_titulo_propuesta" placeholder="{{ traducir('asambleas.buscar_propuesta') }}...">
                                <span class="input-group-btn">
                                    <button type="button" id="buscar_propuesta" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>
                                   
                                </span>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        
                        <div class="col-md-12 origen" style="">
                            <label class="control-label">{{ traducir("asambleas.resolucion") }}</label>
                            <textarea class="form-control input-sm entrada" name="tr_descripcion"  cols="30" rows="6"></textarea>
                        </div>

                        <div class="col-md-12 traduccion" style="display: none;">
                            <label class="control-label">{{ traducir("asambleas.resolucion") }}</label>
                            <textarea class="form-control input-sm entrada" name="tr_descripcion_traduccion"  cols="30" rows="6"></textarea>
                        </div>
                      
                      
                       
                    </div>

                    <div class="row">

                        <div class="col-md-4 col-md-offset-5">
                            <label class="control-label">{{ traducir('asambleas.estado_resolucion')}}</label>
                            <select name="resolucion_estado" id="resolucion_estado" class="form-control input-sm entrada select" default-value="1">
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

                    <div class="row">
                        
                        <div class="col-md-12" style="">
                            <label class="control-label">{{ traducir("asambleas.resultado_votacion") }}</label>
                                <!-- <textarea class="form-control input-sm entrada" name="tr_descripcion"  cols="30" rows="6"></textarea> -->
                        </div>
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered display compact" id="detalle-resultados" style="font-size: 13px; display: none;">
                                <thead>
                                    <tr>
                                        <th style="width: 200px;">{{ traducir('asambleas.resultados')}}</th>
                                        <th style="width: 50px;">{{ traducir('asambleas.votos')}}</th>
                                        <th style="width: 60px;">{{ traducir('asambleas.mano_alzada')}}</th>
                                        <th style="width: 50px;">{{ traducir('traductor.total')}}</th>
                                        <th style="width: 50px; display: none;" class="ganador">{{ traducir('asambleas.ganador')}}</th>
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
                        
                        <button type="button" class="btn btn-success btn-sm" id="imprimir">{{ traducir('traductor.imprimir')}}</button>

                     
                    </div>
                    <div class="pull-right">

                        <button type="button" class="btn btn-default btn-sm" id="cancelar-resolucion">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                        <button type="button" id="guardar-resolucion" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>



<div class="modal fade" id="modal-propuestas-temas" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">{{ traducir("asambleas.listado_propuestas_temas") }}</h4>

			</div>
			<div class="modal-body">
				<?php echo $tabla_propuestas_temas; ?>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="modal-propuestas-elecciones" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">{{ traducir("asambleas.listado_propuestas_elecciones") }}</h4>

			</div>
			<div class="modal-body">
				<?php echo $tabla_propuestas_elecciones; ?>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
   
@endsection

