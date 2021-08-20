@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<form id="formulario-importar" class="form-horizontal" role="form">
   <div class="row">

        <div class="col-md-2 col-md-offset-3">
            <label for="" class="control-label">{{ traducir("traductor.dato") }}</label>
            <select name="dato" id="dato" class="form-control">
                <option value="iglesias">Iglesias</option>
                <option value="asociados">Asociados</option>
                <option value="curriculum">Curriculum</option>
            </select>
        </div>

        <div class="col-md-4">
            <label for="" class="control-label">{{ traducir("traductor.excel") }}</label>
            <input type="file" name="excel" id="excel" class="form-control">
        </div>
   </div>

   <div class="row" style="margin-top: 20px;">
       <div class="col-md-2 col-md-offset-5">
           <button type="button" class="btn btn-primary" id="importar">{{ traducir("traductor.importar") }}</button>
       </div>
   </div>

</form>
@endsection

