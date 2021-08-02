<div id="modal-misiones" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-misiones" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="idmision" class="input-sm entrada">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="descripcion"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.direccion')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="direccion"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.telefono')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="telefono"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.email')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="email"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.fax')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="fax"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.union')}}</label>
                            <select name="idunion" id="idunion" class="selectizejs entrada"></select>
                            <!-- <div class="input-group m-bot15 col-md-12 sin-padding">
                                <select name="idunion" id="idunion" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button type="button" id="nueva-union" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div> -->

                        </div>
                       
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="1">
                                <option value="1">ACTIVO</option>
                                <option value="0">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-mision">[Esc] [{{ traducir('traductor.cancelar') }}]</button>
                    <button type="button" id="guardar-mision" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>