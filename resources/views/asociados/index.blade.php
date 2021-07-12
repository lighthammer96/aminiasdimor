@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

    @include('asociados.form')
    

    <div id="modal-bajas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
             
            <form id="formulario-bajas" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <center><span style="font-weight: 600; font-size: 16px; text-align: center;" class="miembro"></span></center>
                    <div class="row">
                       
                        
                        <div class="col-md-12">
                            <input type="hidden" name="idmiembro_baja" class="input-sm entrada">
                            <input type="hidden" name="idresponsable" class="input-sm entrada datos-responsable" >
                            <input type="hidden" name="tabla" class="input-sm entrada datos-responsable" >

                            <label for="" class="control-label">{{ traducir('traductor.responsable') }}</label>
                            
                            <div class="input-group">
                                <input readonly="readonly" type="text" class="form-control input-sm entrada datos-responsable" name="responsable" placeholder="Buscar Responsable...">
                                <span class="input-group-btn">
                                    <button type="button" id="buscar_responsable_baja" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>
                                   
                                </span>

                            </div>
                        </div>
                        <div class="col-md-12" style="">
                            <label class="control-label">{{ traducir('traductor.fecha') }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="fecha" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.motivo_baja') }}</label>
                            <select class="selectizejs entrada" name="idmotivobaja" id="idmotivobaja"></select>
                            <!-- <div class="input-group">
                                <select class="selectizejs entrada" name="idmotivobaja" id="idmotivobaja"></select>

                                <span class="input-group-btn">
                                    <button type="button" id="nuevo-pais" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div> -->

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.observaciones')}}</label>

                      
                            <textarea class="form-control input-sm entrada" name="observaciones"  cols="30" rows="4"></textarea>

                        </div>
                 
                       
                      
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-baja">[Esc] [{{ traducir('cancelar') }}]</button>
                    <button type="button" id="guardar-baja" class="btn btn-primary btn-sm">[F9] [{{ traducir('guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>




<div id="modal-altas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
             
            <form id="formulario-altas" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <center><span style="font-weight: 600; font-size: 16px; text-align: center;" class="miembro"></span></center>
                    <div class="row">
                       
                        
                        <div class="col-md-12">
                            <input type="hidden" name="idmiembro_alta" class="input-sm entrada">
                            <input type="hidden" name="idresponsable" class="input-sm entrada datos-responsable" >
                            <input type="hidden" name="tabla" class="input-sm entrada datos-responsable" >

                            <label for="" class="control-label">{{ traducir('traductor.responsable') }}</label>
                            
                            <div class="input-group">
                                <input readonly="readonly" type="text" class="form-control input-sm entrada datos-responsable" name="responsable" placeholder="Buscar Responsable...">
                                <span class="input-group-btn">
                                    <button type="button" id="buscar_responsable_alta" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>
                                   
                                </span>

                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.bautizado_vez')}}</label>

                            &nbsp;&nbsp;    
                            <input class="minimal entrada" type="checkbox" name="rebautizo" >

                        </div>
                        <div class="col-md-12" style="">
                            <label class="control-label">{{ traducir('traductor.fecha') }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="fecha" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>
                      
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.observaciones')}}</label>

                      
                            <textarea class="form-control input-sm entrada" name="observaciones"  cols="30" rows="4"></textarea>

                        </div>
                 
                       
                      
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-alta">[Esc] [{{ traducir('cancelar') }}]</button>
                    <button type="button" id="guardar-alta" class="btn btn-primary btn-sm">[F9] [{{ traducir('guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>


<div class="modal fade" id="modal-lista-responsables" data-backdrop="static" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">Listado de Responsables</h4>

			</div>
			<div class="modal-body">
				<?php echo $tabla_responsables; ?>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
@endsection

