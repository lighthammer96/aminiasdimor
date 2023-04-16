@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<style>
  /* .celda:hover {
    background-color: #FFCC00;
    cursor: pointer
  } */

  .fila:hover {
    background-color: #FFFF99
  }
</style>
<form id="formulario-oficiales_union" class="form-horizontal" role="form">
    <div class="row">
            <input type="hidden" name="lugar" id="lugar" class="input-sm entrada">
            <div class="col-md-4 col-md-offset-4">
                <div class="row">
                    <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.division") }}</label>

                        <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                        </select>
                    </div>
                    <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.pais") }}</label>

                        <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                        </select>

                    </div>
                    <div class="col-md-8 col-md-offset-1 union">
                        <label class="control-label">{{ traducir("traductor.union") }}</label>

                        <select  class="entrada selectizejs" name="idunion" id="idunion">

                        </select>

                    </div>


                    <div class="col-md-8 col-md-offset-1" style="">

                        <label class="control-label">{{ traducir('traductor.periodo_ini') }}</label>
                        <select class="entrada selectizejs limpiar-cargos" name="periodoini" id="periodoini">

                        </select>

                    </div>
                    <div class="col-md-8 col-md-offset-1" style="">
                        <label class="control-label">{{ traducir('traductor.periodo_fin') }}</label>
                        <select class="entrada selectizejs limpiar-cargos" name="periodofin" id="periodofin">

                        </select>
                    </div>

                    <div class="col-md-8 col-md-offset-1" style="margin-top: 15px;">
                        <center>
                            <button type="button" id="ver-reporte" class="btn btn-default"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/documento.png') }}" ><br>{{ traducir("traductor.ver") }}</button>
                        </center>
                    </div>
                </div>

            </div>




    </div>


</form>


@endsection

