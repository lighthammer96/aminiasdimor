
<div id="modal-provincias" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">

            <form id="formulario-provincias" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="idprovincia" class="input-sm entrada">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="descripcion"  placeholder=""/>

                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.departamento')}}</label>

                            <div class="input-group m-bot15 col-md-12 sin-padding">
                                <select name="iddepartamento" id="iddepartamento" class="selectizejs entrada"></select>

                                <span class="input-group-btn">
                                    <button style="margin-top: -5px;" type="button" id="nuevo-departamento" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-provincia">[Esc] [{{ traducir('cancelar') }}]</button>
                    <button type="button" id="guardar-provincia" class="btn btn-primary btn-sm">[F9] [{{ traducir('guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>