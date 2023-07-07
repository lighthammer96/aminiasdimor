@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-asistencia" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"><span class="typeoperacion"></span></h4>
            </div> -->
            <form id="formulario-asistencia" class="form-horizontal" role="form">

                <div class="modal-body">
                    <div class="row">
                        <input type="hidden" name="asistencia_id" class="input-sm entrada">
                        <div class="col-md-6">
                            <label class="control-label">{{ traducir('asambleas.convocatoria')}}</label>
                            <select name="asamblea_id" id="asamblea_id" class="selectizejs entrada">

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
                    <div class="pull-left" id="botones-asistencia">
                        <button type="button" class="btn btn-default btn-sm" id="imprimir-asistencia"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/printer.png') }}" ><br>{{ traducir('traductor.imprimir')}}</button>
                    </div>
                    <div class="pull-right">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-asistencia"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/cancelar.png') }}" ><br>[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                        <button type="button" id="guardar-asistencia" class="btn btn-default btn-sm"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/salvar.png') }}" ><br>[F9] [{{ traducir('traductor.guardar')}}]</button>
                    </div>

                </div>
            </form>

        </div>
    </div>
</div>



@endsection

