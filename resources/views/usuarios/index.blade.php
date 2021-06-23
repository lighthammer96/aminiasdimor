@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}



@section('content')

<div class="modal fade" id="modal-usuarios" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div> -->
            <form id="formulario-usuarios" class="form-horizontal">
                <input type="hidden" id="_token" class="entrada" name="_token" value="{{ csrf_token() }}">
                <div class="modal-body">
                    <div class="row">


                        <input type="hidden" name="usuario_id" class="input-sm entrada">

                        <!-- <div class="col-md-12">
                            <label class="control-label">Nombres</label>
                            <input type="text" autofocus="autofocus" class="form-control input-sm entrada" name="usuario_nombres" />

                        </div> -->
                        <div class="col-md-12">
                            <input type="hidden" name="idmiembro" class="input-sm entrada datos-asociado" >

                            <label for="" class="control-label">Responsable</label>
                            
                            <div class="input-group">
                                <input readonly="readonly" type="text" class="form-control input-sm entrada datos-asociado" name="asociado" placeholder="Buscar Responsable...">
                                <span class="input-group-btn">
                                    <button type="button" id="buscar_asociado" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>
                                   
                                </span>

                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="control-label">Usuario</label>
                            <input type="text" class="form-control input-sm entrada" name="usuario_user" />
                            <!-- <div class="msg"></div> -->

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">Clave</label>
                            <input type="password" class="form-control input-sm entrada" name="pass1" />

                        </div>
                        <!-- <div class="col-md-12">
                            <label class="control-label">Confimar Clave</label>
                            <input type="password" class="form-control input-sm entrada" name="pass2" />

                        </div> -->
                        <div class="col-md-12">
                            <label class="control-label">Perfil</label>
                            <select name="perfil_id" id="perfil_id" class="selectizejs entrada">

                            </select>

                        </div>

                        <div class="col-md-12">
                            <label class="control-label">Tipo de Acceso</label>
                            <select name="idtipoacceso" id="idtipoacceso" class="selectizejs entrada">

                            </select>

                        </div>
                        <!-- <div class="col-md-12">
                            <label class="control-label">Referencia</label>
                            <textarea name="usuario_referencia" id="usuario_referencia" class="form-control input-sm entrada"></textarea>

                        </div> -->
                        <div class="col-md-12">
                            <label class="control-label">Estado</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">ACTIVO</option>
                                <option value="I">INACTIVO</option>
                            </select>
                        </div>


                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-usuario">[Esc] [Cancelar]</button>
                    <button type="button" id="guardar-usuario" class="btn btn-primary btn-sm">[F9] [Guardar]</button>
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
				<h4 class="modal-title">Listado de Responsables</h4>

			</div>
			<div class="modal-body">
				<?php echo $tabla_asociados; ?>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


   
@endsection
