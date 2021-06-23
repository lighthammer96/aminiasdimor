
<div id="modal-perfiles" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-perfiles" class="form-horizontal" role="form">
                
                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="perfil_id" class="input-sm entrada">
                        <!-- <div class="col-md-6">
                            <label class="control-label">Descripcion</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="perfil_descripcion"  placeholder="Nuevo Perfil ..."/>

                        </div> -->
                        <div class="col-md-6">
                            <label class="control-label">Estado</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">ACTIVO</option>
                                <option value="I">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                           <div class="col-md-6">
                                <label class="control-label">Idioma</label>

                                <div class="input-group m-bot15 col-md-12 sin-padding">
                                    <select data-placeholder="Seleccione Idioma " name="idioma" id="idioma" class="selectizejs entrada"></select>

                                    <span class="input-group-btn">
                                        <button type="button" id="nuevo-idioma" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                                    </span>

                                </div>

                           </div>
                           <div class="col-md-6">
                               <label class="control-label">Descripcion</label>
                               <input type="text" class="form-control input-sm entrada limpiar" name="descripcion" />
                           </div>

                       </div>
                       <div class="row" style="margin-top: 15px;">
                           <div class="col-md-12">
                               <table class="table table-striped table-bordered display compact" id="detalle-traducciones" style="font-size: 13px;">
                                   <thead>
                                       <tr>
                                           <th style="width: 100px;">Idioma</th>
                                           <th style="width: 200px;">Descripcion</th>
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
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-perfil">[Esc] [Cancelar]</button>
                    <button type="button" id="guardar-perfil" class="btn btn-primary btn-sm">[F9] [Guardar]</button>
                </div>
            </form>

        </div>
    </div>
</div>