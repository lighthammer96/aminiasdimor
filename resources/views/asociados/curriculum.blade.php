@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-curriculum" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <form id="formulario-curriculum" class="form-horizontal" role="form">
                <input type="hidden" name="idmiembro" id="idmiembro">
                <div class="modal-body">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                           
                       
                            <li class="active"><a class="modificar" href="#datos-familiares" data-toggle="tab">{{ traducir("traductor.datos_familiares") }}</a></li>
                         
                            <li><a class="modificar" href="#informacion-educacion" data-toggle="tab">{{ traducir("traductor.informacion_educacion") }}</a></li>
                            <li><a class="modificar" href="#experiencia-laboral" data-toggle="tab">{{ traducir("traductor.experiencia_laboral") }}</a></li>
                            
                          
                           
                        </ul>
                        <div class="tab-content">                            
                            <div class="tab-pane active" id="datos-familiares">
                                <div class="row">
                                   
                                    <div class="col-md-3" style="padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.parentesco') }}</label>
                                        <select class="entrada selectizejs limpiar-parentesco" name="parentesco" id="parentesco">

                                        </select>
                                    
                                    </div>

                                    <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir('traductor.nombres') }}</label>
                                        <input  type="text" class="form-control input-sm entrada limpiar-parentesco" name="nombre" placeholder="" />
                                    </div>
                                    
                                    <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir('traductor.tipo_documento') }}</label>
                                        <select name="tipodoc" id="tipodoc" class="entrada selectizejs limpiar-parentesco">
                                        
                                        </select>
                                    
                                    </div>
                                    <div class="col-md-3" style="padding-left: 5px;">
                                        <label class="control-label">{{ traducir('traductor.numero_documento') }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-parentesco" name="numdoc" />
                                    </div>
                                </div>

                                <div class="row">
                                   
                                    <div class="col-md-3" style="padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.fecha_nacimiento') }}</label>
                              

                                        <div class="input-group">
                                            <input type="text" class="form-control input-sm entrada limpiar-parentesco" name="fechanac" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                            <div class="input-group-addon" id="calendar-fechanac" style="cursor: pointer;">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                            
                                    
                                    </div>

                                    <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir('traductor.pais') }}</label>
                                        <select name="pais" id="pais" class="entrada selectizejs limpiar-parentesco">
                                        
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir('traductor.lugar_nacimiento') }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-parentesco" name="lugarnac" placeholder="" />
                                    
                                    </div>
                                


                                   
                                    <div class="col-md-3" style="margin-top: 27px; text-align: left;">
                                        <button type="button" class="btn btn-success btn-sm" id="agregar-parentesco">[{{ traducir("traductor.agregar") }}]</button> 

                                    </div>

                                </div>  

                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-parentesco">
                                            <thead>
                                                <tr>
                                                    <th style="width: 200px;">{{ traducir('traductor.parentesco') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.nombres') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.tipo_documento') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.numero_documento') }}</th>
                                                    <!-- <th style="width: 200px;">{{ traducir('traductor.institucion_iglesia') }}</th> -->
                                                    <th style="width: 200px;">{{ traducir('traductor.fecha_nacimiento') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.pais') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.lugar_nacimiento') }}</th>
                                                    <th style="width: 30px;">{{ traducir('traductor.eliminar') }}</th>
                                                </tr>

                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                               
                            </div>
                            

                        

                            <div class="tab-pane" id="informacion-educacion">
                                <div class="row">
                                    <div class="col-md-2" style="padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir("traductor.institucion") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-educacion" name="inst" placeholder="" />
                                    
                                    </div>
                                    <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir("traductor.nivel_estudios") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-educacion" name="nivel" placeholder="" />
                                    </div>
                                    <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir("traductor.profesion") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-educacion" name="prof" placeholder="" />
                                    </div>

                                    <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir("traductor.estado") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-educacion" name="est" placeholder="" />
                                    </div>
                                    

                                    
                                    <div class="col-md-2" style="margin-top: 27px; text-align: left;">
                                        <button type="button" class="btn btn-success btn-sm" id="agregar-educacion">[{{ traducir("traductor.agregar") }}]</button> 

                                    </div>

                                </div>
                               
                                <div class="row">
                                               
                                    <div class="col-md-12">
                                        <label class="control-label">{{ traducir('traductor.observaciones') }}</label>
                                        <textarea class="form-control input-sm entrada limpiar-educacion" name="obs"  cols="30" rows="2"></textarea>
                                        
                                    </div>
                                    
                                </div>

                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-educacion">
                                            <thead>
                                                <tr>
                                                    <th style="width: 200px;">{{ traducir('traductor.institucion') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.nivel_estudios') }}</th>
                                              
                                                    <th style="width: 200px;">{{ traducir('traductor.profesion') }}</th>
                                                    <th style="width: 200px;">{{ traducir('traductor.estado') }}</th>
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
                            
                            <div class="tab-pane" id="experiencia-laboral">
                                <div class="row">
                                    <div class="col-md-2" style="padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir("traductor.cargo") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-laboral" name="car" placeholder="" />
                                    
                                    </div>
                                    <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir("traductor.sector") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-laboral" name="sec" placeholder="" />
                                    </div>
                                    <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
                                        <label class="control-label">{{ traducir("traductor.institucion") }}</label>
                                        <input type="text" class="form-control input-sm entrada limpiar-laboral" name="insti" placeholder="" />
                                    </div>
                                    
                                    <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                        
                                        <label class="control-label">{{ traducir('traductor.periodo_ini') }}</label>
                                        <select class="entrada selectizejs limpiar-laboral" name="perini" id="perini">

                                        </select>
 
                                    </div>
                                    <div class="col-md-2" style="padding-left: 5px; padding-right: 5px;">
                                        <label class="control-label">{{ traducir('traductor.periodo_fin') }}</label>
                                        <select class="entrada selectizejs limpiar-laboral" name="perfin" id="perfin">

                                        </select>
                                    </div>
                                    

                                    
                                    <div class="col-md-2" style="margin-top: 27px; text-align: left;">
                                        <button type="button" class="btn btn-success btn-sm" id="agregar-laboral">[{{ traducir("traductor.agregar") }}]</button> 

                                    </div>

                                </div>
                               
                               

                                <div class="row" style="margin-top: 15px;">
                                    <div class="col-md-12">
                                        <table class="table table-striped table-bordered display compact" id="detalle-laboral">
                                            <thead>
                                                <tr>
                                                    <th style="width: 300px;">{{ traducir('traductor.cargo') }}</th>
                                                    <th style="width: 300px;">{{ traducir('traductor.sector') }}</th>
                                              
                                                    <th style="width: 300px;">{{ traducir('traductor.institucion') }}</th>
                                                    <th style="width: 300px;">{{ traducir('traductor.anio') }}</th>
                                                    
                                                
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
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-curriculum">[Esc] [{{ traducir("traductor.cancelar") }}]</button>
                        <button type="button" id="guardar-curriculum" class="btn btn-primary btn-sm">[F9] [{{ traducir("traductor.guardar") }}]</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>


@endsection