var asociados = new BASE_JS('asociados', 'asociados');
var bajas = new BASE_JS('bajas', 'asociados');
var altas = new BASE_JS('altas', 'asociados');
var responsables = new BASE_JS('responsables', 'asociados');
var principal = new BASE_JS('principal', 'principal');
var divisiones = new BASE_JS('divisiones', 'divisiones');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var distritos_misioneros = new BASE_JS('distritos_misioneros', 'distritos_misioneros');
var iglesias = new BASE_JS('iglesias', 'iglesias');
var niveles = new BASE_JS('niveles', 'niveles');
var cargos = new BASE_JS('cargos', 'cargos');
var tipos_cargo = new BASE_JS('tipos_cargo', 'tipos_cargo');

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("pais_id_change").value = session_pais_id;
    document.getElementsByName("fecharegistro")[0].setAttribute("default-value", BASE_JS.ObtenerFechaActual("user"));
    var eventClick = new Event('click');

    asociados.enter("nombres","apellidos");
    asociados.enter("apellidos","apellido_soltera");
    asociados.enter("apellido_soltera","sexo", "", false);
    asociados.enter("sexo","idtipodoc");

    asociados.enter("nrodoc","celular");
    asociados.enter("celular","telefono");
    asociados.enter("telefono","email");
    asociados.enter("email","emailalternativo");
    asociados.enter("emailalternativo","iddepartamentodomicilio", "", false);

    asociados.enter("direccion","referenciadireccion");
    asociados.enter("referenciadireccion","fechanacimiento", "", false);
    asociados.enter("fechanacimiento","pais_id_nacimiento");
    asociados.enter("ciudadnacextranjero","idestadocivil");

    asociados.enter("observaciones","iddivision", "", false);
    // asociados.enter("tipolugarnac","iddepartamentonacimiento");

    // asociados.enter("fecharegistro","observaciones");

    $("input[name=fechanacimiento], input[name=fecha], input[name=fechabautizo]").inputmask();

    jQuery( "input[name=fechanacimiento], input[name=fecha], input[name=fechabautizo]" ).datepicker({
        format: "dd/mm/yyyy",
        language: "es",
        todayHighlight: true,
        todayBtn: "linked",
        autoclose: true,
        endDate: "now()",

    });

    $(function() {
        $('input[type="radio"], input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass   : 'iradio_minimal-blue'
        })
    })

    // paises.select({
    //     name: 'pais_id',
    //     url: '/obtener_paises',
    //     placeholder: seleccione,
    // })

    // paises.select({
    //     name: 'pais_id_nacionalidad',
    //     url: '/obtener_paises',
    //     placeholder: seleccione,
    // }).then(function() {
    //     asociados.enter("pais_id_nacionalidad","fecharegistro");
    // });

    principal.select({
        name: 'idmotivobaja',
        url: '/obtener_motivos_baja',
        placeholder: seleccione,
    }).then(function() {
        
    })

    asociados.select({
        name: 'anio',
        url: '/obtener_anios',
        placeholder: seleccione
    })

    paises.select({
        name: 'pais_id_nacimiento',
        url: '/obtener_todos_paises',
        placeholder: seleccione,
    }).then(function() {
        asociados.enter("pais_id_nacimiento","ciudadnacextranjero");
    })


    principal.select({
        name: 'idtipodoc',
        url: '/obtener_tipos_documento',
        placeholder: seleccione,
    }).then(function() {
        asociados.enter("idtipodoc","nrodoc");
    })

    asociados.TablaListado({
        tablaID: '#tabla-asociados',
        url: "/buscar_datos",
    });




    asociados.select({
        name: 'idestadocivil',
        url: '/obtener_estado_civil',
        placeholder: seleccione
    }).then(function() {
        asociados.enter("idestadocivil","idgradoinstruccion");
        
    }) 

    asociados.select({
        name: 'idgradoinstruccion',
        url: '/obtener_nivel_educativo',
        placeholder: seleccione
    }).then(function() {
        asociados.enter("idgradoinstruccion","idocupacion");
        
    }) 

    asociados.select({
        name: 'idocupacion',
        url: '/obtener_profesiones',
        placeholder: seleccione
    }).then(function() {
        asociados.enter("idocupacion","observaciones");
        
    }) 

    asociados.select({
        name: 'periodoini',
        url: '/obtener_periodos_ini',
    }).then(function() {
        
    }) 

    asociados.select({
        name: 'periodofin',
        url: '/obtener_periodos_fin',
    }).then(function() {
        
    }) 

    principal.select({
        name: 'idcondicioneclesiastica',
        url: '/obtener_condicion_eclesiastica',
        placeholder: seleccione
    }).then(function() {
        // asociados.enter("idocupacion","observaciones");
        
    }) 


    principal.select({
        name: 'idreligion',
        url: '/obtener_religiones',
        placeholder: seleccione
    }).then(function() {
        // asociados.enter("idocupacion","observaciones");
        
    }) 


    // principal.select({
    //     name: 'idinstitucion',
    //     url: '/obtener_instituciones',
    //     placeholder: seleccione
    // }).then(function() {
    //     // asociados.enter("idocupacion","observaciones");
        
    // }) 

    tipos_cargo.select({
        name: 'idtipocargo',
        url: '/obtener_tipos_cargo',
        placeholder: seleccione
    }).then(function() {
        $("#idtipocargo").trigger("change", ["", ""]);
        $("#idnivel").trigger("change", ["", ""]);
        //$("#idcargo").trigger("change", ["", ""]);
    
    }) 



    $(document).on('change', '#idtipocargo', function(event, idtipocargo, idcargo) {
        var valor = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : "1|S"; 
        var array = valor.toString().split("|");

        // var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        // d_id = (typeof idtipocargo != "undefined" && idtipocargo != null) ? idtipocargo : d_id;

        var d_id = array[0];
        var posee_nivel = array[1];
        var selected = (typeof idcargo != "undefined")  ? idcargo : "";
        


        niveles.select({
            name: 'idnivel',
            url: '/obtener_niveles',
            placeholder: seleccione,
            selected: selected,
            datos: { idtipocargo: d_id }
        }).then(function() {
        
            var condicion = typeof idtipocargo == "undefined" && idtipocargo != "";
            condicion = condicion && typeof idcargo == "undefined" && idcargo != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idtipocargo");
                // if(required) {
                    if(posee_nivel == "N") {
                        //$("#idcargo")[0].selectize.focus();
                    } else {
                        $("#idnivel")[0].selectize.focus();
                    }
                    
                // }
            } 
        
        
            
        })

        if(posee_nivel == "N") {
            $(".nivel").hide();

            cargos.select({
                name: 'idcargo',
                url: '/obtener_cargos',
                placeholder: seleccione,
                datos: { idtipocargo: d_id }
            }).then(function() {
                $("#idcargo")[0].selectize.focus();
            })
        } else {
            $(".nivel").show();
           
        }

    });


    $(document).on('change', '#idnivel', function(event, idnivel, idcargo) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idnivel != "undefined" && idnivel != null) ? idnivel : d_id;
        var selected = (typeof idcargo != "undefined")  ? idcargo : "";
        


        cargos.select({
            name: 'idcargo',
            url: '/obtener_cargos',
            placeholder: seleccione,
            selected: selected,
            datos: { idnivel: d_id }
        }).then(function() {
        
            var condicion = typeof idnivel == "undefined" && idnivel != "";
            condicion = condicion && typeof idcargo == "undefined" && idcargo != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idtipocargo");
                // if(required) {
                    $("#idcargo")[0].selectize.focus();
                // }
            } 
        
        
            
        })

    });



    principal.select({
        name: 'iddepartamentodomicilio',
        url: '/obtener_departamentos',
        placeholder: seleccione
    }).then(function() {
        
        $("#iddepartamentodomicilio").trigger("change", ["", ""]);
        $("#idprovinciadomicilio").trigger("change", ["", ""]);
    }) 



    $(document).on('change', '#iddepartamentodomicilio', function(event, iddepartamentodomicilio, idprovinciadomicilio) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof iddepartamentodomicilio != "undefined" && iddepartamentodomicilio != null) ? iddepartamentodomicilio : d_id;
        var selected = (typeof idprovinciadomicilio != "undefined")  ? idprovinciadomicilio : "";
    
        principal.select({
            name: 'idprovinciadomicilio',
            url: '/obtener_provincias',
            placeholder: seleccione,
            selected: selected,
            datos: { iddepartamento: d_id }
        }).then(function() {
        
            var condicion = typeof iddepartamentodomicilio == "undefined" && iddepartamentodomicilio != "";
            condicion = condicion && typeof idprovinciadomicilio == "undefined" && idprovinciadomicilio != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("iddepartamentodomicilio");
                // if(required) {
                    $("#idprovinciadomicilio")[0].selectize.focus();
                // }
            } 
        
        
            
        })

    });


    $(document).on('change', '#idprovinciadomicilio', function(event, idprovinciadomicilio, iddistritodomicilio) {

        var p_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        p_id = (typeof idprovinciadomicilio != "undefined") ? idprovinciadomicilio : p_id;
        var selected = (typeof iddistritodomicilio != "undefined")  ? iddistritodomicilio : "";

        
        principal.select({
            name: 'iddistritodomicilio',
            url: '/obtener_distritos',
            placeholder: seleccione,
            selected: selected,
            datos: { idprovincia:  p_id }
        }).then(function() {
            asociados.enter("iddistritodomicilio","direccion");
            
            var condicion = typeof idprovinciadomicilio == "undefined" && idprovinciadomicilio != "";
            condicion = condicion && typeof iddistritodomicilio == "undefined" && iddistritodomicilio != "";

            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idprovinciadomicilio");
                // if(required) {
                    $("#iddistritodomicilio")[0].selectize.focus();
                // }
            
            } 
        })


    });


    // principal.select({
    //     name: 'iddepartamentonacimiento',
    //     url: '/obtener_departamentos',
    //     placeholder: 'Departamento ...'
    // }).then(function() {
    
    //     $("#iddepartamentonacimiento").trigger("change", ["", ""]);
    //     $("#idprovincianacimiento").trigger("change", ["", ""]);
    // }) 



    // $(document).on('change', '#iddepartamentonacimiento', function(event, iddepartamentonacimiento, idprovincianacimiento) {

    //     var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
    //     d_id = (typeof iddepartamentonacimiento != "undefined" && iddepartamentonacimiento != null) ? iddepartamentonacimiento : d_id;
    //     var selected = (typeof idprovincianacimiento != "undefined")  ? idprovincianacimiento : "";
    
    //     principal.select({
    //         name: 'idprovincianacimiento',
    //         url: '/obtener_provincias',
    //         placeholder: 'Provincia ...',
    //         selected: selected,
    //         datos: { iddepartamentonacimiento: d_id }
    //     }).then(function() {
        
    //         var condicion = typeof iddepartamentonacimiento == "undefined";
    //         condicion = condicion && typeof idprovincianacimiento == "undefined";
        
    //         if(condicion) {
    //             var required = true;
    //             required = required && asociados.required("iddepartamentonacimiento");
    //             if(required) {
    //                 $("#idprovincianacimiento")[0].selectize.focus();
    //             }
    //         } 
        
        
            
    //     })

    // });


    // $(document).on('change', '#idprovincianacimiento', function(event, idprovincianacimiento, iddistritonacimiento) {

    //     var p_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
    //     p_id = (typeof idprovincianacimiento != "undefined") ? idprovincianacimiento : p_id;
    //     var selected = (typeof iddistritonacimiento != "undefined")  ? iddistritonacimiento : "";

        
    //     principal.select({
    //         name: 'iddistritonacimiento',
    //         url: '/obtener_distritos',
    //         placeholder: 'Distrito ...',
    //         selected: selected,
    //         datos: { idprovincianacimiento:  p_id }
    //     }).then(function() {
    //         asociados.enter("iddistritonacimiento","idestadocivil");
        
    //         var condicion = typeof idprovincianacimiento == "undefined";
    //         condicion = condicion && typeof iddistritonacimiento == "undefined";

    //         if(condicion) {
    //             var required = true;
    //             required = required && asociados.required("idprovincianacimiento");
    //             if(required) {
    //                 $("#iddistritonacimiento")[0].selectize.focus();
    //             }
            
    //         } 
    //     })


    // });



    divisiones.select({
        name: 'iddivision',
        url: '/obtener_divisiones',
        placeholder: seleccione
    }).then(function() {

        $("#iddivision").trigger("change", ["", ""]);
        $("#pais_id").trigger("change", ["", "", ""]);
        $("#idunion").trigger("change", ["", ""]);
        $("#idmision").trigger("change", ["", ""]);
        $("#iddistritomisionero").trigger("change", ["", ""]);
        $("#idiglesia").trigger("change", ["", ""]);
        
        
    }) 

    $(document).on('change', '#iddivision', function(event, iddivision, pais_id) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof iddivision != "undefined" && iddivision != null) ? iddivision : d_id;
        var selected = (typeof pais_id != "undefined")  ? pais_id : "";
    
        paises.select({
            name: 'pais_id',
            url: '/obtener_paises_asociados',
            placeholder: seleccione,
            selected: selected,
            datos: { iddivision: d_id }
        }).then(function(response) {
            
            var condicion = typeof iddivision == "undefined" && iddivision != "";
            condicion = condicion && typeof pais_id == "undefined" && pais_id != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("iddivision");
                // if(required) {
                    $("#pais_id")[0].selectize.focus();
                // }
            } 
        
        })

       
    });



    $(document).on('change', '#pais_id', function(event, pais_id, idunion, iddepartamentodomicilio) {
        var valor = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : "1|S"; 
        var array = valor.toString().split("|");
        //var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;   
    
        var d_id = array[0];
        var posee_union = array[1];
    
        var selected = (typeof idunion != "undefined")  ? idunion : "";
        var selected_iddepartamentodomicilio = (typeof iddepartamentodomicilio != "undefined")  ? iddepartamentodomicilio : "";

        var pais_id_change = document.getElementById("pais_id_change").value;
        if(pais_id_change != d_id) {
            jerarquia(d_id);
        }
       

        uniones.select({
            name: 'idunion',
            url: '/obtener_uniones_paises',
            placeholder: seleccione,
            selected: selected,
            datos: { pais_id: d_id }
        }).then(function() {
        
            var condicion = typeof pais_id == "undefined" && pais_id != "";
            condicion = condicion && typeof idunion == "undefined" && idunion != "";
            condicion = condicion && typeof iddepartamentodomicilio == "undefined" && iddepartamentodomicilio != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("pais_id");
                // if(required) {
                    $("#idunion")[0].selectize.focus();
                // }

             
                
            } 
        
        })
        if(posee_union == "N") {
            $(".union").hide();

            misiones.select({
                name: 'idmision',
                url: '/obtener_misiones',
                placeholder: seleccione,
                datos: { pais_id: d_id }
            })
        } else {
            $(".union").show();
        }

        
       
        if(pais_id_change != d_id) {
            document.getElementById("pais_id_change").value = d_id;

            principal.select({
                name: 'iddepartamentodomicilio',
                url: '/obtener_departamentos',
                placeholder: seleccione,
                selected: selected_iddepartamentodomicilio,
                datos: { pais_id: d_id }
            }).then(function() {
                var condicion = typeof pais_id == "undefined" && pais_id != "";
                condicion = condicion && typeof iddepartamentodomicilio == "undefined" && iddepartamentodomicilio != "";
    
                if(condicion) {
                    $("#iddepartamentodomicilio").trigger("change", ["", ""]);
                    $("#idprovinciadomicilio").trigger("change", ["", ""]);  
                }
            }) 
        }
       
       
        
    });



    $(document).on('change', '#idunion', function(event, idunion, idmision) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idunion != "undefined" && idunion != null) ? idunion : d_id;
        var selected = (typeof idmision != "undefined")  ? idmision : "";
    
        misiones.select({
            name: 'idmision',
            url: '/obtener_misiones',
            placeholder: seleccione,
            selected: selected,
            datos: { idunion: d_id }
        }).then(function() {
        
            var condicion = typeof idunion == "undefined" && idunion != "";
            condicion = condicion && typeof idmision == "undefined" && idmision != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idunion");
                // if(required) {
                    $("#idmision")[0].selectize.focus();
                // }
            } 
        
        })
    });

    $(document).on('change', '#idmision', function(event, idmision, iddistritomisionero) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idmision != "undefined" && idmision != null) ? idmision : d_id;
        var selected = (typeof iddistritomisionero != "undefined")  ? iddistritomisionero : "";
    
        distritos_misioneros.select({
            name: 'iddistritomisionero',
            url: '/obtener_distritos_misioneros',
            placeholder: seleccione,
            selected: selected,
            datos: { idmision: d_id }
        }).then(function() {
        
            var condicion = typeof idmision == "undefined" && idmision != "";
            condicion = condicion && typeof iddistritomisionero == "undefined" && iddistritomisionero != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idmision");
                // if(required) {
                    $("#iddistritomisionero")[0].selectize.focus();
                // }
            } 
        
        })
    });

    $(document).on('change', '#iddistritomisionero', function(event, iddistritomisionero, idiglesia) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof iddistritomisionero != "undefined" && iddistritomisionero != null) ? iddistritomisionero : d_id;
        var selected = (typeof idiglesia != "undefined")  ? idiglesia : "";
    
        iglesias.select({
            name: 'idiglesia',
            url: '/obtener_iglesias',
            placeholder: seleccione,
            selected: selected,
            datos: { iddistritomisionero: d_id }
        }).then(function() {
        
            var condicion = typeof iddistritomisionero == "undefined" && iddistritomisionero != "";
            condicion = condicion && typeof idiglesia == "undefined" && idiglesia != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("iddistritomisionero");
                // if(required) {
                    $("#idiglesia")[0].selectize.focus();
                // }
            } 
        
        })
    });


    function jerarquia(pais_id) {
        
        $(".jerarquia").hide();
        var jerarquia = document.getElementsByClassName("jerarquia");
        var promise = paises.ajax({
            url: '/obtener_jerarquia',
            datos: { pais_id: pais_id, _token: _token }
        }).then(function(response) {
            if(response.length > 0) {
                for (let index = 0; index < jerarquia.length; index++) {
                    if(typeof response[index] != "undefined") {
                        // console.log($(jerarquia[index]).find("label")[0]);
                        $(jerarquia[index]).show();
                        $(jerarquia[index]).find("label").text(jerarquia_traductor[response[index].descripcion]);
                    }
                
                    
                }
            }
            
            //console.log(response);
        })
        return promise;
    
    }

    document.getElementById("nuevo-asociado").addEventListener("click", function(event) {
        event.preventDefault();
        $(".modificar").hide();
        $("#bajas_altas").hide();
        $("#estado_asociado").hide();
        jerarquia("");

        $(".nav-tabs").find("li").removeClass("active");
        $("a[href='#datos-generales']").parent("li").addClass("active");
        $(".tab-pane").removeClass("active");
        $("#datos-generales").addClass("active");
        asociados.abrirModal();

        
    })

    document.getElementById("modificar-asociado").addEventListener("click", function(event) {
        event.preventDefault();

        var datos = asociados.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: "DEBE SELECCIONAR UN REGISTRO!"
            });
            return false;
        } 

        $(".modificar").show();
        $(".nav-tabs").find("li").removeClass("active");
        $("a[href='#datos-generales']").parent("li").addClass("active");
        $(".tab-pane").removeClass("active");
        $("#datos-generales").addClass("active");

        var promise = asociados.get(datos.idmiembro);

        promise.then(function(response) {   
            
            var array_pais = response.pais_id.split("|");
            jerarquia(array_pais[0]);
            crear_botones_altas_bajas(response.estado);
            if(response.foto != null) {
                document.getElementById("cargar_foto").setAttribute("src", BaseUrl+"/fotos_asociados/"+response.foto);
            } else {
                document.getElementById("cargar_foto").setAttribute("src", BaseUrl+"/images/camara.png");
            }

            if(response.posee_union == "N") {
                $(".union").hide();
            } else {
                $(".union").show();
            }

            $(".miembro").text(response.apellidos + ", "+response.nombres);

            asociados.asignarDatos({
                encargado_bautizo: response.encargado_bautizo,
                responsable_bautizo: response.responsable,
                tabla_encargado_bautizo: response.tabla_encargado_bautizo
                
            });

            document.getElementById("detalle-cargos").getElementsByTagName("tbody")[0].innerHTML = "";
            asociados.ajax({
                url: '/obtener_cargos_miembro',
                datos: { idmiembro: response.idmiembro, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-cargos").getElementsByTagName("tbody")[0].appendChild(html_detalle_cargos(response[i]));
                    }
                }
                //console.log(response);
            })

            document.getElementById("detalle-historial").getElementsByTagName("tbody")[0].innerHTML = "";

            asociados.ajax({
                url: '/obtener_historial_altas_bajas',
                datos: { idmiembro: response.idmiembro, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        // document.getElementById("detalle-historial").getElementsByTagName("tbody")[0].innerHTML = html_detalle_historial(response[i]);
                        document.getElementById("detalle-historial").getElementsByTagName("tbody")[0].appendChild(html_detalle_historial(response[i]));
                    }
                }
                //console.log(response);
            })

            document.getElementById("detalle-traslados").getElementsByTagName("tbody")[0].innerHTML = "";
            asociados.ajax({
                url: '/obtener_traslados',
                datos: { idmiembro: response.idmiembro, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        // document.getElementById("detalle-traslados").getElementsByTagName("tbody")[0].innerHTML = html_traslados(response[i]);

                        document.getElementById("detalle-traslados").getElementsByTagName("tbody")[0].appendChild(html_traslados(response[i]));
                    }
                }
                //console.log(response);
            })
            

            document.getElementById("detalle-capacitacion").getElementsByTagName("tbody")[0].innerHTML = "";
            asociados.ajax({
                url: '/obtener_capacitacion_miembro',
                datos: { idmiembro: response.idmiembro, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-capacitacion").getElementsByTagName("tbody")[0].appendChild(html_detalle_capacitaciones(response[i]));
                    }
                }
                //console.log(response);
            })

            


            // principal.select({
            //     name: 'iddepartamentodomicilio',
            //     url: '/obtener_departamentos',
            //     placeholder: seleccione,
            //     selected: response.iddepartamentodomicilio,
            //     datos: { pais_id: array_pais[0] }
            // }).then(function() {
                
            //     $("#iddepartamentodomicilio").trigger("change", [response.iddepartamentodomicilio, response.idprovinciadomicilio]);
            //     $("#idprovinciadomicilio").trigger("change", [response.idprovinciadomicilio, response.iddistritodomicilio]);
            // }) 

           

            $("#iddivision").trigger("change", [response.iddivision, response.pais_id]);
            $("#pais_id").trigger("change", [response.pais_id, response.idunion, response.iddepartamentodomicilio]);
            $("#idunion").trigger("change", [response.idunion, response.idmision]);
            $("#idmision").trigger("change", [response.idmision, response.iddistritomisionero]);
            $("#iddistritomisionero").trigger("change", [response.iddistritomisionero, response.idiglesia]);

            $("#iddepartamentodomicilio").trigger("change", [response.iddepartamentodomicilio, response.idprovinciadomicilio]);
            $("#idprovinciadomicilio").trigger("change", [response.idprovinciadomicilio, response.iddistritodomicilio]);
            
        })
        

    })

    function crear_botones_altas_bajas(estado) {
        if(estado == "1") {
            document.getElementById("estado_asociado").innerText = "Activo";
            document.getElementById("estado_asociado").style.backgroundColor = "#FFFF33";
            document.getElementById("estado_asociado").style.color = "black";
            button = '<button type="button" class="btn btn-danger btn-sm" id="dar-baja">Dar de Baja</button>';
            
        } else {
            document.getElementById("estado_asociado").innerText = "Inactivo";
            document.getElementById("estado_asociado").style.backgroundColor = "#666666";
            document.getElementById("estado_asociado").style.color = "white";
            button = '<button type="button" class="btn btn-success btn-sm" id="dar-alta">Dar de Alta</button>';

        }
        button += '<button type="button" class="btn btn-primary btn-sm" id="imprimir-ficha-asociado">Imprimir Ficha</button>';
        document.getElementById("bajas_altas").innerHTML = button;
    }

    document.getElementById("ver-asociado").addEventListener("click", function(event) {
        event.preventDefault();
        var datos = asociados.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: "DEBE SELECCIONAR UN REGISTRO!"
            });
            return false;
        }

        $(".modificar").show();
        $(".nav-tabs").find("li").removeClass("active");
        $("a[href='#datos-generales']").parent("li").addClass("active");
        $(".tab-pane").removeClass("active");
        $("#datos-generales").addClass("active");
        var promise = asociados.ver(datos.idmiembro);

        promise.then(function(response) {
            
            var array_pais = response.pais_id.split("|");
            jerarquia(array_pais[0]);
            crear_botones_altas_bajas(response.estado);
            if(response.foto != null) {
                document.getElementById("cargar_foto").setAttribute("src", BaseUrl+"/fotos_asociados/"+response.foto);
            } else {
                document.getElementById("cargar_foto").setAttribute("src", BaseUrl+"/images/camara.png");
            }

            if(response.posee_union == "N") {
                $(".union").hide();
            } else {
                $(".union").show();
            }

            $(".miembro").text(response.apellidos + ", "+response.nombres);

            asociados.asignarDatos({
                encargado_bautizo: response.encargado_bautizo,
                responsable_bautizo: response.responsable,
                tabla_encargado_bautizo: response.tabla_encargado_bautizo
                
            });


            asociados.ajax({
                url: '/obtener_cargos_miembro',
                datos: { idmiembro: response.idmiembro, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-cargos").getElementsByTagName("tbody")[0].appendChild(html_detalle_cargos(response[i]));
                    }
                }
                //console.log(response);
            })

            asociados.ajax({
                url: '/obtener_historial_altas_bajas',
                datos: { idmiembro: response.idmiembro, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-historial").getElementsByTagName("tbody")[0].appendChild(html_detalle_historial(response[i]));
                    }
                }
                //console.log(response);
            })


            // principal.select({
            //     name: 'iddepartamentodomicilio',
            //     url: '/obtener_departamentos',
            //     placeholder: seleccione,
            //     selected: response.iddepartamentodomicilio,
            //     datos: { pais_id: array_pais[0] }
            // }).then(function() {
                
            //     $("#iddepartamentodomicilio").trigger("change", [response.iddepartamentodomicilio, response.idprovinciadomicilio]);
            //     $("#idprovinciadomicilio").trigger("change", [response.idprovinciadomicilio, response.iddistritodomicilio]);
            // }) 

           

            $("#iddivision").trigger("change", [response.iddivision, response.pais_id]);
            $("#pais_id").trigger("change", [response.pais_id, response.idunion, response.iddepartamentodomicilio]);
            $("#idunion").trigger("change", [response.idunion, response.idmision]);
            $("#idmision").trigger("change", [response.idmision, response.iddistritomisionero]);
            $("#iddistritomisionero").trigger("change", [response.iddistritomisionero, response.idiglesia]);

            $("#iddepartamentodomicilio").trigger("change", [response.iddepartamentodomicilio, response.idprovinciadomicilio]);
            $("#idprovinciadomicilio").trigger("change", [response.idprovinciadomicilio, response.iddistritodomicilio]);
        })
    })


    // document.getElementById("eliminar-asociado").addEventListener("click", function(event) {
    //     event.preventDefault();
    //     var datos = asociados.datatable.row('.selected').data();
    //     if(typeof datos == "undefined") {
    //         BASE_JS.sweet({
    //             text: "DEBE SELECCIONAR UN REGISTRO!"
    //         });
    // 		return false;
    //     } 
        
    // 	BASE_JS.sweet({
    // 		confirm: true,
    // 		text: "¿SEGURO QUE DESEA ELIMINAR ESTE REGISTRO?",
    // 		callbackConfirm: function() {
    // 			asociados.Operacion(datos.idmiembro, 'E');
    // 			asociados.datatable.destroy();
    // 			asociados.TablaListado({
    // 				tablaID: '#tabla-asociados',
    // 				url: "/buscar_datos",
    // 			});
    // 	   }
    //    });
    // })

    document.getElementById("guardar-asociado").addEventListener("click", function(event) {
        event.preventDefault();
        var emailalternativo = document.getElementsByName("emailalternativo")[0].value;
        var pais_id = document.getElementsByName("pais_id")[0].value;
        var array_pais = pais_id.split("|");
        // alert(idmiembro);
        var required = true;
        required = required && asociados.required("nombres");
        required = required && asociados.required("apellidos");
        required = required && asociados.required("sexo");
        required = required && asociados.required("idtipodoc");
        required = required && asociados.required("nrodoc");
        required = required && asociados.required("celular");
        required = required && asociados.required("telefono");
        required = required && asociados.required("email");
        required = required && asociados.validar_email("email");
        if(emailalternativo != "") {
            required = required && asociados.validar_email("emailalternativo");
        }
        required = required && asociados.required("direccion");
        required = required && asociados.required("fechanacimiento");
        required = required && asociados.required("pais_id_nacimiento");
        required = required && asociados.required("ciudadnacextranjero");
        required = required && asociados.required("idestadocivil");
        required = required && asociados.required("idgradoinstruccion");
        required = required && asociados.required("idocupacion");
        // required = required && asociados.required("pais_id_nacionalidad");
        required = required && asociados.required("fecharegistro");
        
        required = required && asociados.required("iddivision");
        required = required && asociados.required("pais_id");
        // required = required && asociados.required("iddivision");
        if(array_pais[1] == "S") {
            required = required && asociados.required("idunion");
        }
        required = required && asociados.required("idmision");
        required = required && asociados.required("iddistritomisionero");
        required = required && asociados.required("idiglesia");

        if(required) {
            var promise = asociados.guardar();
            asociados.CerrarModal();
            promise.then(function(response) {
                if(typeof response.validacion != "undefined" && response.validacion == "ED") {
                    document.getElementsByName("nrodoc")[0].focus();
                } else {
                    // asociados.datatable.destroy();
                    // asociados.TablaListado({
                    //     tablaID: '#tabla-asociados',
                    //     url: "/buscar_datos",
                    // });
                }

                $(".nav-tabs").find("li").removeClass("active");
                $("a[href='#datos-generales']").parent("li").addClass("active");
                $(".tab-pane").removeClass("active");
                $("#datos-generales").addClass("active");

                
            })
            // asociados.CerrarModal();
            // asociados.LimpiarFormulario();
            

            document.getElementById("cargar_foto").setAttribute("src", BaseUrl+"/images/camara.png");
            // asociados.select({
            //     name: "modulo_padre",
            //     url:  '/obtenerPadres',
            // });
        }
    })



    document.addEventListener("keydown", function(event) {
        // console.log(event.target.name);
        // alert(modulo_controlador);
        if(modulo_controlador == "asociados/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-asociados').is(':visible')) {
                var botones = document.getElementsByTagName("button");
                for (let index = 0; index < botones.length; index++) {
                    if(botones[index].getAttribute("tecla_rapida") != null) {
                        if(botones[index].getAttribute("tecla_rapida") == event.code) {
                            document.getElementById(botones[index].getAttribute("id")).dispatchEvent(eventClick);
                            event.preventDefault();
                            event.stopPropagation();
                        }
                    }
                    //console.log(botones[index].getAttribute("tecla_rapida"));
                }

            } else {
                //NO HACER NADA EN CASO DE LAS TECLAS F4 ES QUE USUALMENTE ES PARA CERRAR EL NAVEGADOR Y EL F5 QUE ES PARA RECARGAR
                if(event.code == "F4" || event.code == "F5") {
                    event.preventDefault();
                    event.stopPropagation();
                }
            }

                    
            if(event.code == "F3") {
                //PARA LOS BUSCADORES DE LOS DATATABLES
                var inputs = document.getElementsByTagName("input");
                for (let index = 0; index < inputs.length; index++) {
                    // console.log(inputs[index].getAttribute("type"));
                    if(inputs[index].getAttribute("type") == "search") {
                        inputs[index].focus();
                        
                    }
                    //console.log(botones[index].getAttribute("tecla_rapida"));
                }
                event.preventDefault();
                event.stopPropagation();
                
            }

            if(event.code == "F9") {
            
                if($('#modal-asociados').is(':visible')) {
                    document.getElementById('guardar-asociado').dispatchEvent(eventClick);
                }
                
            
                event.preventDefault();
                event.stopPropagation();
            }
            
        
            
        
        
        
        }
    
        
    })

    document.getElementById("cancelar-asociado").addEventListener("click", function(event) {
        event.preventDefault();
        asociados.CerrarModal();
    })


    document.getElementById("cargar_foto").addEventListener("click", function(e) {
        e.preventDefault();
        document.getElementById("foto").click();
    })


    //url referencia previsualizar img: https://anexsoft.com/como-previsualizar-una-imagen-con-javascript-antes-de-subirla
    document.getElementById("foto").onchange = function(e) {
        // Creamos el objeto de la clase FileReader
        let reader = new FileReader();

        // Leemos el archivo subido y se lo pasamos a nuestro fileReader
        reader.readAsDataURL(e.target.files[0]);

        // Le decimos que cuando este listo ejecute el código interno
        reader.onload = function(){
            let images = document.getElementsByClassName("usuario_foto");
            for (var i = 0; i < images.length ; i++) {
                images[i].src = reader.result;
            }

        };
    }



    // $("input[name='tipolugarnac']").on('ifChecked', function(event){
    //     var tipolugarnac = $(this).val();
    //     if(tipolugarnac == "extranjero") {
    //         $(".extranjero").show();
    //         $(".nacional").hide();
    //     } else {
    //         $(".extranjero").hide();
    //         $(".nacional").show();
    //     }
    // });


    document.getElementById("cancelar-baja").addEventListener("click", function(event) {
        event.preventDefault();
        bajas.CerrarModal();
    })


    document.getElementById("cancelar-alta").addEventListener("click", function(event) {
        event.preventDefault();
        altas.CerrarModal();
    })


    $(document).on("click", "#dar-baja", function(e) {
        e.preventDefault();

        bajas.abrirModal();

        var idmiembro = document.getElementsByName("idmiembro")[0].value;
        document.getElementsByName("idmiembro_baja")[0].value = idmiembro;

        if(typeof responsables.datatable.length != "undefined") {
            responsables.datatable.destroy();
        }

        responsables.TablaListado({
            tablaID: '#tabla-responsables',
            url: "/buscar_datos_responsables",
            idmiembro: idmiembro
        });
        
        
    })


    $(document).on("click", "#dar-alta", function(e) {
        e.preventDefault();
        altas.abrirModal();

        var idmiembro = document.getElementsByName("idmiembro")[0].value;
    
        document.getElementsByName("idmiembro_alta")[0].value = idmiembro;
        
        if(typeof responsables.datatable.length != "undefined") {
            responsables.datatable.destroy();
        }

        responsables.TablaListado({
            tablaID: '#tabla-responsables',
            url: "/buscar_datos_responsables",
            idmiembro: idmiembro
        });
    })



    document.getElementById("buscar_responsable_baja").addEventListener("click", function(event) {
        event.preventDefault();
        $("#modal-lista-responsables").modal("show");
    })

    document.getElementById("buscar_responsable_alta").addEventListener("click", function(event) {
        event.preventDefault();
        $("#modal-lista-responsables").modal("show");
    })


    function cargar_datos_responsable(datos) {
        bajas.limpiarDatos("datos-responsable");
        altas.limpiarDatos("datos-responsable");
        //console.log(datos);
        bajas.asignarDatos({
            idresponsable: datos.id,
            responsable: datos.nombres,
            tabla: datos.tabla
            
        });
        altas.asignarDatos({
            idresponsable: datos.id,
            responsable: datos.nombres,
            tabla: datos.tabla
            
        });
        
        asociados.limpiarDatos("datos-encargado-bautizo");
        //console.log(datos);
        asociados.asignarDatos({
            encargado_bautizo: datos.id,
            responsable_bautizo: datos.nombres,
            tabla_encargado_bautizo: datos.tabla
            
        });

        $("#modal-lista-responsables").modal("hide");


    }

    $("#tabla-responsables").on('key.dt', function(e, datatable, key, cell, originalEvent){
        if(key === 13){
            var datos = responsables.datatable.row(cell.index().row).data();
            cargar_datos_responsable(datos);
        }
    });

    $('#tabla-responsables').on('dblclick', 'tr', function () {
        var datos = responsables.datatable.row( this ).data();
        cargar_datos_responsable(datos);
    });

    document.getElementById("guardar-baja").addEventListener("click", function(event) {
        event.preventDefault();
        
        var required = true;
        required = required && bajas.required("responsable");
        required = required && bajas.required("fecha");
        required = required && bajas.required("idmotivobaja");
        required = required && bajas.required("observaciones");   
        if(required) {
            bajas.guardar();
            bajas.CerrarModal();
            crear_botones_altas_bajas("0");
        }
    })


    document.getElementById("guardar-alta").addEventListener("click", function(event) {
        event.preventDefault();

        var required = true;
        required = required && altas.required("responsable");
        required = required && altas.required("fecha");
        required = required && altas.required("observaciones");   
        if(required) {
            altas.guardar();
            altas.CerrarModal();
            crear_botones_altas_bajas("1");
        }
    })


    document.getElementById("buscar-encargado-bautizo").addEventListener("click", function(event) {
        event.preventDefault();
        var idmiembro = document.getElementsByName("idmiembro")[0].value;
        if(typeof responsables.datatable.length != "undefined") {
            responsables.datatable.destroy();
        }

        responsables.TablaListado({
            tablaID: '#tabla-responsables',
            url: "/buscar_datos_responsables",
            idmiembro: idmiembro
        });

        $("#modal-lista-responsables").modal("show");
    })



    document.getElementById("agregar-cargo").addEventListener("click", function(e) {
        e.preventDefault();
        required = true;
        required = required && asociados.required("idtipocargo");
        required = required && asociados.required("idcargo");
        // required = required && asociados.required("idinstitucion");
        required = required && asociados.required("periodoini");
        required = required && asociados.required("periodofin");

        if(required) {

            var idtipocargo = document.getElementsByName("idtipocargo")[0];
            var idcargo = document.getElementsByName("idcargo")[0];
            var idnivel = document.getElementsByName("idnivel")[0];
            // var idinstitucion = document.getElementsByName("idinstitucion")[0];
            var periodoini = document.getElementsByName("periodoini")[0];
            var periodofin = document.getElementsByName("periodofin")[0];
            var observaciones_cargo = document.getElementsByName("observaciones_cargo")[0];
            var idiglesia = document.getElementsByName("idiglesia")[0];

            if(idiglesia.value == "") {
                BASE_JS.sweet({
                    text: "DEBE SELECCIONAR UNA IGLESIA!"
                });
                return false;
            }
        
        
            var objeto = {
                idtipocargo: idtipocargo.value,
                tipo_cargo: idtipocargo.options[idtipocargo.selectedIndex].text,
                idcargo: idcargo.value,
                cargo: idcargo.options[idcargo.selectedIndex].text,
                //idinstitucion: idinstitucion.value,
               // institucion: idinstitucion.options[idinstitucion.selectedIndex].text,
                idnivel: idnivel.value,
                periodoini: periodoini.value,
                periodofin: periodofin.value,
                observaciones_cargo: observaciones_cargo.value,
                idiglesia_cargo: idiglesia.value,
                vigente: 0
            }
        
        
            document.getElementById("detalle-cargos").getElementsByTagName("tbody")[0].appendChild(html_detalle_cargos(objeto));
            //$("#detalleAcciones > tbody").append(HTMLDetallemodulos(objeto));
            asociados.limpiarDatos("limpiar-cargos");
        }
    });



    function html_detalle_cargos(objeto, disabled) {
        var attr = '';
        var html = '';
        if(typeof disabled != "undefined") {
            attr = 'disabled="disabled"';
        }
        var tr = document.createElement("tr");
        var checked = "";
        if(objeto.vigente == 1) {
            checked = 'checked="checked"';
        }

        // console.log(objeto.idnivel);

        var array_tipos_cargo = objeto.idtipocargo.toString().split("|");

        html = '  <input type="hidden" name="idtipocargo[]" value="'+array_tipos_cargo[0]+'" >';
        html += '  <input type="hidden" name="idcargo[]" value="'+objeto.idcargo+'" >';
       // html += '  <input type="hidden" name="idinstitucion[]" value="'+objeto.idinstitucion+'" >';
        html += '  <input type="hidden" name="idnivel[]" value="'+objeto.idnivel+'" >';
        html += '  <input type="hidden" name="periodoini[]" value="'+objeto.periodoini+'" >';
        html += '  <input type="hidden" name="periodofin[]" value="'+objeto.periodofin+'" >';
        html += '  <input type="hidden" name="observaciones_cargo[]" value="'+objeto.observaciones_cargo+'" >';
        html += '  <input type="hidden" name="idiglesia_cargo[]" value="'+objeto.idiglesia_cargo+'" >';
        html += '  <td>'+objeto.tipo_cargo+'</td>';
        html += '  <td>'+objeto.cargo+'</td>';
        //html += '  <td>'+objeto.institucion+'</td>';
        html += '  <td>'+objeto.periodoini+'-'+objeto.periodofin+'</td>';
        html += '  <td>'+objeto.observaciones_cargo+'</td>';
        html += '  <td><center><input '+checked+' class="minimal entrada" type="checkbox" name="vigente[]" value="1" ></center></td>';
        html += '  <td><center><button '+attr+' type="button" class="btn btn-danger btn-xs eliminar-cargo"><i class="fa fa-trash-o" aria-hidden="true"></i></button></center></td>';

        tr.innerHTML = html;
        return tr;
    }

    document.getElementById("agregar-capacitacion").addEventListener("click", function(e) {
        e.preventDefault();
        required = true;
        required = required && asociados.required("anio");
        required = required && asociados.required("capacitacion");
        required = required && asociados.required("centro_estudios");

        if(required) {

            var anio = document.getElementsByName("anio")[0];
            var capacitacion = document.getElementsByName("capacitacion")[0];
            var centro_estudios = document.getElementsByName("centro_estudios")[0];
         
            var observaciones_capacitacion = document.getElementsByName("observaciones_capacitacion")[0];
       
            var objeto = {
                anio: anio.value,
                capacitacion: capacitacion.value,
                centro_estudios: centro_estudios.value,
           
                observaciones_capacitacion: observaciones_capacitacion.value,
              
            }
        
        
            document.getElementById("detalle-capacitacion").getElementsByTagName("tbody")[0].appendChild(html_detalle_capacitaciones(objeto));
            //$("#detalleAcciones > tbody").append(HTMLDetallemodulos(objeto));
            asociados.limpiarDatos("limpiar-capacitacion");
        }
    });


    function html_detalle_capacitaciones(objeto, disabled) {
        var attr = '';
        var html = '';
        if(typeof disabled != "undefined") {
            attr = 'disabled="disabled"';
        }
        var tr = document.createElement("tr");

        html = '  <input type="hidden" name="anio[]" value="'+objeto.anio+'" >';
        html += '  <input type="hidden" name="capacitacion[]" value="'+objeto.capacitacion+'" >';

        html += '  <input type="hidden" name="centro_estudios[]" value="'+objeto.centro_estudios+'" >';
       
        html += '  <input type="hidden" name="observaciones_capacitacion[]" value="'+objeto.observaciones_capacitacion+'" >';
      
        html += '  <td>'+objeto.anio+'</td>';
        html += '  <td>'+objeto.capacitacion+'</td>';
        html += '  <td>'+objeto.centro_estudios+'</td>';
   
        html += '  <td>'+objeto.observaciones_capacitacion+'</td>';
  
        html += '  <td><center><button '+attr+' type="button" class="btn btn-danger btn-xs eliminar-capacitacion"><i class="fa fa-trash-o" aria-hidden="true"></i></button></center></td>';

        tr.innerHTML = html;
        return tr;
    }

    function html_traslados(objeto) {

        var html = '';
        var tr = document.createElement("tr");
        html += '  <td>'+objeto.iglesia_anterior+'</td>';
        html += '  <td>'+objeto.iglesia_traslado+'</td>';

        html += '  <td>'+objeto.fecha+'</td>';
        tr.innerHTML = html;
        return tr;
    }

    function html_detalle_historial(objeto) {

        var html = '';
       
        var tr = document.createElement("tr");
    
        
        html += '  <td>'+objeto.tipo+'</td>';
        html += '  <td>'+objeto.motivo_baja+'</td>';
        html += '  <td>'+objeto.responsable+'</td>';
        html += '  <td>'+objeto.fecha+'</td>';
        html += '  <td>'+objeto.observaciones+'</td>';
        html += '  <td>'+objeto.rebautizo+'</td>';
    

        tr.innerHTML = html;
        return tr;
    }

    document.addEventListener("click", function(event) {

        // console.log(event.target.classList);
        // console.log(event.srcElement.parentNode.parentNode.parentNode.parentNode);
        if(event.target.classList.value.indexOf("eliminar-cargo") != -1) {
            event.preventDefault();
            event.srcElement.parentNode.parentNode.parentNode.remove();

        }

        if(event.srcElement.parentNode.classList.value.indexOf("eliminar-cargo") != -1 && !event.srcElement.parentNode.disabled) {
            event.preventDefault();
            ///console.log(event.srcElement.parentNode);
            event.srcElement.parentNode.parentNode.parentNode.parentNode.remove();
        }


        if(event.target.classList.value.indexOf("eliminar-capacitacion") != -1) {
            event.preventDefault();
            event.srcElement.parentNode.parentNode.parentNode.remove();

        }

        if(event.srcElement.parentNode.classList.value.indexOf("eliminar-capacitacion") != -1 && !event.srcElement.parentNode.disabled) {
            event.preventDefault();
            ///console.log(event.srcElement.parentNode);
            event.srcElement.parentNode.parentNode.parentNode.parentNode.remove();
        }

    })


    
    $(document).on("click", "#imprimir-ficha-asociado", function(e) {
        e.preventDefault();

        var idmiembro = document.getElementsByName("idmiembro")[0].value;
        window.open(BaseUrl + "/asociados/imprimir_ficha_asociado/"+idmiembro);
    })

    

})