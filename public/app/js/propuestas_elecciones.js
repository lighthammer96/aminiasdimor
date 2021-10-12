var propuestas_elecciones = new BASE_JS('propuestas_elecciones', 'propuestas');
var votaciones = new BASE_JS('votaciones', 'propuestas');

var eventClick = new Event('click');

document.addEventListener("DOMContentLoaded", function() {
  

   
    votaciones.select({
        name: 'fv_id',
        url: '/obtener_formas_votacion',
        placeholder: seleccione
    })

    propuestas_elecciones.enter("asamblea_descripcion","tipconv_id");
    propuestas_elecciones.enter("tipconv_id","asamblea_anio");
  
    propuestas_elecciones.enter("asamblea_fecha_inicio","asamblea_fecha_fin");
    propuestas_elecciones.enter("asamblea_fecha_fin","estado");
    propuestas_elecciones.enter("estado","detalle");
    propuestas_elecciones.enter("detalle","fecha");
    propuestas_elecciones.enter("fecha","hora");

    propuestas_elecciones.enter("propuesta", "propuesta", function() {
        var required = true;
        required = propuestas_elecciones.required("propuesta");
     

        if(!required) {
            return false;
        }

        var propuesta = document.getElementsByName("propuesta")[0];
        var idioma = document.getElementsByName("tpe_idioma")[0];
    
        var objeto = {
            dp_descripcion: propuesta.value,
            dp_idioma: idioma.value,
           
        }


        document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(objeto));
    
        propuestas_elecciones.limpiarDatos("limpiar");
    });

    function html_detalle_propuesta(objeto, disabled) {
        var attr = '';
        var html = '';
        // if(typeof disabled != "undefined") {
        //     attr = 'disabled="disabled"';
        // }
        //alert(document.getElementsByName("tpe_descripcion")[0].readOnly);
        if(document.getElementsByName("tpe_descripcion")[0].readOnly) {
            attr = 'disabled="disabled"';
        }

        var tr = document.createElement("tr");

        if(!document.getElementsByName("tpe_descripcion")[0].readOnly) {

            html = '  <input type="hidden" name="dp_descripcion[]" value="'+objeto.dp_descripcion+'" >';
            html += '  <input type="hidden" name="dp_idioma[]" value="'+objeto.dp_idioma+'" >';
        }
        html += '  <td>'+objeto.dp_descripcion+'</td>';

        html += '  <td><center><button '+attr+' type="button" class="btn btn-danger btn-xs eliminar-propuesta"><i class="fa fa-trash-o" aria-hidden="true"></i></button></center></td>';

        tr.innerHTML = html;
        return tr;
    }



    propuestas_elecciones.enter("propuesta_traduccion", "propuesta_traduccion", function() {
        var required = true;
        required = propuestas_elecciones.required("propuesta_traduccion");
     

        if(!required) {
            return false;
        }

        var propuesta = document.getElementsByName("propuesta_traduccion")[0];
        var idioma = document.getElementsByName("tpe_idioma_traduccion")[0];
    
        var objeto = {
            dp_descripcion: propuesta.value,
            dp_idioma: idioma.value,
           
        }


        document.getElementById("detalle-propuesta-traduccion").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta_traduccion(objeto));
    
        propuestas_elecciones.limpiarDatos("limpiar");
    });

    function html_detalle_propuesta_traduccion(objeto, disabled) {
        var attr = '';
        var html = '';
        // if(typeof disabled != "undefined") {
        //     attr = 'disabled="disabled"';
        // }
        //alert(document.getElementsByName("tpe_descripcion")[0].readOnly);
        // if(document.getElementsByName("tpe_descripcion")[0].readOnly) {
        //     attr = 'disabled="disabled"';
        // }

        var tr = document.createElement("tr");

      
        html = '  <input type="hidden" name="dp_descripcion[]" value="'+objeto.dp_descripcion+'" >';
        html += '  <input type="hidden" name="dp_idioma[]" value="'+objeto.dp_idioma+'" >';
        
        html += '  <td>'+objeto.dp_descripcion+'</td>';

        html += '  <td><center><button '+attr+' type="button" class="btn btn-danger btn-xs eliminar-propuesta"><i class="fa fa-trash-o" aria-hidden="true"></i></button></center></td>';

        tr.innerHTML = html;
        return tr;
    }



 
    $(function() {
        $('input[type="radio"], input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass   : 'iradio_minimal-blue'
        })
    })



    propuestas_elecciones.TablaListado({
        tablaID: '#tabla-propuestas-elecciones',
        url: "/buscar_datos_elecciones",
    });



    function activar_entradas() {
        $(".traduccion").hide();
        $(".sin-traduccion").show();
        $(".con-traduccion").hide();
        $(".entrada").removeAttr("readonly");
        $(".select").removeAttr("disabled");
        // $(".traduccion").find("input").att("readonly", "readonly");
        // $(".traduccion").find("textarea").att("readonly", "readonly");
        // $("#pt_estado").removeAttr("disabled");
        // $("#pt_estado").removeAttr("readonly");
        $("#tpe_idioma_origen").attr("readonly", "readonly");
        $("#tpe_idioma_origen").attr("disabled", "disabled");
        $("#tpe_idioma_traduccion").attr("readonly", "readonly");
        $("#tpe_idioma_traduccion").attr("disabled", "disabled");
       
    }

    function desactivar_entradas() {
        $(".traduccion").show();
        $(".con-traduccion").show();
        $(".sin-traduccion").hide();

        $(".entrada").attr("readonly", "readonly");
        $(".select").attr("disabled", "disabled");
        $(".traduccion").find("input").removeAttr("readonly");
        $(".traduccion").find("textarea").removeAttr("readonly");
        $("#pe_estado").removeAttr("disabled");
        $("#pe_estado").removeAttr("readonly");
        $("#tpe_idioma_origen").removeAttr("readonly");
        $("#tpe_idioma_origen").removeAttr("disabled");
        $("#tpe_idioma_traduccion").removeAttr("readonly");
        $("#tpe_idioma_traduccion").removeAttr("disabled");
        
        // console.log($(".traduccion").find("select"));
        // $(".traduccion").find("select").prop("disabled", false);       
    }

    function cambiar_row_1(tipo) {

        var html = '';
        if(tipo == "origen") {
            html += '<div class="col-md-6">';
            html += '   <label class="control-label">'+descripcion+'</label>';
            html += '   <input type="text" class="form-control input-sm entrada" name="tpe_descripcion" placeholder="" />';
            html += '</div>';
        

            html += '<div class="col-md-3" style="">';
            html += '   <label class="control-label">'+idioma+'</label>';
            html += '   <select class="entrada form-control input-sm select" name="tpe_idioma" id="tpe_idioma" default-value="es">';
            html += '       <option value="es">'+espaniol+'</option>';
            html += '       <option value="en">'+ingles+'</option>';
            html += '       <option value="fr">'+frances+'</option>';

            html += '   </select>';
            html += '</div>';
        }


        if(tipo == "traduccion") {
            html += '<div class="col-md-6">';
            html += '   <label class="control-label">'+descripcion+'</label>';
            html += '   <input type="text" class="form-control input-sm entrada" name="tpe_descripcion" placeholder="" />';
            html += '</div>';
        

            html += '<div class="col-md-3" style="">';
            html += '   <label class="control-label">'+idioma+'</label>';
            html += '   <select class="form-control input-sm select" name="tpe_idioma_origen" id="tpe_idioma_origen" default-value="es">';
            html += '       <option value="es">'+espaniol+'</option>';
            html += '       <option value="en">'+ingles+'</option>';
            html += '       <option value="fr">'+frances+'</option>';

            html += '   </select>';
            html += '</div>';
            
            html += '<div class="col-md-3" style="">';
            html += '   <label class="control-label">'+a+':</label>';
            html += '   <select class="entrada form-control input-sm select" name="tpe_idioma_traduccion" id="tpe_idioma_traduccion" default-value="en">';
            html += '       <option value="es">'+espaniol+'</option>';
            html += '       <option value="en">'+ingles+'</option>';
            html += '       <option value="fr">'+frances+'</option>';

            html += '   </select>';
            html += '</div>';
        }
        // alert(tipo);
        // alert(html);

        document.getElementsByClassName("cambiar-row-1")[0].innerHTML = html;

        $(document).on("change", "#tpe_idioma_origen", function(e) {
            // alert(this.value);
            var idioma = $(this).val();
            var pe_id = document.getElementsByName("pe_id")[0].value;
            var promise = propuestas_elecciones.get(pe_id+'|'+idioma);
            promise.then(function(response) {
                document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].innerHTML = "";
                propuestas_elecciones.ajax({
                    url: '/obtener_detalle_propuesta',
                    datos: { pe_id: response.pe_id, _token: _token, idioma: idioma }
                }).then(function(response) {
                    if(response.length > 0) {
                        for(let i = 0; i < response.length; i++){
                            document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(response[i]));
                        }
                    }

                })
            })

        })


        $(document).on("change", "#tpe_idioma_traduccion", function(e) {
            // alert(this.value);
            var idioma = $(this).val();
            var pe_id = document.getElementsByName("pe_id")[0].value;
            
            var promise =  propuestas_elecciones.ajax({
                url: '/get_propuestas_elecciones',
                datos: { id: pe_id+'|'+idioma, _token: _token }
            })

            promise.then(function(response) {
                // console.log(response);
                if(response.length > 0) {
                    $("input[name=tpe_descripcion_traduccion]").val(response[0].tpe_descripcion);
                    $("textarea[name=tpe_detalle_propuesta_traduccion]").val(response[0].tpe_detalle_propuesta);
                }
            
                document.getElementById("detalle-propuesta-traduccion").getElementsByTagName("tbody")[0].innerHTML = "";
                propuestas_elecciones.ajax({
                    url: '/obtener_detalle_propuesta',
                    datos: { pe_id: response[0].pe_id, _token: _token, idioma: idioma }
                }).then(function(response) {
                    desactivar_entradas();
                    if(response.length > 0) {
                        for(let i = 0; i < response.length; i++){
                            document.getElementById("detalle-propuesta-traduccion").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta_traduccion(response[i]));
                        }
                    }
                    //console.log(response);
                })
                
            })

        })
      
    
    }

    document.getElementById("nueva-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
        $("#someter-votacion").hide();
        cambiar_row_1("origen");
        propuestas_elecciones.abrirModal();
        activar_entradas();

        
    })

    document.getElementById("modificar-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();

        var datos = propuestas_elecciones.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 


        
        if(datos.estado_propuesta == 3) {
            BASE_JS.sweet({
                text: registro_traduccion_terminado
            });
            return false;
        } 

        $("#someter-votacion").hide();
        cambiar_row_1("origen");
        var idioma = $("#tpe_idioma").val();
         
        var promise = propuestas_elecciones.get(datos.pe_id+'|'+idioma);

        promise.then(function(response) {
            
            document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].innerHTML = "";
            propuestas_elecciones.ajax({
                url: '/obtener_detalle_propuesta',
                datos: { pe_id: response.pe_id, _token: _token, idioma: idioma }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(response[i]));
                    }
                }
                activar_entradas();
                //console.log(response);
            })
            
        })
        

    })

    document.getElementById("eliminar-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
      
        var datos = propuestas_elecciones.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 
        BASE_JS.sweet({
            confirm: true,
            text: eliminar_registro,
            callbackConfirm: function() {
                propuestas_elecciones.Operacion(datos.pe_id, "E");
            }
        });

        
    })


    
    document.getElementById("traducir-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
      
        var datos = propuestas_elecciones.datatable.row('.selected').data();
        // console.table(datos);
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 
        // console.log(typeof datos.estado_propuesta);
        if(datos.estado_propuesta == 1) {
            BASE_JS.sweet({
                text: registro_estado_enviado_traduccion
            });
            return false;
        } 

        // propuestas_elecciones.abrirModal();

        // $(".origen").hide();
        // $(".traducir").show();
       

        $("#someter-votacion").hide();
        cambiar_row_1("traduccion");
        var idioma = $("#tpe_idioma_origen").val();
       
        var promise = propuestas_elecciones.get(datos.pe_id+'|'+idioma);

        promise.then(function(response) {
          
            document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].innerHTML = "";
            propuestas_elecciones.ajax({
                url: '/obtener_detalle_propuesta',
                datos: { pe_id: response.pe_id, _token: _token, idioma: 'es' }
            }).then(function(response) {
                desactivar_entradas();
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(response[i]));
                    }
                }
                //console.log(response);
            })

         
            
        })




        idioma = 'en';
        //  alert(idioma_traduccion);
       
        var promise =  propuestas_elecciones.ajax({
            url: '/get_propuestas_elecciones',
            datos: { id: datos.pe_id+'|'+idioma, _token: _token }
        })

        promise.then(function(response) {
            // console.log(response);
            if(response.length > 0) {
                $("input[name=tpe_descripcion_traduccion]").val(response[0].tpe_descripcion);
                $("textarea[name=tpe_detalle_propuesta_traduccion]").val(response[0].tpe_detalle_propuesta);
            }
           
            document.getElementById("detalle-propuesta-traduccion").getElementsByTagName("tbody")[0].innerHTML = "";
            propuestas_elecciones.ajax({
                url: '/obtener_detalle_propuesta',
                datos: { pe_id: response[0].pe_id, _token: _token, idioma: idioma }
            }).then(function(response) {
                desactivar_entradas();
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-propuesta-traduccion").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta_traduccion(response[i]));
                    }
                }
                //console.log(response);
            })
            
        })
        
    })



    document.getElementById("votacion-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();

        var datos = propuestas_elecciones.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 


        if(datos.estado_propuesta == 1) {
            BASE_JS.sweet({
                text: registro_estado_terminado
            });
            return false;
        } 

        $("#someter-votacion").show();
        cambiar_row_1("origen");
        var idioma = $("#tpe_idioma").val();
         
        var promise = propuestas_elecciones.ver(datos.pe_id+'|'+idioma);

        promise.then(function(response) {
            
            document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].innerHTML = "";
            propuestas_elecciones.ajax({
                url: '/obtener_detalle_propuesta',
                datos: { pe_id: response.pe_id, _token: _token, idioma: idioma }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(response[i]));
                    }
                }


                
               
            })

            $("#pe_someter_votacion").removeAttr("disabled");

            // console.log(votaciones.buscarEnFormulario("votacion_id"));
            votaciones.buscarEnFormulario("votacion_id").value = response.votacion_id;
            // votaciones.buscarEnFormulario("convocatoria").setAttribute("default-value", response.asamblea_descripcion);
            votaciones.buscarEnFormulario("propuesta").setAttribute("default-value", response.tpe_descripcion);
            //votaciones.buscarEnFormulario("asamblea_id").setAttribute("default-value", asamblea_id);
            votaciones.buscarEnFormulario("tabla").setAttribute("default-value", "asambleas.propuestas_elecciones");
            votaciones.buscarEnFormulario("propuesta_id").setAttribute("default-value", datos.pe_id);
            
        })
        

    })


    document.getElementById("guardar-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
 

        var required = true;
        var pe_id = document.getElementsByName("pe_id")[0].value;

        if(pe_id == "") {
            required = required && propuestas_elecciones.required("tpe_descripcion");
            required = required && propuestas_elecciones.required("tpe_idioma");
         
            required = required && propuestas_elecciones.required("estado");
        }

        if(required) {
            var promise = propuestas_elecciones.guardar();
            propuestas_elecciones.CerrarModal();
            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }

           
                
            })

        }
    })



    document.addEventListener("keydown", function(event) {
        // console.log(event.target.name);
        // alert(modulo_controlador);
        if(modulo_controlador == "propuestas_elecciones/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-propuestas_elecciones').is(':visible')) {
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
            
                if($('#modal-propuestas_elecciones').is(':visible')) {
                    document.getElementById('guardar-propuesta-eleccion').dispatchEvent(eventClick);
                }
                
            
                event.preventDefault();
                event.stopPropagation();
            }
          
            
        
            
        
        
        
        }
    
        
    })

    document.getElementById("cancelar-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
        propuestas_elecciones.CerrarModal();
    })
    
    document.getElementById("cancelar-votaciones").addEventListener("click", function(event) {
        event.preventDefault();
        votaciones.CerrarModal();
    })
 

    
    document.addEventListener("click", function(event) {

        // console.log(event.target.classList);
        // console.log(event.srcElement.parentNode.parentNode.parentNode.parentNode);
        if(event.target.classList.value.indexOf("eliminar-propuesta") != -1) {
            event.preventDefault();
            event.srcElement.parentNode.parentNode.parentNode.remove();

        }

        if(event.srcElement.parentNode.classList.value.indexOf("eliminar-propuesta") != -1 && !event.srcElement.parentNode.disabled) {
            event.preventDefault();
            ///console.log(event.srcElement.parentNode);
            event.srcElement.parentNode.parentNode.parentNode.parentNode.remove();
        }


      
    })


    document.getElementById("guardar-votaciones").addEventListener("click", function(event) {
        event.preventDefault();
 

        var required = true;
        var votacion_id = document.getElementsByName("votacion_id")[0].value;

        if(votacion_id == "") {
            required = required && votaciones.required("fv_id");
    
            required = required && votaciones.required("votacion_hora_apertura");
            required = required && votaciones.required("votacion_hora_cierre");
        }

      
     
    
        // alert(required);
        if(required) {
            var promise = votaciones.guardar();
            // votaciones.CerrarModal();
            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }
                $("input[name=votacion_id]").val(response.id);
                $("#fv_id").val(response.datos[0].fv_id);
                $("input[name=votacion_hora_apertura]").val(response.datos[0].votacion_hora_apertura);
                $("input[name=votacion_hora_cierre]").val(response.datos[0].votacion_hora_cierre);
                $("input[name=estado]").val(response.datos[0].estado);
            })

        }
    })

    
    $("#pe_someter_votacion").on('ifClicked', function(event){
        var votacion_id = document.getElementsByName("votacion_id")[0].value;
        // alert(votacion_id);
        if(!$(this).parent(".icheckbox_minimal-blue").hasClass("checked")) {
            // $("#modal-votaciones").modal("show");

            var promise =  votaciones.get(votacion_id);

            promise.then(function() {
                votaciones.buscarEnFormulario("estado").value = 'A';

                if(votacion_id != "") {
                    document.getElementById("guardar-votaciones").dispatchEvent(eventClick);
                }
            })
            // votaciones.abrirModal();
            // $("input[name=posee_seguro]").val("S");
            
        } else {
            votaciones.buscarEnFormulario("estado").value = 'I';
            document.getElementById("guardar-votaciones").dispatchEvent(eventClick);
            // $("input[name=posee_seguro]").val("N");
        }
    });

    document.getElementById("cerrar-votaciones").addEventListener("click", function(event) {
        event.preventDefault();
        // $("#modal-votaciones").modal("hide");

        votaciones.CerrarModal();
    })


    document.getElementById("time-votacion_hora_apertura").addEventListener("click", function(e) {
        e.preventDefault();
        
        if($("input[name=votacion_hora_apertura]").hasClass("focus-time")) {
   
            $("input[name=votacion_hora_apertura]").blur();
            $("input[name=votacion_hora_apertura]").removeClass("focus-time");
        } else {
            
            $("input[name=votacion_hora_apertura]").focus();
            $("input[name=votacion_hora_apertura]").addClass("focus-time");
        }
       
    }); 


    document.getElementById("time-votacion_hora_cierre").addEventListener("click", function(e) {
        e.preventDefault();
        
        if($("input[name=votacion_hora_cierre]").hasClass("focus-time")) {
   
            $("input[name=votacion_hora_cierre]").blur();
            $("input[name=votacion_hora_cierre]").removeClass("focus-time");
        } else {
            
            $("input[name=votacion_hora_cierre]").focus();
            $("input[name=votacion_hora_cierre]").addClass("focus-time");
        }
       
    }); 
    
    $('input[name=votacion_hora_apertura], input[name=votacion_hora_cierre]').inputmask("hh:mm", {
        placeholder: "HH:MM", 
        insertMode: false, 
        showMaskOnHover: false,
        hourFormat: 12
      }
   );

})

