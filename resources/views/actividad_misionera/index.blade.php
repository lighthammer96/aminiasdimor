@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<style>
  .celda:hover {
    background-color: #FFCC00;
    cursor: pointer
  }

  .fila:hover {
    background-color: #FFFF99
  }
</style>
<form id="formulario-actividad_misionera" class="form-horizontal" role="form">
    <div class="row">
        <div class="col-md-2">
            <div class="row">
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
            </div>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-1" >
                    <label class="control-label" style="float: right;">{{ traducir("traductor.anio") }}:</label>
                </div>
                <div class="col-md-2">
                    
                    <select name="anio" id="anio" class="entrada selectizejs"></select>
                </div>
                <div class="col-md-1">
                    <label class="control-label" style="float: right;">{{ traducir("traductor.trimestre") }}:</label>
                </div>
                <div class="col-md-3">
                    
                    <select name="idtrimestre" id="idtrimestre" class="entrada selectizejs"></select>
                </div>
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

