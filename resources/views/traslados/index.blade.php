@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<form id="formulario-traslados_temp" class="form-horizontal" role="form">
    <div class="row formulario">
        <div class="col-md-3 col-md-offset-2">
            <fieldset>
                <legend>Iglesia de Origen</legend>
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

            </fieldset>
        </div>
        <div class="col-md-2" style="margin-top: 125px">
            <img src="{{ URL::asset('images/flecha.gif') }}" >
        </div>    
        <div class="col-md-3">
            <fieldset>
                <legend>Iglesia de Destino</legend>
                <div class="col-md-12">
                    <label class="control-label">División</label>

                    <select  class="entrada selectizejs" name="iddivisiondestino" id="iddivisiondestino">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">País</label>

                    <select  class="entrada selectizejs" name="pais_iddestino" id="pais_iddestino">

                    </select>

                </div>
                <div class="col-md-12 union-destino">
                    <label class="control-label">Unión</label>

                    <select  class="entrada selectizejs" name="iduniondestino" id="iduniondestino">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">Asociación/Misión</label>

                    <select  class="entrada selectizejs" name="idmisiondestino" id="idmisiondestino">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">Distrito Misionero</label>

                    <select  class="entrada selectizejs" name="iddistritomisionerodestino" id="iddistritomisionerodestino">

                    </select>

                </div>
                <div class="col-md-12">
                    <label class="control-label">Iglesia</label>

                    <select  class="entrada selectizejs" name="idiglesiadestino" id="idiglesiadestino">

                    </select>

                </div>

            </fieldset>
        </div>

    </div>
    <div class="row formulario">
        <div class="col-md-2 col-md-offset-5" style="margin-top: 10px;">
            <button type="button" class="btn btn-primary" id="ver-lista">[{{ traducir('traductor.ver_lista') }}]</button>
        </div>
    </div>

</form>

   
@endsection

