<div id="modal-eleccion" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-eleccion" class="form-horizontal" role="form">

                <div class="modal-body">
                <input type="hidden" name="ideleccion" class="input-sm entrada">
                    <div class="row">
                        
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.division") }}</label>

                            <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                            </select>

                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.pais") }}</label>

                            <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                            </select>

                        </div>
                        <div class="col-md-4 union">
                            <label class="control-label">{{ traducir("traductor.union") }}</label>

                            <select  class="entrada selectizejs" name="idunion" id="idunion">

                            </select>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                            <select  class="entrada selectizejs" name="idmision" id="idmision">

                            </select>

                        </div>
                        <div class="col-md-4" style="">
                        
                            <label class="control-label">{{ traducir('traductor.periodo_ini') }}</label>
                            <select class="entrada selectizejs limpiar-cargos" name="periodoini" id="periodoini">

                            </select>

                        </div>
                        <div class="col-md-4" style="">
                            <label class="control-label">{{ traducir('traductor.periodo_fin') }}</label>
                            <select class="entrada selectizejs limpiar-cargos" name="periodofin" id="periodofin">

                            </select>
                        </div>
                        <!-- <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.distrito_misionero')}}</label>

                            <select name="iddistritomisionero" id="iddistritomisionero" class="selectizejs entrada"></select>

                        </div>

                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.iglesia')}}</label>

                            <select name="idiglesia" id="idiglesia" class="selectizejs entrada"></select>

                        </div> -->
                        
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir("traductor.fecha_elecciones_anteriores") }}</label>
                        </div>
                        <div class="col-md-3">
                        
                            <div class="input-group">
                              
                                <input type="text" class="form-control input-sm entrada" name="fechaanterior" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon" id="calendar-fechaanterior" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir("traductor.feligresia_para_fecha") }}</label>
                        </div>
                        <div class="col-md-3">
                            <input type="number" class="form-control input-sm entrada" name="feligresiaanterior" placeholder="" />
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir("traductor.fecha_estas_elecciones") }}</label>
                        </div>
                        <div class="col-md-3">
                            <div class="input-group">
                              
                                <input type="text" class="form-control input-sm entrada" name="fecha" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon" id="calendar-fecha" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir("traductor.elecciones_supervisadas_por") }}</label>
                        </div>
                        <div class="col-md-6">
                            <input type="text" class="form-control input-sm entrada" name="supervisor" placeholder="" />
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir("traductor.numero_delegados_derecho") }}</label>
                        </div>
                        <div class="col-md-3">
                            <input type="number" class="form-control input-sm entrada" name="delegados" placeholder="" />
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir("traductor.feligresia_esta_fecha") }}</label>
                        </div>
                        <div class="col-md-3">
                            <input type="number" class="form-control input-sm entrada" name="feligresiaactual" placeholder="" />
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                       
                        <div class="col-md-12">
                            <input type="radio" name="tiporeunion" value="O" class="minimal entrada" >&nbsp;{{ traducir("traductor.reunion_ordinaria") }}&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="tiporeunion" value="E" class="minimal entrada" >&nbsp;{{ traducir("traductor.reunion_extraordinaria") }}
                        </div>
                    </div>

                    <div class="row" style="margin-top: 10px;">
                       
                        <div class="col-md-12">
                            <label for="" class="control-label">{{ traducir("traductor.comentarios_") }}</label>
                            <textarea class="form-control input-sm entrada" name="comentarios"  cols="30" rows="4"></textarea>
                        </div>
                    </div>
                  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-eleccion">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-eleccion" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>    
                </div>
            </form>

        </div>
    </div>
</div>