@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')
<form id="formulario-traslados_temp" class="form-horizontal" role="form">
    <div class="row" id="combo-tipo-traslado">
        <div class="col-md-2 col-md-offset-5">
            <label for=""><h4><strong>Tipo de Traslado</strong></h4></label>
            <select name="tipo_traslado" id="tipo_traslado" class="form-control">
                <option value="1">De Iglesia a Iglesia</option>
                <option value="2">Masivo</option>
                <option value="3">Individual</option>
            </select>
        </div>
    </div>
    <div class="row" id="combos-origen-destino">
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
        <div class="col-md-3" id="destino-iglesia">
            <!-- <fieldset>
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

            </fieldset> -->
        </div>

    </div>
    <div class="row">
        <div class="col-md-2 col-md-offset-5" style="margin-top: 10px;">
            <button type="button" class="btn btn-primary" id="ver-lista">[{{ traducir('traductor.ver_lista') }}]</button>
        </div>
    </div>

</form>


<div class="row" >
    <div class="col-md-2 volver"  style="display: none;">
        <button type="button" class="btn btn-success" id="volver">[{{ traducir('traductor.volver') }}]</button>
    </div>
    <div class="col-md-2 col-md-offset-8 trasladar" style="text-align: right; display: none;" >
        <button type="button" class="btn btn-primary" id="trasladar">[{{ traducir('traductor.trasladar_ahora') }}]</button>
    </div>
   

    <div class="col-md-12" id="tabla-asociados" style="margin-top: 20px; display: none;">
        <?php echo $tabla_asociados_traslados; ?>
    </div>

    <div class="col-md-12" id="tabla-temporal" style="margin-top: 20px; display: none;">
        <?php echo $tabla_traslados; ?>
    </div>

</div>
<div id="modal-traslados_mi" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none" data-backdrop="static">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
 
            <form id="formulario-traslados_mi" class="form-horizontal" role="form">
                <div class="modal-body">

                    <input type="hidden" name="tipo_traslado_mi" id="tipo_traslado_mi">
                    <input type="hidden" name="idmiembro" id="idmiembro">
                    
                    <div class="row" >
                        <div class="col-md-12" id="destino-masivo-individual">
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
   
                </div>
                <div class="modal-footer">
                    <div class="pull-left">
                        <button type="button" class="btn btn-warning btn-sm" id="carta-traslado">[Carta Traslado]</button>
                    </div>
                    <div class="pull-rigth">
                        <button type="button" class="btn btn-default btn-sm" id="cancelar-traslados-mi">[Cancelar]</button>
                        <button type="button" id="guardar-traslados-mi" class="btn btn-primary btn-sm">[Guardar]</button>
                    </div>
                   
                </div>
            </form>

        </div>
    </div>
</div>
   
@endsection

