<div id="modal-instituciones" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-instituciones" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="idinstitucion" class="input-sm entrada">
                        <!-- <div class="col-md-6">
                            <label class="control-label">Descripcion</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="perfil_descripcion"  placeholder="Nuevo Perfil ..."/>

                        </div> -->
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">ACTIVO</option>
                                <option value="I">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.idioma')}}</label>

                            <div class="input-group">
                                <select data-placeholder="Seleccione Idioma " name="idioma" id="idioma" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button type="button" id="nuevo-idioma" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div>

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>
                            <input type="text" class="form-control input-sm entrada limpiar" name="descripcion" />
                        </div>

                    </div>
                  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-institucion">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-institucion" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>    
                </div>
            </form>

        </div>
    </div>
</div>