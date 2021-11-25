@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<form id="form" class="form-horizontal" role="form" style="min-height: 300px;">

    <div class="row">
        <div class="col-md-12">
            <label for="">{{ traducir('asambleas.filtrar_por')}} :</label>
        </div>
    </div>
    <div class="row">
        
        <div class="col-md-6">
            <label class="control-label">{{ traducir('traductor.nombres')}}</label>
            <input type="text" class="form-control input-sm entrada limpiar" name="nombres" />
        </div>
        <div class="col-md-3">
            <label class="control-label">{{ traducir('asambleas.grado_instruccion')}}</label>
            <select name="idgradoinstruccion" id="idgradoinstruccion" class="selectizejs entrada" >
               
            </select>
        </div>
        <div class="col-md-3">
            <label class="control-label">{{ traducir('traductor.ocupacion')}}</label>
            <select name="idocupacion" id="idocupacion" class="selectizejs entrada">
                
            </select>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2" style="">
                            
            <label class="control-label">{{ traducir('traductor.tipo_cargo') }}</label>
            <select class="entrada selectizejs" name="idtipocargo" id="idtipocargo">

            </select>
        
        </div>

        <div class="col-md-3" style="">

            <label class="control-label">{{ traducir('traductor.nivel') }}</label>
            <select class="entrada selectizejs" name="idnivel" id="idnivel">

            </select>
        
        </div>

        <div class="col-md-3" style="">

            <label class="control-label">{{ traducir('traductor.cargo') }}</label>
            <select class="entrada selectizejs" name="idcargo" id="idcargo">

            </select>
        
        </div>
        <div class="col-md-1" style="margin-top: 7px;">
            <button id="filtrar" type="button" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/lupa.png') }}" ><br>{{ traducir('asambleas.filtrar') }}</button>
        </div>

        <div class="col-md-1" style="margin-top: 7px; display: none;" id="boton-asignar">
            <button type="button" id="asignar" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>{{ traducir('asambleas.asignar') }}</button>
        </div>

        <div class="col-md-1" style="margin-top: 7px;" id="boton-imprimir">
            <button type="button" id="imprimir" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/printer.png') }}" ><br>{{ traducir('traductor.imprimir') }}</button>
        </div>

        <div class="col-md-1" style="margin-top: 7px;" id="boton-notificar">
            <button type="button" id="notificar" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/importante.png') }}" ><br>{{ traducir('asambleas.notificar') }}</button>
        </div>
    </div>

    <div class="row" style="margin-top: 20px;">
        <div class="col-md-12">
            <table class="table table-striped table-bordered display compact" id="asociados" style="font-size: 13px; display: none;">
                <thead>
                    <tr>
                        <th style="width: 200px;">{{ traducir('traductor.nombres')}}</th>
                        <th style="width: 100px;">{{ traducir('traductor.documento')}}</th>
                        <th style="width: 100px;">{{ traducir('traductor.cargo')}}</th>
                        <th style="width: 100px;">{{ traducir('asambleas.delegado')}}</th>
                        <th style="width: 100px;">{{ traducir('traductor.pais')}}</th>
                        <th style="width: 200px;">{{ traducir('asambleas.jerarquia')}}</th>
                        <th style="width: 150px;">{{ traducir('asambleas.correo')}}</th>
                        <th style="width: 100px;">{{ traducir('traductor.telefono')}}</th>
                        <th style="width: 150px;">{{ traducir('asambleas.convocatoria')}}</th>
                        <th style="width: 50px;"><button type="button" id="todos" class="btn btn-success btn-xs">{{ traducir('asambleas.todos') }}</button></th>
                    </tr>

                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
   

</form>


<div id="modal-asignacion_delegados" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none; z-index: 999999999999;" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
      
            <form id="formulario-asignacion_delegados" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="row">
                    <input type="hidden" name="miembros" id="miembros" class="input-sm entrada">
                    
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <select name="asamblea_id" id="asamblea_id" class="selectizejs entrada">
                                
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('asambleas.delegado')}}</label>
                            <select name="delegado_tipo" id="delegado_tipo" class="form-control input-sm entrada" default-value="T">
                                <option value="T">{{ traducir('asambleas.titular')}}</option>
                                <option value="S">{{ traducir('asambleas.suplente')}}</option>
                            </select>
                        </div>
                    </div>
                   
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-asignacion_delegados"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-asignacion_delegados" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>  



