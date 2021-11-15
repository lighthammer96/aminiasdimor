var resoluciones = new BASE_JS('resoluciones', 'resoluciones');
var propuestas_temas = new BASE_JS('propuestas_temas', 'propuestas');
var propuestas_elecciones = new BASE_JS('propuestas_elecciones', 'propuestas');

document.addEventListener("DOMContentLoaded", function() {
  

  
    var eventClick = new Event('click');

    resoluciones.enter("resolucion_descripcion","tipconv_id");
    resoluciones.enter("tipconv_id","resolucion_anio");
  
    resoluciones.enter("resolucion_fecha_inicio","resolucion_fecha_fin");
    resoluciones.enter("resolucion_fecha_fin","estado");
    resoluciones.enter("estado","detalle");
    resoluciones.enter("detalle","fecha");
    resoluciones.enter("fecha","hora");


    resoluciones.TablaListado({
        tablaID: '#tabla-resoluciones',
        url: "/buscar_datos",
    });


    
    function activar_entradas() {
        $(".traduccion").hide();
        $(".entrada").removeAttr("readonly");
        $(".select").removeAttr("disabled");
        // $(".traduccion").find("input").att("readonly", "readonly");
        // $(".traduccion").find("textarea").att("readonly", "readonly");
        // $("#pt_estado").removeAttr("disabled");
        // $("#pt_estado").removeAttr("readonly");
        $("#tr_idioma_origen").attr("readonly", "readonly");
        $("#tr_idioma_origen").attr("disabled", "disabled");
        $("#tr_idioma_traduccion").attr("readonly", "readonly");
        $("#tr_idioma_traduccion").attr("disabled", "disabled");
        $("input[name=anio_correlativo]").attr("readonly", "readonly");
        $("input[name=propuesta]").attr("readonly", "readonly");

      
    }

    function desactivar_entradas() {
        $(".traduccion").show();
        $(".entrada").attr("readonly", "readonly");
        $(".select").attr("disabled", "disabled");
        $(".traduccion").find("input").removeAttr("readonly");
        $(".traduccion").find("textarea").removeAttr("readonly");
        // $("#estado").removeAttr("disabled");
        // $("#estado").removeAttr("readonly");
        $("#tr_idioma_origen").removeAttr("readonly");
        $("#tr_idioma_origen").removeAttr("disabled");
        $("#tr_idioma_traduccion").removeAttr("readonly");
        $("#tr_idioma_traduccion").removeAttr("disabled");
        
        $("input[name=anio_correlativo]").attr("readonly", "readonly");
        $("input[name=propuesta]").attr("readonly", "readonly");
        $("#resolucion_estado").removeAttr("disabled");
        $("#resolucion_estado").removeAttr("readonly");
        // console.log($(".traduccion").find("select"));
        // $(".traduccion").find("select").prop("disabled", false);

       
    }


     function cambiar_row_1(tipo) {

        var html = '';
        if(tipo == "origen") {
      
            // html += '<div class="col-md-3  col-md-offset-6">';
            // html += '   <label class="control-label">'+estado+'</label>';
            // html += '   <select name="estado" id="estado" class="form-control input-sm entrada select" default-value="A">';
            // html += '       <option value="A">'+estado_activo+'</option>';
            // html += '       <option value="I">'+estado_inactivo+'</option>';
            // html += '   </select>';
            // html += '</div>';
            html += '<div class="col-md-3 col-md-offset-9" style="">';
            html += '   <label class="control-label">'+idioma+'</label>';
            html += '   <select class="entrada form-control input-sm select" name="tr_idioma" id="tr_idioma" default-value="es">';
            html += '       <option value="es">'+espaniol+'</option>';
            html += '       <option value="en">'+ingles+'</option>';
            html += '       <option value="fr">'+frances+'</option>';

            html += '   </select>';
            html += '</div>';
        }


        if(tipo == "traduccion") {
            // html += '<div class="col-md-3  col-md-offset-3>';
            // html += '   <label class="control-label">'+estado+'</label>';
            // html += '   <select name="estado" id="estado" class="form-control input-sm entrada select" default-value="A">';
            // html += '       <option value="A">'+estado_activo+'</option>';
            // html += '       <option value="I">'+estado_inactivo+'</option>';
            // html += '   </select>';
            // html += '</div>';
            html += '<div class="col-md-3 col-md-offset-6" style="">';
            html += '   <label class="control-label">'+de_traducir+'</label>';
            html += '   <select class="form-control input-sm select" name="tr_idioma_origen" id="tr_idioma_origen" default-value="es">';
            html += '       <option value="es">'+espaniol+'</option>';
            html += '       <option value="en">'+ingles+'</option>';
            html += '       <option value="fr">'+frances+'</option>';

            html += '   </select>';
            html += '</div>';
            html += '<div class="col-md-3" style="">';
            html += '   <label class="control-label">'+a+'</label>';
            html += '   <select class="entrada form-control input-sm select" name="tr_idioma_traduccion" id="tr_idioma_traduccion" default-value="en">';
            html += '       <option value="es">'+espaniol+'</option>';
            html += '       <option value="en">'+ingles+'</option>';
            html += '       <option value="fr">'+frances+'</option>';

            html += '   </select>';
            html += '</div>';
        }
        // alert(tipo);
        // alert(html);

        document.getElementsByClassName("cambiar-row-1")[0].innerHTML = html;

        $(document).on("change", "#tr_idioma_origen", function(e) {
            // alert(this.value);
            var idioma = $(this).val();
            var resolucion_id = document.getElementsByName("resolucion_id")[0].value;
            var promise = resoluciones.get(resolucion_id+'|'+idioma);


        })
        $(document).on("change", "#tr_idioma_traduccion", function(e) {
            // alert(this.value);
            var idioma = $(this).val();
            var resolucion_id = document.getElementsByName("resolucion_id")[0].value;

              
            var promise =  resoluciones.ajax({
                url: '/get_resoluciones',
                datos: { id: resolucion_id+'|'+idioma, _token: _token }
            })

            
            promise.then(function(response) {
                // alert(response.length);
                if(response.length > 0) {
                    // alert(response[0].tr_descripcion);
                    $("textarea[name=tr_descripcion_traduccion]").val(response[0].tr_descripcion);
                    
                }
            })


        })
      
    
    }



    document.getElementById("nueva-resolucion").addEventListener("click", function(event) {
        event.preventDefault();
        cambiar_row_1("origen");
        resoluciones.abrirModal();
        activar_entradas();
        
    })

    document.getElementById("modificar-resolucion").addEventListener("click", function(event) {
        event.preventDefault();

        var datos = resoluciones.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 

        if(datos.estado_resolucion == 2) {
            BASE_JS.sweet({
                text: registro_enviado_traduccion
            });
            return false;
        } 

        
        if(datos.estado_resolucion == 3) {
            BASE_JS.sweet({
                text: registro_traduccion_terminado
            });
            return false;
        } 


        cambiar_row_1("origen");
        var idioma = $("#tr_idioma").val();
        var promise = resoluciones.get(datos.resolucion_id+'|'+idioma);

        promise.then(function(response) {
            activar_entradas();
            if(response.tabla == "asambleas.propuestas_elecciones") {
                cargar_datos_propuestas_elecciones(response);
            }

            if(response.tabla == "asambleas.propuestas_temas") {
                cargar_datos_propuestas_temas(response);

            }
            
        })
        

    })


    document.getElementById("traducir-resolucion").addEventListener("click", function(event) {
        event.preventDefault();
      
        var datos = resoluciones.datatable.row('.selected').data();
        // console.table(datos);
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 

        if(datos.estado_resolucion == 1) {
            BASE_JS.sweet({
                text: registro_estado_enviado_traduccion
            });
            return false;
        } 

        if(datos.estado_resolucion == 3) {
            BASE_JS.sweet({
                text: registro_traduccion_terminado
            });
            return false;
        } 

    

        cambiar_row_1("traduccion");
        var idioma = $("#tr_idioma_origen").val();
        var promise = resoluciones.get(datos.resolucion_id+'|'+idioma);

        promise.then(function(response) {
            desactivar_entradas();
        });

        var idioma = 'en';
        

          
        var promise =  resoluciones.ajax({
            url: '/get_resoluciones',
            datos: { id: datos.resolucion_id+'|'+idioma, _token: _token }
        })

        
        promise.then(function(response) {
            // alert(response.length);
            if(response.length > 0) {
                // alert(response[0].tr_descripcion);
                $("textarea[name=tr_descripcion_traduccion]").val(response[0].tr_descripcion);
                
            }
        })

    })

    document.getElementById("eliminar-resolucion").addEventListener("click", function(event) {
        event.preventDefault();
      
        var datos = resoluciones.datatable.row('.selected').data();
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
                resoluciones.Operacion(datos.resolucion_id, "E");
            }
        });

        
    })




    document.getElementById("guardar-resolucion").addEventListener("click", function(event) {
        event.preventDefault();
 
        var resolucion_id = document.getElementsByName("resolucion_id")[0].value;
        var propuesta_id = document.getElementsByName("propuesta_id")[0].value;

        var required = true;
        if(resolucion_id == "") {

            required = required && resoluciones.required("tabla");
            required = required && resoluciones.required("tr_idioma");
            required = required && resoluciones.required("anio_correlativo");
            if(propuesta_id == "") {
                required = required && resoluciones.required("propuesta");
            }
            required = required && resoluciones.required("tr_descripcion");
            required = required && resoluciones.required("estado");
       
        }
        if(required) {
            var promise = resoluciones.guardar();
            resoluciones.CerrarModal();
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
        if(modulo_controlador == "resoluciones/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-resoluciones').is(':visible')) {
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
            
                if($('#modal-resoluciones').is(':visible')) {
                    document.getElementById('guardar-resolucion').dispatchEvent(eventClick);
                }
                
            
                event.preventDefault();
                event.stopPropagation();
            }
          
            
        
            
        
        
        
        }
    
        
    })

    document.getElementById("cancelar-resolucion").addEventListener("click", function(event) {
        event.preventDefault();
        resoluciones.CerrarModal();
    })

 

    
    document.addEventListener("click", function(event) {

        // console.log(event.target.classList);
        // console.log(event.srcElement.parentNode.parentNode.parentNode.parentNode);
        if(event.target.classList.value.indexOf("eliminar-agenda") != -1) {
            event.preventDefault();
            event.srcElement.parentNode.parentNode.parentNode.remove();

        }

        if(event.srcElement.parentNode.classList.value.indexOf("eliminar-agenda") != -1 && !event.srcElement.parentNode.disabled) {
            event.preventDefault();
            ///console.log(event.srcElement.parentNode);
            event.srcElement.parentNode.parentNode.parentNode.parentNode.remove();
        }


      
    })


    
    propuestas_temas.TablaListado({
        tablaID: '#tabla-propuestas-temas',
        url: "/buscar_datos",
        con_votacion: 'S'
    });

    propuestas_elecciones.TablaListado({
        tablaID: '#tabla-propuestas-elecciones',
        url: "/buscar_datos_elecciones",
        con_votacion: 'S'
    });

    function cargar_resultados(propuesta_id, tabla) {
      
        propuestas_elecciones.ajax({
            url: '/obtener_resultados',
            datos: { tabla: tabla, propuesta_id: propuesta_id }
        }).then(function(response) {
            if(response.length > 0) {
                document.getElementsByName("resultado_id")[0].value = response[0].resultado_id;
                var html = '';
                // if(response[0].fv_id == 6) {
                    for(let i = 0; i < response.length; i++){

                        var checked = (response[i].resultado_ganador == "S") ? 'checked="checked"' : "";
                        html += '<tr>';
                        html += '   <td>'+response[i].resultado_descripcion+'</td>';
                        html += '   <td >'+response[i].resultado_votos+'</td>';
                        html += '   <td><input resultado_votos="'+response[i].resultado_votos+'" resultado_id="'+response[i].resultado_id+'" cont="'+i+'" type="number" autofocus="autofocus" class="form-control input-sm" name="mano_alzada[]" value="'+response[i].resultado_mano_alzada+'"/></td>';
                        html += '   <td class="total">'+response[i].resultado_total+'</td>';
                        if(tabla == 'asambleas.propuestas_elecciones') {
                            if(response.resultado_ganador == "S") {

                                html += '   <td ><center><button type="button" class="btn btn-success btn-xs"><i class="fa fa-check"></i></button></center></td>';
                               
                            } else {

                                html += '   <td ><center><button type="button" class="btn btn-danger btn-xs"><i class="fa fa-close"></i></button></center></td>';
                            }
                            $(".ganador").show();
                        } else {
                            $(".ganador").hide();
                        }
                       
                        html += '</tr>';
                    }
                // }

               
                
                document.getElementById("detalle-resultados").getElementsByTagName("tbody")[0].innerHTML = html;
                $("#detalle-resultados").show();
            } else {
                BASE_JS.sweet({
                    text: no_hay_resultados
                });
            }
        })
    }
    document.getElementById("buscar_propuesta").addEventListener("click", function(event) {
        event.preventDefault();
        
        var tabla = $("#tabla").val();
        var required = true;
        required = required && resoluciones.required("tabla");
        if(required) {
            if(tabla == "asambleas.propuestas_temas") {

                $("#modal-propuestas-temas").modal("show");
            }

            if(tabla == "asambleas.propuestas_elecciones") {

                $("#modal-propuestas-elecciones").modal("show");
            }
        }
    })


    function cargar_datos_propuestas_temas(datos) {
        
        resoluciones.limpiarDatos("datos-propuesta");
        // console.log(datos);
        resoluciones.asignarDatos({
            propuesta_id: datos.pt_id,
            propuesta: datos.tpt_titulo,
            anio_correlativo: datos.anio+'-'+datos.pt_correlativo,
            // tabla: 'asambleas.propuestas_temas'
        });

        cargar_resultados(datos.pt_id, 'asambleas.propuestas_temas');
        $("#modal-propuestas-temas").modal("hide");
        

    }
    

    $("#tabla-propuestas-temas").on('key.dt', function(e, datatable, key, cell, originalEvent){
        if(key === 13){
            var datos = propuestas_temas.datatable.row(cell.index().row).data();
            cargar_datos_propuestas_temas(datos);
        }
    });

    $('#tabla-propuestas-temas').on('dblclick', 'tr', function () {
        var datos = propuestas_temas.datatable.row( this ).data();
        cargar_datos_propuestas_temas(datos);
    });



    
    function cargar_datos_propuestas_elecciones(datos) {
        
        resoluciones.limpiarDatos("datos-propuesta");
        // console.log(datos);
        resoluciones.asignarDatos({
            propuesta_id: datos.pe_id,
            propuesta: datos.tpe_descripcion,
            anio_correlativo: datos.anio+'-'+datos.pe_correlativo,
            // tabla: 'asambleas.propuestas_elecciones'
            
        });

        cargar_resultados(datos.pe_id, 'asambleas.propuestas_elecciones');
        $("#modal-propuestas-elecciones").modal("hide");


    }
    

    $("#tabla-propuestas-elecciones").on('key.dt', function(e, datatable, key, cell, originalEvent){
        if(key === 13){
            var datos = propuestas_elecciones.datatable.row(cell.index().row).data();
            cargar_datos_propuestas_elecciones(datos);
        }
    });

    $('#tabla-propuestas-elecciones').on('dblclick', 'tr', function () {
        var datos = propuestas_elecciones.datatable.row( this ).data();
        cargar_datos_propuestas_elecciones(datos);
    });

    document.getElementById("tabla").addEventListener("change", function(e) {
        resoluciones.limpiarDatos("datos-propuesta");
    })
})

