<!DOCTYPE html>
<html>

<meta http-equiv="content-type" content="text/html;charset=utf-8" />

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AMINIASDIMOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="{{ URL::asset('bower_components/bootstrap/dist/css/bootstrap.min.css') }}">
    
    <!-- <link rel="stylesheet" href="{{ URL::asset('bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css') }}"> -->
    <!-- Font Awesome -->
    <link rel="stylesheet" href="{{ URL::asset('bower_components/font-awesome/css/font-awesome.min.css') }}">
    <!-- Ionicons -->
    <link rel="stylesheet" href="{{ URL::asset('bower_components/Ionicons/css/ionicons.min.css') }}">
    <!-- Theme style -->
    <link rel="stylesheet" href="{{ URL::asset('dist/css/AdminLTE.min.css') }}">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="{{ URL::asset('dist/css/skins/_all-skins.min.css') }}">
    <link rel="stylesheet" href="{{ URL::asset('dist/css/jquery.dataTables.min.css') }}">
   
    <link rel="stylesheet" href="{{ URL::asset('sweetalert/dist/sweetalert.css') }}">
    <link rel="stylesheet" href="{{ URL::asset('notifications/notification.css') }}">


    <link rel="stylesheet" href="{{ URL::asset('selectize/selectize.bootstrap2.css') }}">

    <link rel="stylesheet" href="{{ URL::asset('plugins/iCheck/all.css') }}">


    <!-- daterange picker -->
    <link rel="stylesheet" href="{{ URL::asset('bower_components/bootstrap-daterangepicker/daterangepicker.css') }}">
    <!-- bootstrap datepicker -->
    <link rel="stylesheet" href="{{ URL::asset('bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css') }}">
 
    <!-- Bootstrap time Picker -->
    <link rel="stylesheet" href="{{ URL::asset('plugins/timepicker/bootstrap-timepicker.min.css') }}">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

    @isset($stylesheets)
        @foreach ($stylesheets as $style)
            <link rel="stylesheet" href="{{ $style }}">

        @endforeach
    @endisset
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <!-- Site wrapper -->
    <div class="wrapper">

        {{-- @yield('header') --}}
        @include('layouts.header')

        {{-- @yield('menu') --}}
        @include('layouts.menu')

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>
                    {{ $title }}
                    <small>
                        <?php 
                            if(isset($subtitle)) {
                                echo $subtitle;
                            }

                          
                        ?>
                    </small>
                </h1>
                <!-- <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                    <li><a href="#">Examples</a></li>
                    <li class="active">Blank page</li>
                </ol> -->
            </section>

            <!-- Main content -->
            <section class="content">
                
                <!-- Default box -->
                <div class="box">
                    <!-- <div class="box-header with-border">
                        <h3 class="box-title">{{ $title }}</h3>
                      
                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                <i class="fa fa-minus"></i></button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
                                <i class="fa fa-times"></i></button>
                        </div>
                    </div> -->
                    <div class="box-body">
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-md-12" id="acciones">
                                <?php

                                    if(isset($botones) && count($botones) > 0) {
                                        echo '<table><tr>';
                                        for ($i=0; $i < count($botones); $i++) { 
                                            echo '<td>'.$botones[$i].'</td>';
                                        }
                                        
                                        echo '</tr></table>';
                                    }
                                ?>
                            </div>
                        </div>
                        
                        <?php 
                            if(isset($tabla)) {
                                echo $tabla;
                            }
                            
                            
                        ?>

                        
                        @yield('content')
                    </div>
                    
                    <!-- <div class="box-footer">
                        Footer
                    </div> -->
              
                </div>
                <!-- /.box -->

            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        {{-- @yield('footer') --}}
        @include('layouts.footer')

        {{-- @yield('aside') --}}
        @include('layouts.aside')
       
        <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
        <div class="control-sidebar-bg"></div>
    </div>
    <!-- ./wrapper -->
    <script>
        var BaseUrl = "<?php echo URL::to('/'); ?>";
        var _token = "<?php echo csrf_token() ?>";
        var session_pais_id = "<?php echo session("pais_id"); ?>";
        var datatable_next = "<?php echo traducir('traductor.datatable_next'); ?>";
        var datatable_prev = "<?php echo traducir('traductor.datatable_prev'); ?>";
        var datatable_first = "<?php echo traducir('traductor.datatable_first'); ?>";
        var datatable_last = "<?php echo traducir('traductor.datatable_last'); ?>";
        var datatable_records = "<?php echo traducir('traductor.datatable_records'); ?>";
        var datatable_vacio = "<?php echo traducir('traductor.datatable_vacio'); ?>";
        var datatable_mostrando = "<?php echo traducir('traductor.datatable_mostrando'); ?>";
        var datatable_search = "<?php echo traducir('traductor.buscar'); ?>";
        var datatable_ver = "<?php echo traducir('traductor.datatable_ver'); ?>";
        var datatables_no_match = "<?php echo traducir('traductor.datatables_no_match'); ?>";
        var datatable_from = "<?php echo traducir('traductor.datatable_from'); ?>";
        var datatable_a = "<?php echo traducir('traductor.datatable_a'); ?>";
        var datatable_no_data = "<?php echo traducir('traductor.datatable_no_data'); ?>";
        var jerarquia_traductor = new Array();
        jerarquia_traductor['departamento'] = "<?php echo traducir('traductor.departamento'); ?>";
        jerarquia_traductor['provincia'] = "<?php echo traducir('traductor.provincia'); ?>";
        jerarquia_traductor['distrito'] = "<?php echo traducir('traductor.distrito'); ?>";
        jerarquia_traductor['estado'] = "<?php echo traducir('traductor.estado'); ?>";
        jerarquia_traductor['municipio'] = "<?php echo traducir('traductor.municipio'); ?>";
        jerarquia_traductor['parroquias'] = "<?php echo traducir('traductor.parroquias'); ?>";
        var seleccione = "<?php echo traducir('traductor.seleccione'); ?>";
    </script>
    <!-- jQuery 3 -->
    <script src="{{ URL::asset('bower_components/jquery/dist/jquery.min.js') }}"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="{{ URL::asset('bower_components/bootstrap/dist/js/bootstrap.min.js') }}"></script>
    <!-- SlimScroll -->
    <script src="{{ URL::asset('bower_components/jquery-slimscroll/jquery.slimscroll.min.js') }}"></script>
    <!-- FastClick -->
    <script src="{{ URL::asset('bower_components/fastclick/lib/fastclick.js') }}"></script>
    <!-- AdminLTE App -->
    <script src="{{ URL::asset('dist/js/adminlte.min.js') }}"></script>
    <!-- AdminLTE for demo purposes -->
    
    <script src="{{ URL::asset('dist/js/demo.js') }}"></script>
     <script src="{{ URL::asset('dist/js/jquery.dataTables.min.js') }}"></script>
    <!-- <script src="{{ URL::asset('bower_components/datatables.net/js/jquery.dataTables.min.js') }}"></script> -->
    <script src="{{ URL::asset('bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js') }}"></script>

    <script src="{{ URL::asset('sweetalert/dist/sweetalert.min.js') }}"></script>
    
    <script src="{{ URL::asset('notifyjs/dist/notify.min.js') }}"></script>
    <script src="{{ URL::asset('notifications/notify-metro.js') }}"></script>
    <script src="{{ URL::asset('notifications/notifications.js') }}"></script>
    
    
    <script src="{{ URL::asset('selectize/selectize.js') }}"></script>
    

    <script src="{{ URL::asset('plugins/iCheck/icheck.min.js') }}"></script>

    <!-- InputMask -->
    <script src="{{ URL::asset('plugins/input-mask/jquery.inputmask.js') }}"></script>
    <script src="{{ URL::asset('plugins/input-mask/jquery.inputmask.date.extensions.js') }}"></script>
    <script src="{{ URL::asset('plugins/input-mask/jquery.inputmask.extensions.js') }}"></script>
    <!-- date-range-picker -->
    <script src="{{ URL::asset('bower_components/moment/min/moment.min.js') }}"></script>
    <script src="{{ URL::asset('bower_components/bootstrap-daterangepicker/daterangepicker.js') }}"></script>
    <!-- bootstrap datepicker -->
    <script src="{{ URL::asset('bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js') }}"></script>


    <script src="{{ URL::asset('app/js/layout.js') }}"></script>
    <script src="{{ URL::asset('app/js/BASE_JS.js') }}"></script>
    

   
    @isset($scripts)

        @foreach ($scripts as $script)
            <script src="{{ $script }}"></script>
        @endforeach

    @endisset


    <script>
        $(document).ready(function() {
            $('.sidebar-menu').tree()
        })
    </script>
</body>


</html>