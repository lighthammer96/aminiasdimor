
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
                            <select name="iddepartamento" id="iddepartamento" class="selectizejs entrada"></select>
                            <!-- <div class="input-group m-bot15 col-md-12 sin-padding">
                                

                                <span class="input-group-btn">
                                    <button style="margin-top: -5px;" type="button" id="nuevo-departamento" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                </span>

                            </div> -->

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-provincia"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar') }}]</button>
                    <button type="button" id="guardar-provincia" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar') }}]</button>
                </div>
            </form>

        </div>
    </div>
</div>