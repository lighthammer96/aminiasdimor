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
<form id="formulario-informe_semestral" class="form-horizontal" role="form">
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
                    <!-- <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

                        <select  class="entrada selectizejs" name="idmision" id="idmision">

                        </select>

                    </div> -->
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
                    <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.anio") }}</label>
                        <select name="anio" id="anio" class="entrada selectizejs"></select>
                    </div>
                    <div class="col-md-8 col-md-offset-1">
                        <label class="control-label">{{ traducir("traductor.semestre") }}</label>
                        <select name="semestre" id="semestre" class="form-control input-sm">
                            <option value="1">1 {{ traducir("traductor.semestre") }}</option>
                            <option value="2">2 {{ traducir("traductor.semestre") }}</option>
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

