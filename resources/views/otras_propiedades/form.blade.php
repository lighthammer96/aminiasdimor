<div id="modal-otras_propiedades" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-otras_propiedades" class="form-horizontal" role="form">

                <div class="modal-body">
                <input type="hidden" name="idotrapropiedad" class="input-sm entrada">
                    <div class="row">
                        
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.division") }}</label>

                            <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                            </select>

                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.pais") }}</label>

                            <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                            </select>

                        </div>
                        <div class="col-md-4 union">
                            <label class="control-label">{{ traducir("traductor.union") }}</label>

                            <select  class="entrada selectizejs" name="idunion" id="idunion">

                            </select>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                            <select  class="entrada selectizejs" name="idmision" id="idmision">

                            </select>

                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.distrito_misionero')}}</label>

                            <select name="iddistritomisionero" id="iddistritomisionero" class="selectizejs entrada"></select>

                        </div>

                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.iglesia')}}</label>

                            <select name="idiglesia" id="idiglesia" class="selectizejs entrada"></select>

                        </div>
                        
                    </div>
                    <div class="row">
                        
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.descripcion") }}</label>
                            <input type="text" class="form-control input-sm entrada" name="descripcion" placeholder="" />
                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir("traductor.cantidad") }}</label>
                            <input type="number" class="form-control input-sm entrada" name="cantidad" placeholder="" />
                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.tipo')}}</label>

                            <select name="tipo" id="tipo" class="form-control input-sm entrada">
                                <option value="">{{ traducir("traductor.seleccione") }}</option>
                                <option value="Terrenos sin construir">{{ traducir("traductor.terrenos_sinconstruir") }}</option>
                                <option value="Vehículos">{{ traducir("traductor.vehiculos") }}</option>
                                
                            </select>

                        </div>
                        
                    </div>
                  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-otras_propiedades"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-otras_propiedades" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar')}}]</button>    
                </div>
            </form>

        </div>
    </div>
</div>