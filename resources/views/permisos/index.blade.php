@extends('layouts.layout')
{{-- @extends('layouts.header') --}}
{{-- @extends('layouts.menu') --}}
{{-- @extends('layouts.aside') --}}
{{-- @extends('layouts.footer') --}}


@section('content')

<form id="formulario-permisos" class="form-horizontal">
    <div class="row">
       
        <div class="col-md-4 col-md-offset-3" >
            <div class="input-group m-bot15">
                <select placeholder="Seleccione Perfil..." name="perfil_id" id="perfil_id" class="selectizejs entrada">

                </select>
                <span class="input-group-btn">
                    <button type="button" id="nuevo-perfil" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

                </span>
            </div>

        </div>

        <div class="col-md-2" style="margin-top: 4px;">
            <button type="button" class="btn btn-success btn-sm" id="guardar-permisos">Guardar</button>
        </div>

     <!--    <label class="control-label">Modulo Padre</label>

        <div class="input-group m-bot15 col-md-12 sin-padding">
            <select name="modulo_padre" id="modulo_padre" class="form-control chosen-select input-sm entrada"></select>

            <span class="input-group-btn">
                <button type="button" id="nuevoModuloPadre" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>

            </span>

        </div> -->

    </div>
    <div class="row" style="margin-top: 15px;">
        <?php
            $i = 1;
            // echo "<pre>";
            // print_r($modulos); exit;
            echo '<div class="col-md-3">';
            foreach ($modulos_all as $modulo) {
                if(count($modulo->hijos) > 0) {
                    echo '<h3 style="cursor:pointer" class="padre todo">'.$modulo->mi_descripcion.'</h3>';
                    foreach ($modulo->hijos as $hijo) {


               
                        echo '  <label class="checkboxes">';
                        echo '  <input class="minimal" type="checkbox" name="modulo_id[]" value="'.$hijo->modulo_id.'">';
                        echo    '&nbsp;&nbsp;'.$hijo->mi_descripcion;
                        echo '  </label><br>';
                       

                        // if(count($hijo->acciones) > 0) {
                        //     echo '<div class="acciones todo" style="">';
                        //     foreach ($hijo->acciones as $accion) {
                        //         echo ' <div class="checkbox checkbox-primary checkboxes" style="margin-left:20px;">';
                        //         echo '  <input type="checkbox" name="accion_id_'.$hijo->modulo_id.'[]" value="'.$accion->accion_id.'">';
                        //         echo '  <label>'.$accion->accion_descripcion.'</label>';
                        //         echo '</div>';
                        //     }
                        //     echo '</div>';
                        // }

                    }
                    echo '</div>';
                    if($i%4 == 0) {
                        echo '<div style="clear:both;"></div>';
                    }
                    echo '<div class="col-md-3">';
                    $i++;
                }
            }
        ?>



    </div>
</form>


@include('perfiles.form')



   
@endsection



