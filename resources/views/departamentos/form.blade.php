
<div id="modal-departamentos" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-departamentos" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="iddepartamento" class="input-sm entrada">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="descripcion"  placeholder=""/>

                        </div>
                      
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.pais')}}</label>

                            <div class="input-group m-bot15 col-md-12 sin-padding">
                                <select name="pais_id" id="pais_id" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button type="button" id="nuevo-pais" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div>

                        </div>
                        
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-departamento">[Esc] [{{ traducir('cancelar') }}]</button>
                    <button type="button" id="guardar-departamento" class="btn btn-primary btn-sm">[F9] [{{ traducir('guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>