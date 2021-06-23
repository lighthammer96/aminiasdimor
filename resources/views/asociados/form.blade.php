<div id="modal-asociados" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <form id="formulario-asociados" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#datos-generales" data-toggle="tab">Datos Generales</a></li>
                            <li><a href="#informacion-eclesiastica" data-toggle="tab">Información Eclesiástica</a></li>
                            
                          
                           
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="datos-generales">
                                <div class="row">
                                    <div class="col-md-9" style="padding-right: 5px;">
                                        <fieldset>
                                            <legend>Datos Personales</legend>
                                            <div class="row">
                                                <input type="hidden" name="idmiembro" class="input-sm entrada">

                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">Nombres</label>
                                                    <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="nombres" placeholder="" />
                                                </div>
                                                <div class="col-md-4" style="padding-right: 5px;padding-left: 5px;">
                                                    <label class="control-label">Apellidos</label>
                                                    <input type="text" class="form-control input-sm entrada" name="apellidos" placeholder="" />
                                                </div>
                                                <div class="col-md-4" style="padding-left: 5px;">
                                                    <label class="control-label">Apellido Soltera</label>
                                                    <input type="text" class="form-control input-sm entrada" name="apellido_soltera" placeholder="" />
                                                </div>
                                                
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">Sexo</label><br>
                                                    <input type="radio" name="sexo" value="M" class="minimal entrada" >&nbsp;Masculino&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="sexo" value="F" class="minimal entrada" >&nbsp;Femenino
                                                </div>
                                                <div class="col-md-4" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">Tipo de Documento</label>
                                                    <select class="entrada selectizejs" name="idtipodoc" id="idtipodoc">

                                                    </select>
                                                   
                                                </div>
                                                <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">Nro. Doc.</label>
                                                    <input type="text" class="form-control input-sm entrada" name="nrodoc" placeholder="" />
                                                </div>
                                                <div class="col-md-2" style="padding-left: 5px;">
                                                    <label class="control-label">Celular</label>
                                                    <input type="text" class="form-control input-sm entrada" name="celular" placeholder="" />
                                                </div>
                                              
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2" style="padding-right: 5px;">
                                                    <label class="control-label">Teléfono</label>
                                                    <input type="text" class="form-control input-sm entrada" name="telefono" placeholder="" />
                                                </div>
                                                <div class="col-md-5" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">Email</label>
                                                    <input type="text" class="form-control input-sm entrada" name="email" placeholder="" />
                                                </div>
                                                <div class="col-md-5" style="padding-left: 5px;">
                                                    <label class="control-label">Email Alternativo</label>
                                                    <input type="text" class="form-control input-sm entrada" name="emailalternativo" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">Lugar de Domicilio</label>
                                                    <select class="entrada selectizejs" name="iddepartamentodomicilio" id="iddepartamentodomicilio">

                                                    </select>
                                                </div>
                                                <div class="col-md-4" style="margin-top: 7px; padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label"></label>

                                                    <select class="entrada selectizejs" name="idprovinciadomicilio" id="idprovinciadomicilio">

                                                    </select>



                                                </div>
                                                <div class="col-md-4" style="margin-top: 7px; padding-left: 5px;">
                                                    <label class="control-label"></label>

                                                    <select class="entrada selectizejs" name="iddistritodomicilio" id="iddistritodomicilio">

                                                    </select>


                                                </div>
                                            </div>
                                            <div class="row">
                                               
                                                <div class="col-md-5" style="padding-right: 5px;">
                                                    <label class="control-label">Dirección</label>
                                                    <input type="text" class="form-control input-sm entrada" name="direccion" placeholder="" />
                                                </div>
                                                <div class="col-md-4" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">Referencia</label>
                                                    <input type="text" class="form-control input-sm entrada" name="referenciadireccion" placeholder="" />
                                                </div>
                                                <div class="col-md-3" style="padding-left: 5px;">
                                                    <label class="control-label">Fecha Nacimiento</label>
                                                    

                                                    <div class="input-group">
                                                        <input type="text" class="form-control input-sm entrada" name="fechanacimiento" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                           

                                            <div class="row">
                                                <div class="col-md-2" style="padding-right: 5px; margin-top: 10px;">
                                                    <!-- <label class="control-label">Sexo</label><br> -->
                                                    <input type="radio" name="tipolugarnac" value="nacional" checked="checked" class="minimal entrada" >&nbsp;&nbsp;&nbsp;Nacional<br>
                                                    <input type="radio" name="tipolugarnac" value="extranjero" class="minimal entrada" >&nbsp;&nbsp;&nbsp;Extranjero
                                                </div>
                                                <div class="col-md-4 nacional" style="padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">Lugar de Nacimiento</label>
                                                    <select class="entrada selectizejs" name="iddepartamentonacimiento" id="iddepartamentonacimiento">

                                                    </select>
                                                </div>
                                                <div class="col-md-3 nacional" style="margin-top: 7px; padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label"></label>

                                                    <select  class="entrada selectizejs" name="idprovincianacimiento" id="idprovincianacimiento">

                                                    </select>
                                                </div>
                                                <div class="col-md-3 nacional" style="margin-top: 7px; padding-left: 5px;">
                                                    <label class="control-label"></label>

                                                    <select  class="entrada selectizejs" name="iddistritonacimiento" id="iddistritonacimiento">

                                                    </select>


                                                </div>
                                                <div class="col-md-3 extranjero" style="padding-left: 5px; display: none">
                                                    <label class="control-label">País</label>

                                                    <select class="entrada selectizejs" name="pais_id_nacimiento" id="pais_id_nacimiento">

                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                               
                                                <div class="col-md-3" style="padding-right: 5px;">
                                                    <label class="control-label">Estado Civil</label>
                                                    <select class="entrada selectizejs" name="idestadocivil" id="idestadocivil">

                                                    </select>
                                                </div>
                                                <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">Nivel Educativo</label>

                                                    <select class="entrada selectizejs" name="idgradoinstruccion" id="idgradoinstruccion">

                                                    </select>
                                                </div>
                                                <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">Profesión</label>

                                                    <select class="entrada selectizejs" name="idocupacion" id="idocupacion">

                                                    </select>
                                                </div>
                                                <div class="col-md-3" style="padding-left: 5px;">
                                                    <label class="control-label">Nacionalidad</label>

                                                    <select class="entrada selectizejs" name="pais_id_nacionalidad" id="pais_id_nacionalidad">

                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3" style="padding-right: 5px;">
                                                    <label class="control-label">Fecha Registro</label>
                                                    

                                                    <div class="input-group">
                                                        <input type="text" class="form-control input-sm entrada" name="fecharegistro" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-9">
                                                    <label class="control-label">Observaciones</label>
                                                    <textarea class="form-control input-sm entrada" name="observaciones" id="" cols="30" rows="2"></textarea>
                                                   
                                                </div>
                                                
                                            </div>

                                        </fieldset>
                                    </div>
                                    <div class="col-md-3" style="padding-left: 5px;">
                                        <div class="row">
                                            <div class="col-md-12" style="margin-top: 9px;">
                                                <center>
                                                    <img title="Cargar Foto ..." style="cursor: pointer;height: 105px !important;" src="{{ URL::asset('images/camara.png') }}"" class="thumb-lg img-thumbnail usuario_foto" alt="profile-image" id="cargar_foto">
                                                    <input style="display: none;" type="file" class="form-control inpur-sm entrada" name="foto" id="foto">
                                                </center>
                                            </div>
                                            <div class="col-md-12">
                                                <label class="control-label">División</label>

                                                <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                                                </select>

                                            </div>
                                            <div class="col-md-12">
                                                <label class="control-label">País</label>

                                                <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                                                </select>

                                            </div>
                                            <div class="col-md-12 union">
                                                <label class="control-label">Unión</label>

                                                <select  class="entrada selectizejs" name="idunion" id="idunion">

                                                </select>

                                            </div>
                                            <div class="col-md-12">
                                                <label class="control-label">Asociación/Misión</label>

                                                <select  class="entrada selectizejs" name="idmision" id="idmision">

                                                </select>

                                            </div>
                                            <div class="col-md-12">
                                                <label class="control-label">Distrito Misionero</label>

                                                <select  class="entrada selectizejs" name="iddistritomisionero" id="iddistritomisionero">

                                                </select>

                                            </div>
                                            <div class="col-md-12">
                                                <label class="control-label">Iglesia</label>

                                                <select  class="entrada selectizejs" name="idiglesia" id="idiglesia">

                                                </select>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="tab-pane" id="informacion-eclesiastica">

                            </div>

                           

                        </div>

                    </div>

                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-asociado">[Esc] [Cancelar]</button>
                    <button type="button" id="guardar-asociado" class="btn btn-primary btn-sm">[F9] [Guardar]</button>
                </div>
            </form>

        </div>
    </div>
</div>