
<div id="modal-paises" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-paises" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="pais_id" class="input-sm entrada">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="pais_descripcion"  placeholder=""/>

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.direccion')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="direccion"  placeholder=""/>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.telefono')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="telefono"  placeholder=""/>

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.posee_union')}}</label>

                            <select name="posee_union" id="posee_union" class="form-control input-sm entrada" default-value="S">
                                <option value="S">SI</option>
                                <option value="N">NO</option>
                            </select>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.idioma')}}</label>

                            <div class="input-group m-bot15 col-md-12 sin-padding">
                                <select name="idioma_id" id="idioma_id" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button style="margin-top: -5px;" type="button" id="nuevo-idioma" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div>

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.division')}}</label>

                            <div class="input-group m-bot15 col-md-12 sin-padding">
                                <select name="iddivision" id="iddivision" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button style="margin-top: -5px;" type="button" id="nueva-division" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">ACTIVO</option>
                                <option value="I">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.item')  }}</label>

                            <input readonly="readonly" type="text" class="form-control input-sm entrada" name="item"  placeholder="" default-value="1"/>

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.descripcion_division_politica')  }}</label>
                            <input type="text" class="form-control input-sm entrada limpiar" name="descripcion" />
                        </div>

                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered display compact" id="detalle-jerarquia" style="font-size: 13px;">
                                <thead>
                                    <tr>
                                        <th style="width: 100px;">{{ traducir('traductor.item') }}</th>
                                        <th style="width: 200px;">{{ traducir('traductor.descripcion_division_politica') }}</th>
                                        <th style="width: 30px;"></th>
                                    </tr>

                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-pais">[Esc] [{{ traducir('cancelar') }}]</button>
                    <button type="button" id="guardar-pais" class="btn btn-primary btn-sm">[F9] [{{ traducir('guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>