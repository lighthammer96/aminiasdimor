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
<form id="formulario-grafico_feligresia" class="form-horizontal" role="form">
    <div class="row">
        <div class="col-md-2">
            <div class="row">
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.division") }}</label>

                    <select  class="entrada selectizejs" name="iddivision_all" id="iddivision_all">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.pais") }}</label>

                    <select  class="entrada selectizejs" name="pais_id_all" id="pais_id_all">

                    </select>

                </div>
                <div class="col-md-12 union">
                    <label class="control-label">{{ traducir("traductor.union") }}</label>

                    <select  class="entrada selectizejs" name="idunion_all" id="idunion_all">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                    <select  class="entrada selectizejs" name="idmision_all" id="idmision_all">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>

                    <select  class="entrada selectizejs" name="iddistritomisionero_all" id="iddistritomisionero_all">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.iglesia") }}</label>

                    <select  class="entrada selectizejs" name="idiglesia_all" id="idiglesia_all">

                    </select>

                </div>
                <div class="col-md-12" style="margin-top: 15px;">
                    <center>
                        <button type="button" id="ver-reporte" class="btn btn-default"><img style="width: 20px; height: 20px;" src="{{ URL::asset('images/iconos/documento.png') }}" ><br>{{ traducir("traductor.ver") }}</button>
                    </center>
                </div>
            </div>
        </div>
        <div class="col-md-10">
        <figure class="highcharts-figure">
            <div id="container"></div>

        </figure>

        </div>
    </div>

</form>


@endsection

