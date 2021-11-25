
<div id="modal-divisiones" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-divisiones" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="iddivision" class="input-sm entrada">
                        <!-- <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="descripcion"  placeholder=""/>

                        </div> -->
                       
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="1">
                                <option value="1">ACTIVO</option>
                                <option value="0">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.idioma')}}</label>
                            <select name="idioma" id="idioma" class="selectizejs entrada"></select>
                            <!-- <div class="input-group">
                                <select data-placeholder="Seleccione Idioma " name="idioma" id="idioma" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button style="margin-top: -5px;" type="button" id="nuevo-idioma" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div> -->

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>
                            <input type="text" class="form-control input-sm entrada limpiar" name="descripcion" />
                        </div>

                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered display compact" id="detalle-traducciones" style="font-size: 13px;">
                                <thead>
                                    <tr>
                                        <th style="width: 100px;">{{ traducir('traductor.idioma')}}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.descripcion')}}</th>
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
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-division"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar') }}]</button>
                    <button type="button" id="guardar-division" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>