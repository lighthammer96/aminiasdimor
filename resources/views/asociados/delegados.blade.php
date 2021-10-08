@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<div id="modal-asociados" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
      
            <form id="formulario-asociados" class="form-horizontal" role="form">

                <div class="modal-body">
                    <input type="hidden" name="idmiembro" id="idmiembro" class="input-sm entrada">
                    <div class="row">
                    
                        <div class="col-md-3" style="padding-right: 5px;">
                            <label class="control-label">{{ traducir('asambleas.numero_pasaporte')}}</label>
                            <input type="text" class="form-control input-sm entrada" name="nropasaporte" />
                        </div>
                        
                        <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                            <label class="control-label">{{ traducir('asambleas.fecha_vencimiento')}}</label>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="fecha_vencimiento_pasaporte" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-fecha_vencimiento_pasaporte" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                   
                        </div>
                       
                       
                    </div>

                    <div class="row">
                    
                        <div class="col-md-3" style="padding-right: 5px;">
                            <label class="control-label">{{ traducir('asambleas.fecha_pasaje')}}</label>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="fecha_pasaje" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-fecha_pasaje" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                            <label class="control-label">{{ traducir("asambleas.hora") }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada limpiar" name="hora_arribo" />
                                <div class="input-group-addon" style="cursor: pointer;">
                                    <i class="fa fa-clock-o" id="time-hora_arribo"></i>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                            <label class="control-label">{{ traducir('asambleas.aerolinea')}}</label>
                            <input type="text" class="form-control input-sm entrada" name="aerolinea" />
                        </div>

                        <div class="col-md-3" style="padding-left: 5px;">
                            <label class="control-label">{{ traducir('asambleas.aeropuerto')}}</label>
                            <input type="text" class="form-control input-sm entrada" name="aeropuerto" />
                        </div>
                    </div>

                    <div class="row">
                    
                        <div class="col-md-4" style="margin-top: 20px;">
                            <label class="control-label">
                                <!-- <input type="hidden" name="posee_seguro" id="posee_seguro" class="input-sm entrada"> -->
                                <input class="minimal entrada" type="checkbox" name="posee_seguro" id="posee_seguro">
                               
                                {{ traducir('asambleas.posee_seguro_salud')}}
                            </label>
                           
                        </div>
                        
                        <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                            <label class="control-label">{{ traducir("asambleas.inicia") }}</label>
                            

                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="fecha_inicia_seguro" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-fecha_inicia_seguro" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                            <label class="control-label">{{ traducir('asambleas.termina')}}</label>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm entrada" name="fecha_termina_seguro" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                                <div class="input-group-addon"  id="calendar-fecha_termina_seguro" style="cursor: pointer;">
                                    <i class="fa fa-calendar"></i>
                                </div>
                            </div>
                        </div>

                       
                    </div>


                    <div class="row">
                    
                    <div class="col-md-4" style="margin-top: 20px;">
                        <label class="control-label">
                            <!-- <input type="hidden" name="posee_visa" id="posee_visa" class="input-sm entrada"> -->
                            <input class="minimal entrada" type="checkbox" name="posee_visa" id="posee_visa">
                            {{ traducir('asambleas.posee_visa')}}
                        </label>
                       
                    </div>
                    
                    <div class="col-md-3" style="padding-right: 5px; padding-left: 5px;">
                        <label class="control-label">{{ traducir("asambleas.vencimiento_visa") }}</label>
                        

                        <div class="input-group">
                            <input type="text" class="form-control input-sm entrada" name="fecha_vencimiento_visa" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask placeholder="" />
                            <div class="input-group-addon"  id="calendar-fecha_vencimiento_visa" style="cursor: pointer;">
                                <i class="fa fa-calendar"></i>
                            </div>
                        </div>
                    </div>

                    
                   
                </div>
                   
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" id="cancelar-asociados">[Esc] [{{ traducir('traductor.cancelar')}}]</button>
                    <button type="button" id="guardar-asociados" class="btn btn-primary btn-sm">[F9] [{{ traducir('traductor.guardar')}}]</button>
                </div>
            </form>

        </div>
    </div>
</div>  


@endsection