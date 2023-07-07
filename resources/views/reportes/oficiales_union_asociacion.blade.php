@extends('layouts.layout')


@section('content')

<form id="formulario-oficiales_union_asociacion" class="form-horizontal" role="form">
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
                    <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                        <select  class="entrada selectizejs" name="idmision" id="idmision">

                        </select>

                    </div>
                    <!-- <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>

                        <select  class="entrada selectizejs" name="iddistritomisionero" id="iddistritomisionero">

                        </select>

                    </div>
                    <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.iglesia") }}</label>

                        <select  class="entrada selectizejs" name="idiglesia" id="idiglesia">

                        </select>

                    </div>
                    <div class="col-md-8 col-md-offset-1">
                    <label class="control-label">{{ traducir("traductor.anio") }}</label>
                        <select name="anio" id="anio" class="entrada selectizejs"></select>
                    </div> -->
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

