
<div id="modal-idiomas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-idiomas" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="idioma_id" class="input-sm entrada">
                        <div class="col-md-12">
                            <label class="control-label">{{ trans('codigo')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="idioma_codigo"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ trans('descripcion')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="idioma_descripcion"  placeholder=""/>

                        </div>
                       
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
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-idioma">[Esc] [Cancelar]</button>
                    <button type="button" id="guardar-idioma" class="btn btn-primary btn-sm">[F9] [Guardar]</button>
                </div>
            </form>

        </div>
    </div>
</div>
