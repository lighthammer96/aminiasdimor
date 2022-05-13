
<div id="modal-idiomas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-idiomas" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="idioma_id" class="input-sm entrada">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.codigo')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="idioma_codigo"  placeholder="" maxlength="2"/>

                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="idioma_descripcion"  placeholder=""/>

                        </div>
                
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.por_defecto')}}</label>
                            <select name="por_defecto" id="por_defecto" class="form-control input-sm entrada" default-value="N">
                                <option value="N">NO</option>
                                <option value="S">SI</option>
                            </select>
                        </div>
                    
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">ACTIVO</option>
                                <option value="I">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-idioma"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-idioma" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>
