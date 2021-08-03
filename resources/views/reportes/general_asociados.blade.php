@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<form id="formulario-general_asociados" class="form-horizontal" role="form">
    <input type="hidden" name="formato" id="formato" value="portrait">
    <div class="row">
   

        <div class="col-md-3">

            <label class="control-label">{{ traducir('traductor.condicion_eclesiastica') }}</label>
            <select class="entrada selectizejs" name="idcondicioneclesiastica" id="idcondicioneclesiastica">

            </select>
        
        </div>

        <div class="col-md-2" style="">
            <label class="control-label">{{ traducir('traductor.estado_civil') }}</label>
            <select class="entrada selectizejs" name="idestadocivil" id="idestadocivil">

            </select>
        </div>

        <div class="col-md-2" style="">
            <label class="control-label">{{ traducir('traductor.profesion') }}</label>

            <select class="entrada selectizejs" name="idocupacion" id="idocupacion">

            </select>
        </div>
        <div class="col-md-3">
            <label class="control-label" style="display: block; margin-left: -155px;">{{ traducir('traductor.fecha_bautizo') }}</label>
            <div class="row">
                <div class="col-md-6" style="padding-left: 0; padding-right: 5px;">
                    <div class="input-group">
                        <input type="text" class="form-control input-sm entrada" name="fechaini" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                        <div class="input-group-addon" id="calendar-fechaini" style="cursor: pointer;">
                            <i class="fa fa-calendar"></i>
                        </div>
                    </div>
            
                </div>
                <div class="col-md-6" style="padding-left: 5px; padding-right: 0px;">
                    <div class="input-group">
                        <input type="text" class="form-control input-sm entrada" name="fechafin" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                        <div class="input-group-addon" id="calendar-fechafin" style="cursor: pointer;">
                            <i class="fa fa-calendar"></i>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <div class="col-md-2"  style="padding-left: 45px;">
            
                <input checked="checked" type="radio" name="estado" value="" class="minimal entrada" >&nbsp;&nbsp;Todos<br>
                <input type="radio" name="estado" value="1" class="minimal entrada" >&nbsp;&nbsp;Activos<br>
                <input  type="radio" name="estado" value="0" class="minimal entrada" >&nbsp;&nbsp;Inactivos
            
          
        </div>
    </div>
    
 
    <div class="row">
       
            
        <div class="col-md-3">
            <label class="control-label">{{ traducir("traductor.division") }}</label>

            <select  class="entrada selectizejs" name="iddivision" id="iddivision">

            </select>

        </div>
        <div class="col-md-2">
            <label class="control-label">{{ traducir("traductor.pais") }}</label>

            <select  class="entrada selectizejs" name="pais_id" id="pais_id">

            </select>

        </div>
        <div class="col-md-2 union">
            <label class="control-label">{{ traducir("traductor.union") }}</label>

            <select  class="entrada selectizejs" name="idunion" id="idunion">

            </select>

        </div>
        <div class="col-md-3">
            <label class="control-label">{{ traducir("traductor.asociacion") }}</label>

            <select  class="entrada selectizejs" name="idmision" id="idmision">

            </select>

        </div>
        <div class="col-md-2">
            <label class="control-label">{{ traducir("traductor.distrito_misionero") }}</label>

            <select  class="entrada selectizejs" name="iddistritomisionero" id="iddistritomisionero">

            </select>

        </div>
       
    </div>
    <!-- <div class="row" id="check_todos" style="display: none;">
        <div class="col-md-12" style="">
            <input class="minimal entrada" type="checkbox" name="todos" id="todos" value="1">&nbsp;&nbsp;
            <label class="control-label">{{ traducir('traductor.seleccionar_todas_iglesias')}}</label>
        </div>
    </div> -->
    <div class="row" id="check_iglesias" style="display: none;">
        <div class="col-md-12">
            <fieldset>
                <legend>Iglesias</legend>
                <div class="row" id="iglesias">
                    
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
        <label class="control-label">{{ traducir('traductor.ver')}}: </label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2" style="padding-right: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="(m.apellidos || ', ' || m.nombres) AS nombres">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.nombres')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.nrodoc AS numero_documento">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.doc_identidad')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.fechanacimiento AS fecha_nacimiento">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.fecha_nacimiento')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.ciudadnacextranjero AS lugar_nacimiento">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.lugar_nacimiento')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.sexo">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.sexo')}}</label>
        </div>
        <div class="col-md-2" style="padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="ec.descripcion AS estado_civil">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.estado_civil')}}</label>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2" style="padding-right: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.direccion">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.direccion')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.referenciadireccion AS referencia">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.referencia')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.telefono">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.telefono')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.celular">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.celular')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.email">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.email')}}</label>
        </div>
        <div class="col-md-2" style="padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.fechabautizo AS fecha_bautizo">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.fecha_bautizo')}}</label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2" style="padding-right: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="vr.nombres AS pastor">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.pastor')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="ce.descripcion AS estado_bautizo">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.estado_bautizo')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="o.descripcion AS profesion">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.profesion')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="gi.descripcion AS nivel_educativo">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.nivel_educativo')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.fechaingresoiglesia AS fecha_ingreso ">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.fecha_ingreso')}}</label>
        </div>
        <div class="col-md-2" style="padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="DATE_PART('year',AGE(m.fechanacimiento)) AS edad">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.edad')}}</label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2" style="padding-right: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.estado">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.estado')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="m.observaciones">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.observaciones')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="d.descripcion AS division">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.division')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="p.pais_descripcion AS pais">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.pais')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="u.descripcion AS union">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.union')}}</label>
        </div>
        <div class="col-md-2" style="padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="mm.descripcion AS mision">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.asociacion')}}</label>
        </div>
    </div>

    <div class="row">
        <div class="col-md-2" style="padding-right: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="dm.descripcion AS distrito_misionero">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.distrito_misionero')}}</label>
        </div>
        <div class="col-md-2" style="padding-right: 5px; padding-left: 5px;">
            <input class="minimal entrada" type="checkbox" name="campos[]" value="i.descripcion AS iglesia">&nbsp;&nbsp;    <label class="control-label">{{ traducir('traductor.iglesia')}}</label>
        </div>
     
       
    </div>
    <div class="row" style="margin-top: 30px;">
        <center>
            <div class="col-md-3">
                <center>
                    <button type="button" id="imprimir_fichas" class="btn btn-primary"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;&nbsp;{{ traducir("traductor.imprimir_fichas") }}</button>
                </center>
            </div>
            <div class="col-md-3">
                <center>
                    <button type="button" id="imprimir_vertical" class="btn btn-primary"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;&nbsp;{{ traducir("traductor.imprimir_vertical") }}</button>
                </center>
            </div>
            <div class="col-md-3">
                <center>
                    <button type="button" id="imprimir_horizontal" class="btn btn-primary"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;&nbsp;{{ traducir("traductor.imprimir_horizontal") }}</button>
                </center>
            </div>
            <div class="col-md-3">
                <center>
                    <button type="button" id="exportar_excel" class="btn btn-primary"><i class="fa fa-file-excel-o"></i>&nbsp;&nbsp;&nbsp;{{ traducir("traductor.exportar_excel") }}</button>
                </center>
            </div>

        </center>

    </div>

</form>

@endsection

