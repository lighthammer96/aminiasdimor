@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<div id="modal-control" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
 
            <form id="formulario-control" class="form-horizontal" role="form">
                <div class="modal-body">
                    <input type="hidden" class="input-sm entrada" name="idcontrol" id="idcontrol">
                    <input type="hidden" class="input-sm entrada" name="idmiembro" id="idmiembro">
                    <input type="hidden" class="input-sm entrada" name="iddivisionactual" id="iddivisionactual">
                    <input type="hidden" class="input-sm entrada" name="pais_idactual" id="pais_idactual">
                    <input type="hidden" class="input-sm entrada" name="idunionactual" id="idunionactual">
                    <input type="hidden" class="input-sm entrada" name="idmisionactual" id="idmisionactual">
                    <input type="hidden" class="input-sm entrada" name="iddistritomisioneroactual" id="iddistritomisioneroactual">
                    <input type="hidden" class="input-sm entrada" name="idiglesiaactual" id="idiglesiaactual">
                    <input type="hidden" class="input-sm entrada" name="idiglesiaanterior" id="idiglesiaanterior">
             
                    <div class="row" >
                        <div class="col-md-12">
                            <label class="control-label">{{ traducir("traductor.carta_aceptacion") }}</label>

                            <input type="file" class="form-control input-sm entrada" name="carta" id="carta">
       
                        </div>
                    </div>
   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-control">[Cancelar]</button>
                    <button type="button" id="guardar-control" class="btn btn-primary btn-sm">[Guardar]</button>
                </div>
            </form>

        </div>
    </div>
</div>
   
   
@endsection
