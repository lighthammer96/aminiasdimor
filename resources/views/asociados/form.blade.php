<div id="modal-asociados" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content" >

            <form id="formulario-asociados" class="form-horizontal" role="form">
                <input type="hidden" name="pais_id_change" id="pais_id_change">
                <div class="modal-body" style="max-height: 570px !important; overflow-y: scroll;">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#datos-generales" data-toggle="tab">{{ traducir("traductor.datos_generales") }}</a></li>
                            <li><a href="#informacion-eclesiastica" data-toggle="tab">{{ traducir("traductor.informacion_eclesiastica") }}</a></li>
                            <li><a class="modificar" href="#registro-administrativo" data-toggle="tab">{{ traducir("traductor.cargos") }}</a></li>
                            <li><a class="modificar" href="#historial-altas-bajas" data-toggle="tab">{{ traducir("traductor.historial_altas_bajas") }}</a></li>
                            <li><a class="modificar" href="#historial-traslados" data-toggle="tab">{{ traducir("traductor.historial_traslados") }}</a></li>
                            <li><a class="modificar" href="#capacitaciones" data-toggle="tab">{{ traducir("traductor.capacitaciones") }}</a></li>
                            
                          
                           
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="datos-generales">
                                <div class="row">
                                    <div class="col-md-9" style="padding-right: 5px;">
                                        <fieldset>
                                            <legend>{{ traducir("traductor.datos_personales") }}</legend>
                                            <div class="row">
                                                <input type="hidden" name="idmiembro" class="input-sm entrada">

                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.nombres") }}</label>
                                                    <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="nombres" placeholder="" />
                                                </div>
                                                <div class="col-md-4" style="padding-right: 5px;padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.apellidos") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="apellidos" placeholder="" />
                                                </div>
                                                <div class="col-md-4" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.apellido_soltera") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="apellido_soltera" placeholder="" />
                                                </div>
                                                
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.sexo") }}</label><br>
                                                    <input type="radio" name="sexo" value="M" class="minimal entrada" >&nbsp;{{ traducir("traductor.masculino") }}&nbsp;&nbsp;&nbsp;
                                                    <input type="radio" name="sexo" value="F" class="minimal entrada" >&nbsp;{{ traducir("traductor.femenino") }}
                                                </div>
                                                <div class="col-md-4" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.tipo_documento") }}</label>
                                                    <select class="entrada form-control input-sm select" name="idtipodoc" id="idtipodoc">

                                                    </select>
                                                   
                                                </div>
                                                <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.nrodoc") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="nrodoc" placeholder="" />
                                                </div>
                                                <div class="col-md-2" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.celular") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="celular" placeholder="" />
                                                </div>
                                              
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2" style="padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.telefono") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="telefono" placeholder="" />
                                                </div>
                                                <div class="col-md-5" style="padding-left: 5px; padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.email") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="email" placeholder="" />
                                                </div>
                                                <div class="col-md-5" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.email_alternativo") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="emailalternativo" placeholder="" />
                                                </div>
                                            </div>
                                        </fieldset>
                                        <fieldset>
                                            <legend>{{ traducir("traductor.domicilio") }}</legend>
                                            <div class="row">
                                                <div class="col-md-4 jerarquia" style="display: none; padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.departamento") }}</label>
                                                    <select class="entrada form-control input-sm select" name="iddepartamentodomicilio" id="iddepartamentodomicilio">

                                                    </select>
                                                </div>
                                                <div class="col-md-4 jerarquia" style="display: none; padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.provincia") }}</label>

                                                    <select class="entrada form-control input-sm select" name="idprovinciadomicilio" id="idprovinciadomicilio">

                                                    </select>



                                                </div>
                                                <div class="col-md-4 jerarquia" style="display: none; padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.distrito") }}</label>

                                                    <select class="entrada form-control input-sm select" name="iddistritodomicilio" id="iddistritodomicilio">

                                                    </select>


                                                </div>
                                            </div>
                                            <div class="row">
                                               
                                                <div class="col-md-6" style="padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.direccion") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="direccion" placeholder="" />
                                                </div>
                                                <div class="col-md-6" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.referencia") }}</label>
                                                    <input type="text" class="form-control input-sm entrada" name="referenciadireccion" placeholder="" />
                                                </div>
                                                
                                            </div>
                                        </fieldset>
                                        <fieldset>
                                            <legend>{{ traducir("traductor.nacimiento") }}</legend>
                                            <div class="row">
                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.fecha_nacimiento") }}</label>
                                                    

                                                    <div class="input-group">
                                                        <input type="text" class="form-control input-sm entrada" name="fechanacimiento" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                                        <div class="input-group-addon"  id="calendar-fechanacimiento" style="cursor: pointer;">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- <div class="col-md-2" style="padding-right: 5px; margin-top: 10px;">
                                                    <label class="control-label">Sexo</label><br>
                                                    <input type="radio" name="tipolugarnac" value="" checked="checked" class="minimal entrada" >&nbsp;&nbsp;&nbsp;<br>
                                                    <input type="radio" name="tipolugarnac" value="extranjero" class="minimal entrada" >&nbsp;&nbsp;&nbsp;Extranjero
                                                </div> -->
                                                <!-- <div class="col-md-4 " style="padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">Lugar de Nacimiento</label>
                                                    <select class="entrada selectizejs" name="iddepartamentonacimiento" id="iddepartamentonacimiento">

                                                    </select>
                                                </div>
                                                <div class="col-md-4 " style="margin-top: 7px; padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label"></label>

                                                    <select  class="entrada selectizejs" name="idprovincianacimiento" id="idprovincianacimiento">

                                                    </select>
                                                </div>
                                                <div class="col-md-4 " style="margin-top: 7px; padding-left: 5px;">
                                                    <label class="control-label"></label>

                                                    <select  class="entrada selectizejs" name="iddistritonacimiento" id="iddistritonacimiento">

                                                    </select>


                                                </div> -->
                                                <div class="col-md-4" style="padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.pais") }}</label>

                                                    <select class="entrada form-control input-sm select" name="pais_id_nacimiento" id="pais_id_nacimiento">

                                                    </select>
                                                </div>

                                                <div class="col-md-4" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.ciudad") }}</label>
                                                 
                                                    <input type="text" class="form-control input-sm entrada" name="ciudadnacextranjero" placeholder="" />
                                                </div>
                                            </div>
                                        </fieldset>
                                           

                                           
                                            <div class="row">
                                               
                                                <div class="col-md-4" style="padding-right: 5px;">
                                                    <label class="control-label">Estado Civil</label>
                                                    <select class="entrada form-control input-sm select" name="idestadocivil" id="idestadocivil">

                                                    </select>
                                                </div>
                                                <div class="col-md-4" style="padding-right: 5px; padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.nivel_educativo") }}</label>

                                                    <select class="entrada form-control input-sm select" name="idgradoinstruccion" id="idgradoinstruccion">

                                                    </select>
                                                </div>
                                                <div class="col-md-4" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir("traductor.profesion") }}</label>

                                                    <select class="entrada form-control input-sm select" name="idocupacion" id="idocupacion">

                                                    </select>
                                                </div>
                                                <!-- <div class="col-md-3" style="padding-left: 5px;">
                                                    <label class="control-label">idad</label>

                                                    <select class="entrada selectizejs" name="pais_id_idad" id="pais_id_idad">

                                                    </select>
                                                </div> -->
                                            </div>

                                            <div class="row">
                                               
                                                <div class="col-md-6" style="padding-right: 5px;">
                                                    <label class="control-label">{{ traducir('traductor.idiomas') }}</label>
                                                    <textarea class="form-control input-sm entrada" name="idiomas"  cols="30" rows="2"></textarea>
                                                    
                                                </div>

                                                <div class="col-md-6" style="padding-left: 5px;">
                                                    <label class="control-label">{{ traducir('traductor.observaciones') }}</label>
                                                    <textarea class="form-control input-sm entrada" name="observaciones"  cols="30" rows="2"></textarea>
                                                    
                                                </div>
                                                
                                            </div>
                                            

                                       
                                    </div>
                                    <div class="col-md-3" style="padding-left: 5px;">
                                        <div class="row">
                                            
                                            <div class="col-md-12" style="margin-top: 9px;">
                                                <center>
                                                    <img title="Cargar Foto ..." style="cursor: pointer;height: 105px !important;" src="{{ URL::asset('images/camara.png') }}" class="thumb-lg img-thumbnail usuario_foto" alt="profile-image" id="cargar_foto">
                                                    <input style="display: none;" type="file" class="form-control input-sm entrada" name="foto" id="foto">
                                                </center>
                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias">
                                                <label class="control-label">{{ traducir("traductor.division") }}</label>

                                                <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                                                </select>

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias">
                                                <label class="control-label">{{ traducir("traductor.pais") }}</label>

                                                <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                                                </select>

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias union">
                                                <label class="control-label">{{ traducir("traductor.union") }}</label>

                                                <select  class="entrada selectizejs" name="idunion" id="idunion">

                                                </select>

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias">
                                                <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                                                <select  class="entrada selectizejs" name="idmision" id="idmision">

                                                </select>

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias">
                                                <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>

                                                <select  class="entrada selectizejs" name="iddistritomisionero" id="iddistritomisionero">

                                                </select>

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias">
                                                <label class="control-label">{{ traducir("traductor.iglesia") }}</label>

                                                <select  class="entrada selectizejs" name="idiglesia" id="idiglesia">

                                                </select>

                                            </div>

                                            <div class="col-md-12 jerarquia-iglesias-descripcion">
                                                <label class="control-label">{{ traducir("traductor.division") }}</label>
                                                <input type="text" readonly="readonly" class="form-control input-sm entrada" name="division" placeholder="" />
                                               

                                            </div>

                                            <div class="col-md-12 jerarquia-iglesias-descripcion">
                                                <label class="control-label">{{ traducir("traductor.pais") }}</label>
                                                <input type="text" readonly="readonly" class="form-control input-sm entrada" name="pais" placeholder="" />
                                               

                                            </div>

                                            <div class="col-md-12 jerarquia-iglesias-descripcion union-descripcion">
                                                <label class="control-label">{{ traducir("traductor.union") }}</label>
                                                <input type="text" readonly="readonly" class="form-control input-sm entrada" name="union" placeholder="" />
                                               

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias-descripcion">
                                                <label class="control-label">{{ traducir("traductor.asociacion") }}</label>
                                                <input type="text" readonly="readonly" class="form-control input-sm entrada" name="asociacion" placeholder="" />
                                               

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias-descripcion">
                                                <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>
                                                <input type="text" readonly="readonly" class="form-control input-sm entrada" name="distrito_misionero" placeholder="" />
                                               

                                            </div>
                                            <div class="col-md-12 jerarquia-iglesias-descripcion">
                                                <label class="control-label">{{ traducir("traductor.iglesia") }}</label>
                                                <input type="text" readonly="readonly" class="form-control input-sm entrada" name="iglesia" placeholder="" />
                                               

                                            </div>
                                            <div class="col-md-12" style="">
                                                <label class="control-label">{{ traducir("traductor.fecha_ingreso") }}</label>
                                                

                                                <div class="input-group">
                                                    <input type="text" class="form-control input-sm entrada" name="fechaingresoiglesia" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                                    <div class="input-group-addon"  id="calendar-fechaingresoiglesia" style="cursor: pointer;">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <h2 id="estado_asociado" style="text-align: center; font-weight: 600;"></h2>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="tab-pane" id="informacion-eclesiastica">
                                <div class="row">
                                    <div class="col-md-3">
                        
                                        <label class="control-label">{{ traducir('traductor.condicion_eclesiastica') }}</label>
                                        <select class="entrada form-control input-sm select" name="idcondicioneclesiastica" id="idcondicioneclesiastica">

                                        </select>
                                    
                                    </div>

                                    <div class="col-md-2" style="padding-right: 5px;">
                                        <label class="control-label">{{ traducir('traductor.fecha_bautizo') }}</label>
                                        

                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm entrada" name="fechabautizo" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                            <div class="input-group-addon"  id="calendar-fechabautizo" style="cursor: pointer;">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="hidden" name="encargado_bautizo" class="input-sm entrada datos-encargado-bautizo">
                                        
                                        <input type="hidden" name="tabla_encargado_bautizo" class="input-sm entrada datos-encargado-bautizo" >

                                        <label for="" class="control-label">{{ traducir('traductor.responsable') }}</label>
                                        
                                        <div class="input-group">
                                            <input readonly="readonly" type="text" class="form-control input-sm entrada datos-encargado-bautizo" name="responsable_bautizo" placeholder="Buscar Responsable...">
                                            <span class="input-group-btn">
                                                <button type="button" id="buscar-encargado-bautizo" class="btn btn-primary btn-sm"><i class="fa fa-search"></i></button>
                                            
                                            </span>

                                        </div>
                                    </div>
                                    <div class="col-md-3">
                        
                                        <label class="control-label">{{ traducir('traductor.procedencia_religiosa') }}</label>
                                        <select class="entrada form-control input-sm select" name="idreligion" id="idreligion">

                                        </select>
                                    
                                    </div>
                                </div>
                                <div class="row">
                                                
                                    <div class="col-md-6">
                                    
                                        <label class="control-label">{{ traducir("traductor.texto_bautismal") }}</label>
                                        
                                        <input type="text" class="form-control input-sm entrada" name="texto_bautismal" placeholder="" />
                                    
                                        
                                    </div>
                                    
                                </div>
                               
                                <div class="row">
                                               
                                    <div class="col-md-12">
                                        <label class="control-label">{{ traducir("traductor.observaciones") }}</label>
                                        <textarea class="form-control input-sm entrada" name="observaciones_bautizo"  cols="30" rows="4"></textarea>
                                        
                                    </div>
                                    
                                </div>

                                <div class="row" style="margin-top: 20px; text-align: right;">
                                    <div class="col-md-2 col-md-offset-10">
                                        <button type="button" class="btn btn-success btn-sm" id="imprimir-ficha-bautizo">Ficha Bautizo</button>
                                    </div>
                                </div>
                               
                            </div>
                            
                            <div class="tab-pane" id="registro-administrativo">
                                <div class="row">
                                    <input type="hidden" name="lugar" id="lugar" class="limpiar-cargos">
                                    <input type="hidden" name="idlugar" id="idlugar" class="limpiar-cargos">
                                    <input type="hidden" name="tabla" id="tabla" class="limpiar-cargos">
                                    <div class="col-md-2" style="padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.tipo_cargo') }}</label>
                                        <select class="entrada form-control input-sm select limpiar-cargos" name="idtipocargo" id="idtipocargo">

                                        </select>
                                    
                                    </div>

                                    <div class="col-md-3 nivel" style="padding-left: 5px; padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.nivel') }}</label>
                                        <select class="entrada form-control input-sm select limpiar-cargos" name="idnivel" id="idnivel">

                                        </select>
                                    
                                    </div>

                                    <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.cargo') }}</label>
                                        <select class="entrada form-control input-sm select limpiar-cargos" name="idcargo" id="idcargo">

                                        </select>
                                    
                                    </div>

                                    <!-- <div class="col-md-2">
                        
                                        <label class="control-label">{{ traducir('traductor.institucion_iglesia') }}</label>
                                        <select class="entrada selectizejs" name="idinstitucion" id="idinstitucion">g

                                        </select>
                                    
                                    </div> -->

                                    <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.periodo_ini') }}</label>
                                        <select class="entrada selectizejs limpiar-cargos" name="periodoini" id="periodoini">

                                        </select>
 
                                    </div>
                                    <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                        <label class="control-label">{{ traducir('traductor.periodo_fin') }}</label>
                                        <select class="entrada selectizejs limpiar-cargos" name="periodofin" id="periodofin">

                                        </select>
                                    </div>
                                    <div class="col-md-1" style="margin-top: 27px; text-align: right; padding-left: 5px;">
                                        <button type="button" class="btn btn-success btn-sm" id="agregar-cargo">[Agregar]</button> 

                                    </div>

                                </div>
                                
                                <div class="row">
                                    <div class="col-md-2 division-cargo jerarquia-cargos" style="display:none; padding-right: 5px;">
                                        <label class="control-label">{{ traducir("traductor.division") }}</label>

                                        <select  class="entrada selectizejs limpiar-cargos" name="iddivisioncargo" id="iddivisioncargo">

                                        </select>

                                    </div>
                                    <div class="col-md-2 pais-cargo jerarquia-cargos" style="display:none; padding-left: 5px; padding-right: 5px;">
                                        <label class="control-label">{{ traducir("traductor.pais") }}</label>

                                        <select  class="entrada selectizejs limpiar-cargos" name="pais_idcargo" id="pais_idcargo">

                                        </select>

                                    </div>
                                    <div class="col-md-2 union-cargo jerarquia-cargos" style="display:none; padding-left: 5px; padding-right: 5px;">
                                        <label class="control-label">{{ traducir("traductor.union") }}</label>

                                        <select  class="entrada selectizejs limpiar-cargos" name="idunioncargo" id="idunioncargo">

                                        </select>

                                    </div>
                                    <div class="col-md-2 asociacion-cargo jerarquia-cargos" style="display:none; padding-left: 5px; padding-right: 5px;">
                                        <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                                        <select  class="entrada selectizejs limpiar-cargos" name="idmisioncargo" id="idmisioncargo">

                                        </select>

                                    </div>
                                    <div class="col-md-2 distrito-misionero-cargo jerarquia-cargos" style="display:none; padding-left: 5px; padding-right: 5px;"> 
                                        <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>

                                        <select  class="entrada selectizejs limpiar-cargos" name="iddistritomisionerocargo" id="iddistritomisionerocargo">

                                        </select>

                                    </div>
                                    <div class="col-md-2 iglesia-cargo jerarquia-cargos" style="display:none; padding-left: 5px;">
                                        <label class="control-label">{{ traducir("traductor.iglesia") }}</label>

                                        <select  class="entrada selectizejs limpiar-cargos" name="idiglesiacargo" id="idiglesiacargo">

                                        </select>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4" style="">
                                        <label class="control-label">{{ traducir("traductor.condicion") }}</label><br>
                                        <input type="radio" name="condicion" value="R" class="minimal entrada limpiar-cargos" >&nbsp;{{ traducir("traductor.remunerado") }} &nbsp;&nbsp;&nbsp;
                                        <input type="radio" name="condicion" value="N" class="minimal entrada limpiar-cargos" >&nbsp;{{ traducir("traductor.no_remunerado") }} &nbsp;&nbsp;&nbsp;
                                       
                                    </div>
                                    <div class="col-md-4" style="">
                                        <label class="control-label">{{ traducir("traductor.tiempo") }}</label><br>
                                       
                                        <input type="radio" name="tiempo" value="C" class="minimal entrada limpiar-cargos" >&nbsp;{{ traducir("traductor.tiempo_completo") }} &nbsp;&nbsp;&nbsp;
                                        <input type="radio" name="tiempo" value="P" class="minimal entrada limpiar-cargos" >&nbsp;{{ traducir("traductor.tiempo_parcial") }} &nbsp;&nbsp;&nbsp;
                                    </div>
                                </div>
                                <div class="row">
                                               
                                    <div class="col-md-12">
                                        <label class="control-label">{{ traducir('traductor.observaciones') }}</label>
                                        <textarea class="form-control input-sm entrada limpiar-cargos" name="observaciones_cargo"  cols="30" rows="2"></textarea>
                                        
                                    </div>
                                    
                                </div>

                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-cargos">
                                            <thead>
                                                <tr>
                                                    <th style="width: 200px;">{{ traducir('traductor.tipo_cargo') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.nivel') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.cargo') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.lugar') }}</th>
                                                    <!-- <th style="width: 200px;">{{ traducir('traductor.institucion_iglesia') }}</th> -->
                                                    <th style="width: 200px;">{{ traducir('traductor.anio') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.condicion') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.tiempo') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.observaciones') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.vigente') }}</th>
                                                    <th style="width: 30px;">{{ traducir('traductor.eliminar') }}</th>
                                                </tr>

                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                               
                            </div>
                            <div class="tab-pane" id="historial-altas-bajas">
                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-historial">
                                            <thead>
                                                <tr>
                                                    <th style="width: 200px;">{{ traducir('traductor.tipo') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.motivo') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.responsable') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.fecha') }}</th>
                                                    <th style="width: 300px;">{{ traducir('traductor.observaciones') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.nuevo_bautismo') }}</th>
                                                
                                                </tr>

                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                
                                </div>

                            </div>

                            <div class="tab-pane" id="historial-traslados">
                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-traslados">
                                            <thead>
                                                <tr>
                                                    <th style="width: 500px;">{{ traducir('traductor.iglesia_anterior') }}</th>
                                                    <th style="width: 500px;">{{ traducir('traductor.iglesia_traslado') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.fecha') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.imprimir') }}</th>
                                                    
                                                
                                                </tr>

                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                
                                </div>

                            </div>

                            <div class="tab-pane" id="capacitaciones">
                                <div class="row">
                                    <div class="col-md-2">
                        
                                        <label class="control-label">{{ traducir('traductor.anio') }}</label>
                                        <select class="entrada selectizejs limpiar-capacitacion" name="anio" id="anio">

                                        </select>
                                    
                                    </div>
                                    <div class="col-md-4" style="padding-right: 5px;">
                                        <label class="control-label">{{ traducir("traductor.capacitacion") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-capacitacion" name="capacitacion" placeholder="" />
                                    </div>
                                    <div class="col-md-4" style="padding-right: 5px;">
                                        <label class="control-label">{{ traducir("traductor.centro_estudios") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-capacitacion" name="centro_estudios" placeholder="" />
                                    </div>
                                    

                                    
                                    <div class="col-md-2" style="margin-top: 27px;">
                                        <button type="button" class="btn btn-success btn-sm" id="agregar-capacitacion">[{{ traducir("traductor.agregar") }}]</button> 

                                    </div>

                                </div>
                               
                                <div class="row">
                                               
                                    <div class="col-md-12">
                                        <label class="control-label">{{ traducir('traductor.observaciones') }}</label>
                                        <textarea class="form-control input-sm entrada limpiar-capacitacion" name="observaciones_capacitacion"  cols="30" rows="2"></textarea>
                                        
                                    </div>
                                    
                                </div>

                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-capacitacion">
                                            <thead>
                                                <tr>
                                                    <th style="width: 200px;">{{ traducir('traductor.anio') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.capacitacion') }}</th>
                                              
                                                    <th style="width: 200px;">{{ traducir('traductor.centro_estudios') }}</th>
                                                    <th style="width: 400px;">{{ traducir('traductor.observaciones') }}</th>
                                                
                                                    <th style="width: 30px;">{{ traducir('traductor.eliminar') }}</th>
                                                </tr>

                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                               
                            </div>

                    </div>

                    
                </div>
                <div class="modal-footer">
                    <div class="pull-left" id="bajas_altas">
                        
                    </div>
                    <div class="pull-rigth">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-asociado">[Esc] [{{ traducir("traductor.cancelar") }}]</button>
                        <button type="button" id="guardar-asociado" class="btn btn-primary btn-sm">[F9] [{{ traducir("traductor.guardar") }}]</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
