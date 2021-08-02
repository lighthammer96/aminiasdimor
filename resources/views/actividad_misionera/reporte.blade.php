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
<form id="formulario-reporte" class="form-horizontal" role="form">
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
                <div class="col-md-1" id="boton-reporte" style="display: none;">
                    <button type="button" id="ver-reporte" class="btn btn-primary btn-sm">{{ traducir("traductor.ver_reporte") }}</button>
                </div>   
            </div>

            <div class="row" id="actividades">

            </div>
        </div>
    </div>
</form>

<!-- <div class="row">
    <div class="col-md-10 col-md-offset-2" id="actividades">

    </div>
</div> -->
    



   
@endsection

