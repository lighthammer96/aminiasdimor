var propuestas_temas = new BASE_JS('propuestas_temas', 'propuestas');
var asambleas = new BASE_JS('asambleas', 'asambleas');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var principal = new BASE_JS('principal', 'principal');
var asociados = new BASE_JS('asociados', 'asociados');

document.addEventListener("DOMContentLoaded", function() {
    
    asociados.TablaListado({
        tablaID: '#tabla-asociados',
        url: "/buscar_datos",
    });


    var format = "";
    if(idioma_codigo == "es") {
        format = "dd/mm/yyyy";
      
        $("input[name=pt_fecha_reunion_cpag], input[name=pt_fecha_reunion_uya]").attr("data-inputmask", "'alias': '"+format+"'");
    } else {
        format = "yyyy-mm-dd";
  
        $("input[name=pt_fecha_reunion_cpag], input[name=pt_fecha_reunion_uya]").attr("data-inputmask", "'alias': '"+format+"'");
        
    }
    var eventClick = new Event('click');

    propuestas_temas.enter("propuesta-tema_descripcion","tipconv_id");
    propuestas_temas.enter("tipconv_id","propuesta-tema_anio");
  
    propuestas_temas.enter("propuesta-tema_fecha_inicio","propuesta-tema_fecha_fin");
    propuestas_temas.enter("propuesta-tema_fecha_fin","estado");
    propuestas_temas.enter("estado","detalle");
    propuestas_temas.enter("detalle","fecha");
    propuestas_temas.enter("fecha","hora");

 




    $("input[name=pt_fecha_reunion_cpag], input[name=pt_fecha_reunion_uya]").inputmask();

  
 
    jQuery( "input[name=pt_fecha_reunion_cpag], input[name=pt_fecha_reunion_uya]").datepicker({
        format: format,
        language: "es",
        todayHighlight: true,
        todayBtn: "linked",
        autoclose: true,
        // endDate: "now()",

    });

    $(function() {
        $('input[type="radio"], input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass   : 'iradio_minimal-blue'
        })
    })





    
    asambleas.select({
        name: 'asamblea_id',
        url: '/obtener_asambleas',
        placeholder: seleccione
    })

    principal.select({
        name: 'cp_id',
        url: '/obtener_categorias_propuestas',
        placeholder: seleccione
    })

    

    propuestas_temas.TablaListado({
        tablaID: '#tabla-propuestas-temas',
        url: "/buscar_datos",
    });


    paises.select({
        name: 'pais_id',
        url: '/obtener_paises',
        placeholder: seleccione
    }).then(function() {
        $("#pais_id").trigger("change", ["", "", ""]);
        $("#idunion").trigger("change", ["", ""]);
        $("#idmision").trigger("change", ["", ""]);
        
        
        
    }) 

    
    $(document).on('change', '#pais_id', function(event, pais_id, idunion, iddepartamentodomicilio, pais_id_domicilio) {
        // alert(pais_id);
        var valor = "1|S"; 

        if($(this).val() != "" && $(this).val() != null) {
            valor = $(this).val();
        } 

        if(pais_id != "" && pais_id != null) {
            valor = pais_id;
        } 
        var array = valor.toString().split("|");
        //var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;   
    
        var d_id = array[0];
        var posee_union = array[1];
    
        var selected = (typeof idunion != "undefined")  ? idunion : "";
    
       

        uniones.select({
            name: 'idunion',
            url: '/obtener_uniones_paises',
            placeholder: seleccione,
            selected: selected,
            datos: { pais_id: d_id }
        }).then(function() {
        
            var condicion = typeof pais_id == "undefined" && pais_id != "";
            condicion = condicion && typeof idunion == "undefined" && idunion != "";
     
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("pais_id");
                // if(required) {
                    // $("#idunion")[0].selectize.focus();
                    $("#idunion").focus();
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

        
       
       
       
        
    });



    $(document).on('change', '#idunion', function(event, idunion, idmision) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idunion != "undefined" && idunion != null) ? idunion : d_id;
        var selected = (typeof idmision != "undefined")  ? idmision : "";
        if(typeof this.options[this.selectedIndex] != "undefined" && this.options[this.selectedIndex].getAttribute("atributo1") != "null") {
            document.getElementsByName("pt_email")[0].value = this.options[this.selectedIndex].getAttribute("atributo1");
        }

        if(typeof this.options != "undefined" && typeof this.options[this.selectedIndex] != "undefined" && this.options.length > 0) {

            document.getElementById("lugar").value = this.options[this.selectedIndex].text;
            document.getElementById("idlugar").value = this.value;
            document.getElementById("tabla").value = "iglesias.union";
        }
        // console.log(this.options[this.selectedIndex].getAttribute("atributo1"))
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
                    $("#idmision").focus();
                    // $("#idmision")[0].selectize.focus();
                // }
            } 
        
        })
    });

    $(document).on('change', '#idmision', function(event, idmision, iddistritomisionero) {
        if(typeof this.options != "undefined" && typeof this.options[this.selectedIndex] != "undefined" && this.options.length > 0) {

            document.getElementById("lugar").value = this.options[this.selectedIndex].text;
            document.getElementById("idlugar").value = this.value;
            document.getElementById("tabla").value = "iglesias.mision";
        }
    });




    document.getElementById("nueva-propuesta-tema").addEventListener("click", function(event) {
        event.preventDefault();
        
        propuestas_temas.abrirModal();
        propuestas_temas.ajax({
            url: '/obtener_correlativo',
            datos: { _token: _token }
        }).then(function(response) {
        //    console.table(response);
           if(typeof response[0].correlativo != "undefined") {
               document.getElementsByName("pt_correlativo")[0].value = response[0].correlativo;
           }
        })

        
    })

    document.getElementById("modificar-propuesta-tema").addEventListener("click", function(event) {
        event.preventDefault();

        var datos = propuestas_temas.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 


        var promise = propuestas_temas.get(datos.pt_id);

        promise.then(function(response) {
            var valor = response.asamblea_id.toString().split("|");
            var tipconv_id = valor[0];
            var asamblea_id = valor[1];



            if(tipconv_id == 1) {
                $(".mision").show();
                $(".union").show();
            }

            if(tipconv_id == 2) {
                $(".mision").hide();
                $(".union").show();

            }

            if(tipconv_id == 3) {
                $(".mision").show();
                $(".union").show();
            }

            $("#pais_id").trigger("change", [response.pais_id, response.idunion]);
            $("#idunion").trigger("change", [response.idunion, response.idmision]);
            $("#idmision").trigger("change", [response.idmision, ""]);
            
        })
        

    })

    document.getElementById("eliminar-propuesta-tema").addEventListener("click", function(event) {
        event.preventDefault();
      
        var datos = propuestas_temas.datatable.row('.selected').data();
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
                propuestas_temas.Operacion(datos.pt_id, "E");
            }
        });

        
    })




    document.getElementById("guardar-propuesta-tema").addEventListener("click", function(event) {
        event.preventDefault();
 

        var required = true;

        required = required && propuestas_temas.required("asamblea_id");
        required = required && propuestas_temas.required("pt_idioma");
        required = required && propuestas_temas.required("cp_id");
        required = required && propuestas_temas.required("pt_propuesta");

        required = required && propuestas_temas.required("estado");
       
       

   
        if(required) {
            var promise = propuestas_temas.guardar();
            propuestas_temas.CerrarModal();
            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }

           
                propuestas_temas.ajax({
                    url: '/obtener_correlativo',
                    datos: { _token: _token }
                }).then(function(response) {
                //    console.table(response);
                if(typeof response[0].correlativo != "undefined") {
                    document.getElementsByName("pt_correlativo")[0].value = response[0].correlativo;
                }
                })
            })

        }
    })



    document.addEventListener("keydown", function(event) {
        // console.log(event.target.name);
        // alert(modulo_controlador);
        if(modulo_controlador == "propuestas_temas/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-propuestas_temas').is(':visible')) {
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
            
                if($('#modal-propuestas_temas').is(':visible')) {
                    document.getElementById('guardar-propuesta-tema').dispatchEvent(eventClick);
                }
                
            
                event.preventDefault();
                event.stopPropagation();
            }
          
            
        
            
        
        
        
        }
    
        
    })

    document.getElementById("cancelar-propuesta-tema").addEventListener("click", function(event) {
        event.preventDefault();
        propuestas_temas.CerrarModal();
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


    


    document.getElementById("calendar-pt_fecha_reunion_uya").addEventListener("click", function(e) {
        e.preventDefault();
        if($("input[name=pt_fecha_reunion_uya]").hasClass("focus-datepicker")) {
   
            $("input[name=pt_fecha_reunion_uya]").blur();
            $("input[name=pt_fecha_reunion_uya]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=pt_fecha_reunion_uya]").focus();
            $("input[name=pt_fecha_reunion_uya]").addClass("focus-datepicker");
        }
    });


    document.getElementById("calendar-pt_fecha_reunion_cpag").addEventListener("click", function(e) {
        e.preventDefault();
        
        if($("input[name=pt_fecha_reunion_cpag]").hasClass("focus-datepicker")) {
   
            $("input[name=pt_fecha_reunion_cpag]").blur();
            $("input[name=pt_fecha_reunion_cpag]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=pt_fecha_reunion_cpag]").focus();
            $("input[name=pt_fecha_reunion_cpag]").addClass("focus-datepicker");
        }
       
    });

   

    document.getElementById("asamblea_id").addEventListener("click", function(e) {
        e.preventDefault();
        var valor = this.value.toString().split("|");
        var tipconv_id = valor[0];
        var asamblea_id = valor[1];



        if(tipconv_id == 1) {
            $(".mision").show();
            $(".union").show();
        }

        if(tipconv_id == 2) {
            $(".mision").hide();
            $(".union").show();

        }

        if(tipconv_id == 3) {
            $(".mision").show();
            $(".union").show();
        }

    })

    document.getElementById("buscar_asociado").addEventListener("click", function(event) {
        event.preventDefault();
        $("#modal-lista-asociados").modal("show");
    })


    function cargar_datos_asociado(datos) {
        propuestas_temas.limpiarDatos("datos-asociado");
        //console.log(datos);
        propuestas_temas.asignarDatos({
            pt_dirigido_por_uya: datos.idmiembro,
            asociado: datos.nombres
            
        });
        $("#modal-lista-asociados").modal("hide");


    }

    $("#tabla-asociados").on('key.dt', function(e, datatable, key, cell, originalEvent){
        if(key === 13){
            var datos = asociados.datatable.row(cell.index().row).data();
            cargar_datos_asociado(datos);
        }
    });

    $('#tabla-asociados').on('dblclick', 'tr', function () {
        var datos = asociados.datatable.row( this ).data();
        cargar_datos_asociado(datos);
    });

    
  
    
    

})

