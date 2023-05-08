<div id="modal-eleccion" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-eleccion" class="form-horizontal" role="form">

                <div class="modal-body" style="height: 420px; overflow-y: scroll; overflow-x: hidden;">
                <input type="hidden" name="ideleccion" class="input-sm entrada">
                <input type="hidden" name="tipo" class="input-sm entrada" default-value="A">
                    <div class="row">

                        <div class="col-md-3">
                            <label class="control-label">{{ traducir("traductor.division") }}</label>

                            <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                            </select>

                        </div>
                        <div class="col-md-3">
                            <label class="control-label">{{ traducir("traductor.pais") }}</label>

                            <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                            </select>

                        </div>
                        <div class="col-md-3 union">
                            <label class="control-label">{{ traducir("traductor.union") }}</label>

                            <select  class="entrada selectizejs" name="idunion" id="idunion">

                            </select>

                        </div>
                        <div class="col-md-3">
                            <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                            <select  class="entrada selectizejs" name="idmision" id="idmision">

                            </select>

                        </div>
                    </div>
                    <div class="row">

                        <div class="col-md-3" style="">

                            <label class="control-label">{{ traducir('traductor.periodo_ini') }}</label>
                            <select class="entrada selectizejs limpiar-cargos" name="periodoini" id="periodoini">

                            </select>

                        </div>
                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir('traductor.periodo_fin') }}</label>
                            <select class="entrada selectizejs limpiar-cargos" name="periodofin" id="periodofin">

                            </select>
                        </div>
                        <div class="col-md-6" style="margin-top: 28px;">
                            <input type="radio" name="tiporeunion" value="O" class="minimal entrada" >&nbsp;{{ traducir("traductor.reunion_ordinaria") }}&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="tiporeunion" value="E" class="minimal entrada" >&nbsp;{{ traducir("traductor.reunion_extraordinaria") }}
                        </div>


                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.fecha_elecciones_anteriores") }}</label>
                        </div>
                        <div class="col-md-2">

                            <div class="input-group">

                                <input type="text" class="form-control input-sm entrada" name="fechaanterior" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon" id="calendar-fechaanterior" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label class="control-label">{{ traducir("traductor.feligresia_para_fecha") }}</label>
                        </div>
                        <div class="col-md-3">
                            <input type="number" class="form-control input-sm entrada" name="feligresiaanterior" placeholder="" />
                        </div>
                    </div>

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.fecha_estas_elecciones") }}</label>
                        </div>
                        <div class="col-md-2">
                            <div class="input-group">

                                <input type="text" class="form-control input-sm entrada" name="fecha" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon" id="calendar-fecha" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-3">
                            <label class="control-label">{{ traducir("traductor.elecciones_supervisadas_por") }}</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" class="form-control input-sm entrada" name="supervisor" placeholder="" />
                        </div>
                    </div>

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.numero_delegados_derecho") }}</label>
                        </div>
                        <div class="col-md-2">
                            <input type="number" class="form-control input-sm entrada" name="delegados" placeholder="" />
                        </div>
                        <div class="col-md-3">
                            <label class="control-label">{{ traducir("traductor.feligresia_esta_fecha") }}</label>
                        </div>
                        <div class="col-md-3">
                            <input type="number" class="form-control input-sm entrada" name="feligresiaactual" placeholder="" />
                        </div>
                    </div>



                    <div class="row" style="margin-top: 10px;">

                        <div class="col-md-12">
                            <label for="" class="control-label">{{ traducir("traductor.comentarios_") }}</label>
                            <textarea class="form-control input-sm entrada" name="comentarios"  cols="30" rows="1"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <input type="hidden" name="idmiembro" class="input-sm entrada datos-asociado limpiar-oficiales" >
                            <input type="hidden" name="fechanacimiento" class="input-sm entrada datos-asociado limpiar-oficiales" >
                            <input type="hidden" name="direccion" class="input-sm entrada datos-asociado limpiar-oficiales" >
                            <input type="hidden" name="telefono" class="input-sm entrada datos-asociado limpiar-oficiales" >
                            <input type="hidden" name="fax" class="input-sm entrada datos-asociado limpiar-oficiales" >
                            <input type="hidden" name="email" class="input-sm entrada datos-asociado limpiar-oficiales" >

                            <label for="" class="control-label">{{ traducir('traductor.asociado')}}</label>

                            <div class="input-group">
                                <input readonly="readonly" type="text" class="form-control input-sm entrada datos-asociado limpiar-oficiales" name="asociado" placeholder="{{ traducir('asambleas.buscar_asociado') }}...">
                                <span class="input-group-btn">
                                    <button type="button" id="buscar_asociado" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>

                                </span>

                            </div>
                        </div>
                        <div class="col-md-3" style="">

                            <label class="control-label">{{ traducir('traductor.cargo') }}</label>
                            <select class="entrada form-control input-sm select limpiar-oficiales" name="idcargo_asociacion" id="idcargo_asociacion">

                            </select>

                        </div>
                        <div class="col-md-1" style="margin-top: 7px; text-align: right; padding-left: 5px;">
                            <button type="button" class="btn btn-default btn-sm" id="agregar-oficial"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/plus.png') }}" ><br>[{{ traducir("traductor.agregar") }}]</button>

                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered display compact" id="detalle-oficiales">
                                <thead>
                                    <tr>
                                        <th style="width: 200px;">{{ traducir('traductor.asociado') }}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.fecha_nacimiento') }}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.direccion') }}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.telefono') }}</th>

                                        <th style="width: 200px;">{{ traducir('traductor.fax') }}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.email') }}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.cargo') }}</th>

                                        <th style="width: 30px;">{{ traducir('traductor.eliminar') }}</th>
                                    </tr>

                                </thead>
                                <tbody >

                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-eleccion"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-eleccion" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar')}}]</button>
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

