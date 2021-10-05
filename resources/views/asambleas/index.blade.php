@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-asambleas" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-asambleas" class="form-horizontal" role="form">

                <div class="modal-body">
                    <input type="hidden" name="asamblea_id" class="input-sm entrada">
                    <div class="row">
                        <div class="col-md-7">
                            <label class="control-label">{{ traducir("traductor.descripcion") }}</label>
                            <input autofocus="autofocus" type="text" class="form-control input-sm entrada" name="asamblea_descripcion" placeholder="" />
                        </div>
                        <div class="col-md-5" style="">
                            <label class="control-label">{{ traducir("asambleas.tipo_convocatoria") }}</label>
                            <select class="entrada form-control input-sm select" name="tipconv_id" id="tipconv_id">

                            </select>
                        </div>
                    </div>
                    <div class="row">
                        
                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("traductor.anio") }}</label>
                            <select class="entrada selectizejs" name="asamblea_anio" id="asamblea_anio">

                            </select>
                        </div>
                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("traductor.fecha_inicio") }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="asamblea_fecha_inicio" id="asamblea_fecha_inicio" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-asamblea_fecha_inicio" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("traductor.fecha_fin") }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="asamblea_fecha_fin" id="asamblea_fecha_fin" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-asamblea_fecha_fin" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label class="control-label">{{ traducir('traductor.estado')}}</label>
                            <select name="estado" id="estado" class="form-control input-sm entrada" default-value="A">
                                <option value="A">ACTIVO</option>
                                <option value="I">INACTIVO</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("traductor.pais") }}</label>

                            <select class="entrada form-control input-sm select" name="idpais" id="idpais">

                            </select>
                        </div>
                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("traductor.ciudad") }}</label>
                            
                            <input type="text" class="form-control input-sm entrada" name="asamblea_ciudad" placeholder="" />
                        </div>
                    </div>
                    <div class="row">
                       
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('asambleas.agenda')}}</label>
                            <input type="text" class="form-control input-sm entrada limpiar" name="detalle" />
                        </div>
                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("traductor.fecha") }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada limpiar" name="fecha" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-fecha" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3" style="">
                            <label class="control-label">{{ traducir("asambleas.hora") }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada limpiar" name="hora" />
                                <div class="input-group-addon" style="cursor: pointer;">
                                    <i class="fa fa-clock-o" id="time-hora"></i>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-12">
                            <table class="table table-striped table-bordered display compact" id="detalle-agenda" style="font-size: 13px;">
                                <thead>
                                    <tr>
                                        <th style="width: 200px;">{{ traducir('asambleas.agenda')}}</th>
                                        <th style="width: 100px;">{{ traducir('traductor.fecha')}}</th>
                                        <th style="width: 100px;">{{ traducir('asambleas.hora')}}</th>
                                        <th style="width: 30px;">{{ traducir('traductor.eliminar')}}</th>
                                    </tr>

                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-asamblea">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-asamblea" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>


   
@endsection