<!-- <div id="modal-imprimir" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none; z-index: 999999999999;" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
      
            <form id="formulario-imprimir" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="row">                    
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <select name="asamblea_id_imprimir" id="asamblea_id_imprimir" class="selectizejs entrada">
                                
                            </select>
                        </div>
                      
                    </div>
                   
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-imprimir">[{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="ejecutar-impresion" class="btn btn-primary btn-sm">[{{ traducir('traductor.imprimir')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>   -->

<div id="modal-notificar" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none; z-index: 999999999999;" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
      
            <form id="formulario-notificar" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="row">                    
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <select name="asamblea_id_notificar" id="asamblea_id_notificar" class="selectizejs entrada">
                                
                            </select>
                        </div>
                      
                    </div>
                   
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-notificar">[{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="ejecutar-notificacion" class="btn btn-primary btn-sm">[{{ traducir('asambleas.notificar')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>  


<div id="modal-impresion" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none; z-index: 999999999999;" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
      
            <form id="formulario-impresion" class="form-horizontal" role="form">

                <div class="modal-body">
                    <h3>{{ traducir('traductor.ver') }}</h3>
                    <div class="row">
                        <input type="hidden" name="delegados" id="delegados" class="entrada input-sm">
                        <input type="hidden" name="asamblea_id_impresion" id="asamblea_id_impresion" class="entrada input-sm">

                               
                        <div class="col-md-12 asamblea-impresion">
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <select name="asamblea_id_imprimir" id="asamblea_id_imprimir" class="selectizejs entrada">
                                
                            </select>
                        </div>
                      
                
                        <div class="col-md-12">
                            <label class="control-label">
                                <input class="minimal entrada" type="checkbox" checked="checked" name="campos[]" value="(m.nombres || ' ' || m.apellidos) AS nombres">
                                {{ traducir('traductor.nombres')}}
                            </label><br>
                            <label class="control-label">
                                <input value="m.nrodoc AS documento" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('traductor.documento')}}
                            </label><br>
                            <label class="control-label">
                            <input value="c.descripcion AS cargo" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('traductor.cargo')}}
                            </label><br>
                            <label class="control-label">
                                <input value="<?php echo "CASE WHEN d.delegado_tipo = 'T' THEN '".traducir("asambleas.titular")."' WHEN d.delegado_tipo = 'S' THEN '".traducir("asambleas.suplente")."' ELSE '' END AS delegado"; ?>" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('asambleas.delegado')}}
                            </label><br>
                            <label class="control-label">
                                <input value="p.pais_descripcion AS pais" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('traductor.pais')}}
                            </label><br>
                            <label class="control-label">
                                <input value="<?php echo "iglesias.fn_mostrar_jerarquia('s.division || '' / '' || s.pais  || '' / '' ||  s.union || '' / '' || s.mision || '' / '' || s.distritomisionero || '' / '' || s.iglesia', 'i.idiglesia=' || m.idiglesia, ".session("idioma_id").", ".session("idioma_id_defecto").") AS jerarquia"; ?>" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('asambleas.jerarquia')}}
                            </label><br>
                            <label class="control-label">
                                <input value="m.email AS correo" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('asambleas.correo')}}
                            </label><br>
                            <label class="control-label">
                                <input value="m.telefono" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('traductor.telefono')}}
                            </label><br>
                            <label class="control-label">
                                <input value="CASE WHEN a.asamblea_descripcion IS NULL THEN '' ELSE a.asamblea_descripcion END AS convocatoria" class="minimal entrada" type="checkbox" checked="checked" name="campos[]">
                                {{ traducir('asambleas.convocatoria')}}
                            </label><br>
                        </div>
                    </div>
                   
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-impresion">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-impresion" class="btn btn-default btn-sm">[F9] [{{ traducir('traductor.imprimir')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>  


@endsection