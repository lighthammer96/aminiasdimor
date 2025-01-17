{{-- @section('header') --}}
<header class="main-header">
    <!-- Logo -->
    <a href="{{ URL::to('principal/index') }}" class="logo">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><b>I</b>MS</span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg"><b>IMS System</b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </a>

        <div class="navbar-custom-menu">

            <ul class="nav navbar-nav">
                <li>
                    <select style="margin-top: 8px;" name="idioma_sistema" class="form-control" id="idioma_sistema">
                        <?php
                            foreach ($idiomas as $key => $value) {

                                if(trim(session("idioma_codigo")) == trim($value->idioma_codigo)) {
                                    echo '<option selected="selected" value="'.$value->idioma_id."|".trim($value->idioma_codigo).'">'.$value->idioma_descripcion.'</option>';
                                } else {
                                    echo '<option value="'.$value->idioma_id."|".trim($value->idioma_codigo).'">'.$value->idioma_descripcion.'</option>';
                                }

                            }

                        ?>
                    </select>
                </li>
                <!-- <li class="dropdown messages-menus">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-envelope-o"></i>
                        <span class="label label-success">4</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header">Choose language</li>
                        <li>

                            <ul class="menu">
                                <li>

                                    <a  href="#">
                                        <div class="pull-left">
                                            <img src="{{ URL::asset('flags/Poland.png') }}" class="img-flag" alt="Polish" height="24">
                                        </div>

                                        <h4>
                                            Polish
                                            <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                        </h4>
                                        <p>Why not buy a new awesome theme?</p>
                                    </a>

                                </li>

                            </ul>
                        </li>

                    </ul>
                </li> -->
                <!-- Messages: style can be found in dropdown.less-->
                <!-- <li class="dropdown messages-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-envelope-o"></i>
                        <span class="label label-success">4</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header">You have 4 messages</li>
                        <li>

                            <ul class="menu">
                                <li>

                                    <a href="#">
                                        <div class="pull-left">
                                            <img src="{{ URL::asset('dist/img/user2-160x160.jpg') }}" class="img-circle" alt="User Image">
                                        </div>
                                        <h4>
                                            Support Team
                                            <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                        </h4>
                                        <p>Why not buy a new awesome theme?</p>
                                    </a>
                                </li>

                            </ul>
                        </li>
                        <li class="footer"><a href="#">See All Messages</a></li>
                    </ul>
                </li>

                <li class="dropdown notifications-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-bell-o"></i>
                        <span class="label label-warning">10</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header">You have 10 notifications</li>
                        <li>

                            <ul class="menu">
                                <li>
                                    <a href="#">
                                        <i class="fa fa-users text-aqua"></i> 5 new members joined today
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="footer"><a href="#">View all</a></li>
                    </ul>
                </li>

                <li class="dropdown tasks-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-flag-o"></i>
                        <span class="label label-danger">9</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header">You have 9 tasks</li>
                        <li>

                            <ul class="menu">
                                <li>

                                    <a href="#">
                                        <h3>
                                            Design some buttons
                                            <small class="pull-right">20%</small>
                                        </h3>
                                        <div class="progress xs">
                                            <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">20% Complete</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>

                            </ul>
                        </li>
                        <li class="footer">
                            <a href="#">View all tasks</a>
                        </li>
                    </ul>
                </li> -->
                <!-- User Account: style can be found in dropdown.less -->
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <?php
                        // var_dump(file_exists(public_path('fotos_asociados/'.trim(session("foto")))));
                        if(!empty(session("foto")) && file_exists(public_path('fotos_asociados/'.trim(session("foto"))))) { ?>
                            <img src="{{ URL::asset('fotos_asociados/'.session("foto"))}}" class="user-image" alt="User Image">
                        <?php } else { ?>
                            <img src="{{ URL::asset('images/usuario.png') }}" class="user-image" alt="User Image">
                        <?php } ?>
                        <span class="hidden-xs">{{ session("responsable") }}</span>
                    </a>
                    <ul class="dropdown-menu">
                        <!-- User image -->
                        <li class="user-header">
                            <?php if(!empty(session("foto")) && file_exists(public_path('fotos_asociados/'.trim(session("foto"))))) { ?>
                                <img src="{{ URL::asset('fotos_asociados/'.session("foto")) }}" class="img-circle" alt="User Image">
                            <?php } else { ?>
                                <img src="{{ URL::asset('images/usuario.png') }}" class="img-circle" alt="User Image">
                            <?php } ?>



                            <p style="margin-top: 0px;">
                                {{ session("responsable") }} <br> {{ session("perfil_descripcion") }}
                                <br> {{ session("tipo_acceso") }}
                                <!-- <small>Member since Nov. 2012</small> -->
                            </p>
                        </li>
                        <!-- Menu Body -->
                        <!-- <li class="user-body">
                            <div class="row">
                                <div class="col-xs-4 text-center">
                                    <a href="#">Followers</a>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <a href="#">Sales</a>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <a href="#">Friends</a>
                                </div>
                            </div>

                        </li> -->
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <!-- <div class="pull-left">
                                <a href="#" class="btn btn-default btn-flat">Profile</a>
                            </div> -->
                            <div class="pull-right">
                                <a href="{{ URL::to('login/logout') }}" class="btn btn-default btn-flat">{{ traducir('traductor.desconectar') }}</a>
                            </div>
                        </li>
                    </ul>
                </li>
                <!-- Control Sidebar Toggle Button -->
                <!-- <li>
                    <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                </li> -->
            </ul>
        </div>
    </nav>
</header>

{{-- @endsection --}}
