<div id="modal-pastores" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="formulario-pastores" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="idotrospastores" class="input-sm entrada">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.nombre_completo') }}</label>
                            <input type="text" class="form-control input-sm entrada limpiar" name="nombrecompleto" />
                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.cargo') }}</label>
                            <select name="idcargo" id="idcargo" class="entrada selectizejs">
                               
                            </select>
                        </div>
           
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.tipo_documento') }}</label>
                            <select name="idtipodoc" id="idtipodoc" class="entrada selectizejs">
                            
                            </select>
                          
                        </div>

                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.numero_documento') }}</label>
                            <input type="text" class="form-control input-sm entrada" name="nrodoc" />
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.vigente')}}</label>

                            &nbsp;&nbsp;    
                            <input class="minimal entrada" type="checkbox" name="vigente" default-value="1">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.observaciones')}}</label>

                      
                            <textarea class="form-control input-sm entrada" name="observaciones" id="" cols="30" rows="4"></textarea>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-pastor">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-pastor" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>