
<div id="modal-iglesias" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-iglesias" class="form-horizontal" role="form">
                
                <div class="modal-body">
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
                            <label class="control-label">{{ traducir('traductor.categoria_iglesia')}}</label>

                            <select name="idcategoriaiglesia" id="idcategoriaiglesia" class="selectizejs entrada"></select>
                        </div>
                    </div>
                    <div class="row">
                        <input type="hidden" name="idiglesia" class="input-sm entrada">
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.descripcion')}}</label>

                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="descripcion"  placeholder=""/>

                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.direccion')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="direccion"  placeholder=""/>

                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.telefono')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="telefono"  placeholder=""/>

                        </div>
                       
                      
                    </div>
                   
            
                    <div class="row">
                        
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.tipo_estructura')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="tipoestructura"  placeholder=""/>

                        </div>
                        <div class="col-md-2">
                            <label class="control-label">{{ traducir('traductor.area')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="area"  placeholder=""/>

                        </div>
                        <div class="col-md-2">
                            <label class="control-label">{{ traducir('traductor.valor')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="valor"  placeholder=""/>

                        </div>
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.documento_propiedad')}}</label>

                            <input type="text" class="form-control input-sm entrada" name="documentopropiedad"  placeholder=""/>

                        </div>
                       
                    </div>

                    <!-- <div class="row">
                        
                  
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.tipo_construccion')}}</label>

                            <select name="idtipoconstruccion" id="idtipoconstruccion" class="selectizejs entrada"></select>
                        </div>
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.tipo_documentacion')}}</label>

                            <select name="idtipodocumentacion" id="idtipodocumentacion" class="selectizejs entrada"></select>
                        </div>
                       
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.tipo_inmueble')}}</label>

                            <select name="idtipoinmueble" id="idtipoinmueble" class="selectizejs entrada"></select>
                        </div>
                        
                        
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('traductor.condicion_inmueble')}}</label>

                            <select name="idcondicioninmueble" id="idcondicioninmueble" class="selectizejs entrada"></select>
                        </div>
                       
                    </div> -->
                    <div class="row">
                        <div class="col-md-4 jerarquia" style="padding-right: 5px;">
                            <label class="control-label">{{ traducir('traductor.departamento')}}</label>
                            <select class="entrada selectizejs" name="iddepartamento" id="iddepartamento">

                            </select>
                        </div>
                        <div class="col-md-4 jerarquia" style="padding-right: 5px; padding-left: 5px;">
                            <label class="control-label">{{ traducir('traductor.provincia')}}</label>

                            <select class="entrada selectizejs" name="idprovincia" id="idprovincia">

                            </select>



                        </div>
                        <div class="col-md-4 jerarquia" style="padding-left: 5px;">
                            <label class="control-label">{{ traducir('traductor.distrito')}}</label>

                            <select class="entrada selectizejs" name="iddistrito" id="iddistrito">

                            </select>


                        </div>
                    </div>
                    <div class="row">
                        
                        <div class="col-md-4">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="1">
                                <option value="1">ACTIVO</option>
                                <option value="0">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                                               
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('traductor.observaciones')}}</label>
                            <textarea class="form-control input-sm entrada" name="observaciones" id="" cols="30" rows="2"></textarea>
                            
                        </div>
                        
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-left" id="botones_iglesia">
                        
                    </div>
                    <div class="pull-right">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-iglesia">[Esc] [{{ traducir('cancelar') }}]</button>
                        <button type="button" id="guardar-iglesia" class="btn btn-primary btn-sm">[F9] [{{ traducir('guardar') }}]</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>