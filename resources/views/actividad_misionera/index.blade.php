@extends('layouts.layout')


@section('content')

<form id="formulario-actividad_misionera" class="form-horizontal" role="form">
    <div class="row">
        <div class="col-md-2">
            <div class="row">
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.division") }}</label>

                    <select  class="entrada selectizejs" name="iddivision" id="iddivision">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.pais") }}</label>

                    <select  class="entrada selectizejs" name="pais_id" id="pais_id">

                    </select>

                </div>
                <div class="col-md-12 union">
                    <label class="control-label">{{ traducir("traductor.union") }}</label>

                    <select  class="entrada selectizejs" name="idunion" id="idunion">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                    <select  class="entrada selectizejs" name="idmision" id="idmision">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>

                    <select  class="entrada selectizejs" name="iddistritomisionero" id="iddistritomisionero">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">{{ traducir("traductor.iglesia") }}</label>

                    <select  class="entrada selectizejs" name="idiglesia" id="idiglesia">

                    </select>

                </div>
            </div>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-2" >
                    <label class="control-label" style="">{{ traducir("traductor.anio") }}:</label>
                    <select name="anio" id="anio" class="entrada selectizejs"></select>
                </div>
                <!-- <div class="col-md-2">


                </div> -->
                <div class="col-md-2">
                    <label class="control-label" style="">{{ traducir("traductor.mes") }}:</label>
                    <select name="mes" id="mes" class="form-control input-sm">
                        <option value="1">{{ traducir("traductor.enero") }}</option>
                        <option value="2">{{ traducir("traductor.febrero") }}</option>
                        <option value="3">{{ traducir("traductor.marzo") }}</option>
                        <option value="4">{{ traducir("traductor.abril") }}</option>
                        <option value="5">{{ traducir("traductor.mayo") }}</option>
                        <option value="6">{{ traducir("traductor.junio") }}</option>
                        <option value="7">{{ traducir("traductor.julio") }}</option>
                        <option value="8">{{ traducir("traductor.agosto") }}</option>
                        <option value="9">{{ traducir("traductor.septiembre") }}</option>
                        <option value="11">{{ traducir("traductor.octubre") }}</option>
                        <option value="11">{{ traducir("traductor.noviembre") }}</option>
                        <option value="12">{{ traducir("traductor.diciembre") }}</option>
                    </select>
                </div>
                <!-- <div class="col-md-2">


                </div> -->

                <div class="col-md-2">
                    <label class="control-label" style="">{{ traducir("traductor.semana") }}:</label>
                    <select name="semana" id="semana" class="form-control input-sm">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="control-label" style="">{{ traducir("traductor.fecha_inicial") }}:</label>
                    <div class="input-group">
                        <input type="text" class="form-control input-sm entrada" id="fecha_inicial" name="fecha_inicial" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                        <div class="input-group-addon" id="calendar-fecha_inicial" style="cursor: pointer;">
                            <i class="fa fa-calendar"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <label class="control-label" style="">{{ traducir("traductor.fecha_final") }}:</label>
                    <div class="input-group">
                        <input type="text" class="form-control input-sm entrada" id="fecha_final" name="fecha_final" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                        <div class="input-group-addon" id="calendar-fecha_final" style="cursor: pointer;">
                            <i class="fa fa-calendar"></i>
                        </div>
                    </div>
                </div>
                <!-- <div class="col-md-1">


                </div> -->
                <!-- <div class="col-md-1">
                    <label class="control-label" style="float: right;">{{ traducir("traductor.trimestre") }}:</label>
                </div>
                <div class="col-md-3">

                    <select name="idtrimestre" id="idtrimestre" class="entrada selectizejs"></select>
                </div> -->
                <!-- <div class="col-md-1">
                    <button type="button" id="ver" class="btn btn-primary btn-sm">{{ traducir("traductor.ver") }}</button>
                </div>    -->
            </div>
            <div class="row" id="actividades">

            </div>
        </div>
    </div>

</form>


@endsection

