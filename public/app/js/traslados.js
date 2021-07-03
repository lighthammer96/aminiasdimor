var divisiones = new BASE_JS('divisiones', 'divisiones');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var distritos_misioneros = new BASE_JS('distritos_misioneros', 'distritos_misioneros');
var iglesias = new BASE_JS('iglesias', 'iglesias');


var traslados = new BASE_JS('traslados', 'traslados');
var traslados_temp = new BASE_JS('traslados_temp', 'traslados');


document.addEventListener("DOMContentLoaded", function() {

    document.addEventListener("click", function(event) {
        var id = event.srcElement.id;
        if(id == "" && !event.srcElement.parentNode.disabled) {
            id = event.srcElement.parentNode.id;
        }
        //console.log(event.srcElement);
        switch (id) {
            case 'nuevo-perfil':
                event.preventDefault();
            
                traslados.abrirModal();
            break;

            case 'modificar-perfil':
                event.preventDefault();
            
                modificar_perfil();
            break;

            case 'eliminar-perfil':
                event.preventDefault();
                eliminar_perfil();
            break;

            case 'guardar-perfil':
                event.preventDefault();
                guardar_perfil();
            break;

        }

    })


    function modificar_perfil() {
        var datos = traslados.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: "DEBE SELECCIONAR UN REGISTRO!"
            });
            
            return false;
        } 

        var promise = traslados.get(datos.perfil_id);

        promise.then(function(response) {
            traslados.ajax({
                url: '/obtener_traducciones',
                datos: { perfil_id: response.perfil_id, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-traducciones").getElementsByTagName("tbody")[0].appendChild(html_detalle_traducciones(response[i]));
                    }
                }
                //console.log(response);
            })
        })
    }

    function guardar_perfil() {
        var required = true;
        // required = required && traslados.required("perfil_descripcion");

        var detalle = document.getElementById("detalle-traducciones").getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    
        if(detalle.length <= 0) {
            BASE_JS.sweet({
                text: 'DEBE INGRESAR AL MENOS UN ELEMENTO AL DETALLE!'
            });

            return false;
        }
        if(required) {
            var promise = traslados.guardar();
            traslados.CerrarModal();
            // traslados.datatable.destroy();
            // traslados.TablaListado({
            //     tablaID: '#tabla-traslados',
            //     url: "/buscar_datos",
            // });

            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }
                // $("select[name=perfil_id]").chosen("destroy");
                traslados.select({
                    name: 'perfil_id',
                    url: '/obtener_traslados',
                    placeholder: seleccione,
                    selected: response.id
                })
            })

        }
    }

    function eliminar_perfil() {
        var datos = traslados.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: "DEBE SELECCIONAR UN REGISTRO!"
            });
            return false;
        } 
        BASE_JS.sweet({
            confirm: true,
            text: "¿SEGURO QUE DESEA ELIMINAR ESTE REGISTRO?",
            callbackConfirm: function() {
                traslados.Operacion(datos.perfil_id, "E");
                // traslados.datatable.destroy();
                // traslados.TablaListado({
                //     tablaID: '#tabla-traslados',
                //     url: "/buscar_datos",
                // });
            }
        });
    }



    document.addEventListener("keydown", function(event) {
            // alert(modulo_controlador);
        if(modulo_controlador == "traslados/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-traslados').is(':visible')) {
            
                switch (event.code) {
                    case 'F1':
                        traslados.abrirModal();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    case 'F2':
                        modificar_perfil();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    // case 'F4':
                    // 	VerPrecio();
                    // 	event.preventDefault();
                    // 	event.stopPropagation();
                    
                    //     break;
                    case 'F7':
                        eliminar_perfil();
                        event.preventDefault();
                        event.stopPropagation();
                    
                        break;
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
                
                if($('#modal-traslados').is(':visible')) {
                    guardar_perfil();
                }
                event.preventDefault();
                event.stopPropagation();
            }
            
        
        
        
        }
        // alert("ola");
        
    })





    divisiones.select({
        name: 'iddivision',
        url: '/obtener_divisiones',
        placeholder: seleccione
    }).then(function() {

        $("#iddivision").trigger("change", ["", "", ""]);
        $("#pais_id").trigger("change", ["", "", ""]);
        $("#idunion").trigger("change", ["", "", ""]);
        $("#idmision").trigger("change", ["", "", ""]);
        $("#iddistritomisionero").trigger("change", ["", "", ""]);
        $("#idiglesia").trigger("change", ["", "", ""]);
        
        
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
            
            var condicion = typeof iddivision == "undefined";
            condicion = condicion && typeof pais_id == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("iddivision");
                if(required) {
                    $("#pais_id")[0].selectize.focus();
                }
            } 
        
        })
    });



    $(document).on('change', '#pais_id', function(event, pais_id, idunion) {
        var valor = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : "1|S"; 
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
        
            var condicion = typeof pais_id == "undefined";
            condicion = condicion && typeof idunion == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("pais_id");
                if(required) {
                    $("#idunion")[0].selectize.focus();
                }
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
    
        misiones.select({
            name: 'idmision',
            url: '/obtener_misiones',
            placeholder: seleccione,
            selected: selected,
            datos: { idunion: d_id }
        }).then(function() {
        
            var condicion = typeof idunion == "undefined";
            condicion = condicion && typeof idmision == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("idunion");
                if(required) {
                    $("#idmision")[0].selectize.focus();
                }
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
        
            var condicion = typeof idmision == "undefined";
            condicion = condicion && typeof iddistritomisionero == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("idmision");
                if(required) {
                    $("#iddistritomisionero")[0].selectize.focus();
                }
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
        
            var condicion = typeof iddistritomisionero == "undefined";
            condicion = condicion && typeof idiglesia == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("iddistritomisionero");
                if(required) {
                    $("#idiglesia")[0].selectize.focus();
                }
            } 
        
        })
    });



    /*********************
     * JERARQUIA DESTINO *
     *********************/



    divisiones.select({
        name: 'iddivisiondestino',
        url: '/obtener_divisiones_todos',
        placeholder: seleccione
    }).then(function() {

        $("#iddivisiondestino").trigger("change", ["", "", ""]);
        $("#pais_iddestino").trigger("change", ["", "", ""]);
        $("#iduniondestino").trigger("change", ["", "", ""]);
        $("#idmisiondestino").trigger("change", ["", "", ""]);
        $("#iddistritomisionerodestino").trigger("change", ["", "", ""]);
        $("#idiglesiadestino").trigger("change", ["", "", ""]);
        
        
    }) 

    $(document).on('change', '#iddivisiondestino', function(event, iddivisiondestino, pais_iddestino) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof iddivisiondestino != "undefined" && iddivisiondestino != null) ? iddivisiondestino : d_id;
        var selected = (typeof pais_iddestino != "undefined")  ? pais_iddestino : "";
    
        paises.select({
            name: 'pais_iddestino',
            url: '/obtener_paises_asociados_todos',
            placeholder: seleccione,
            selected: selected,
            datos: { iddivision: d_id }
        }).then(function(response) {
            
            var condicion = typeof iddivisiondestino == "undefined";
            condicion = condicion && typeof pais_iddestino == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("iddivisiondestino");
                if(required) {
                    $("#pais_iddestino")[0].selectize.focus();
                }
            } 
        
        })
    });



    $(document).on('change', '#pais_iddestino', function(event, pais_iddestino, iduniondestino) {
        var valor = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : "1|S"; 
        var array = valor.toString().split("|");
        //var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;   
    
        var d_id = array[0];
        var posee_union = array[1];
    
        var selected = (typeof iduniondestino != "undefined")  ? iduniondestino : "";
        uniones.select({
            name: 'iduniondestino',
            url: '/obtener_uniones_paises_todos',
            placeholder: seleccione,
            selected: selected,
            datos: { pais_id: d_id }
        }).then(function() {
        
            var condicion = typeof pais_iddestino == "undefined";
            condicion = condicion && typeof iduniondestino == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("pais_iddestino");
                if(required) {
                    $("#iduniondestino")[0].selectize.focus();
                }
            } 
        
        })
        if(posee_union == "N") {
            $(".union-destino").hide();

            misiones.select({
                name: 'idmisiondestino',
                url: '/obtener_misiones_todos',
                placeholder: seleccione,
                datos: { pais_id: d_id }
            })
        } else {
            $(".union-destino").show();
        }
        
    });



    $(document).on('change', '#iduniondestino', function(event, iduniondestino, idmisiondestino) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof iduniondestino != "undefined" && iduniondestino != null) ? iduniondestino : d_id;
        var selected = (typeof idmisiondestino != "undefined")  ? idmisiondestino : "";
    
        misiones.select({
            name: 'idmisiondestino',
            url: '/obtener_misiones_todos',
            placeholder: seleccione,
            selected: selected,
            datos: { idunion: d_id }
        }).then(function() {
        
            var condicion = typeof iduniondestino == "undefined";
            condicion = condicion && typeof idmisiondestino == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("iduniondestino");
                if(required) {
                    $("#idmisiondestino")[0].selectize.focus();
                }
            } 
        
        })
    });

    $(document).on('change', '#idmisiondestino', function(event, idmisiondestino, iddistritomisionerodestino) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idmisiondestino != "undefined" && idmisiondestino != null) ? idmisiondestino : d_id;
        var selected = (typeof iddistritomisionerodestino != "undefined")  ? iddistritomisionerodestino : "";
    
        distritos_misioneros.select({
            name: 'iddistritomisionerodestino',
            url: '/obtener_distritos_misioneros_todos',
            placeholder: seleccione,
            selected: selected,
            datos: { idmision: d_id }
        }).then(function() {
        
            var condicion = typeof idmisiondestino == "undefined";
            condicion = condicion && typeof iddistritomisionerodestino == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("idmisiondestino");
                if(required) {
                    $("#iddistritomisionerodestino")[0].selectize.focus();
                }
            } 
        
        })
    });

    $(document).on('change', '#iddistritomisionerodestino', function(event, iddistritomisionerodestino, idiglesiadestino) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof iddistritomisionerodestino != "undefined" && iddistritomisionerodestino != null) ? iddistritomisionerodestino : d_id;
        var selected = (typeof idiglesiadestino != "undefined")  ? idiglesiadestino : "";
    
        iglesias.select({
            name: 'idiglesiadestino',
            url: '/obtener_iglesias',
            placeholder: seleccione,
            selected: selected,
            datos: { iddistritomisionero: d_id }
        }).then(function() {
        
            var condicion = typeof iddistritomisionerodestino == "undefined";
            condicion = condicion && typeof idiglesiadestino == "undefined";
        
            if(condicion) {
                var required = true;
                required = required && traslados_temp.required("iddistritomisionerodestino");
                if(required) {
                    $("#idiglesiadestino")[0].selectize.focus();
                }
            } 
        
        })
    });


    document.getElementById("ver-lista").addEventListener("click", function(e) {
        e.preventDefault();
        var pais_id = document.getElementsByName("pais_id")[0].value;
        var array_pais = pais_id.split("|");

        var pais_iddestino = document.getElementsByName("pais_iddestino")[0].value;
        var array_pais_destino = pais_iddestino.split("|");

        required = true;

        required = required && traslados_temp.required("iddivision");
        required = required && traslados_temp.required("pais_id");
        // required = required && traslados_temp.required("iddivision");
        if(array_pais[1] == "S") {
            required = required && traslados_temp.required("idunion");
        }
        required = required && traslados_temp.required("idmision");
        required = required && traslados_temp.required("iddistritomisionero");
        required = required && traslados_temp.required("idiglesia");


        required = required && traslados_temp.required("iddivisiondestino");
        required = required && traslados_temp.required("pais_iddestino");
        // required = required && traslados_temp.required("iddivision");
        if(array_pais_destino[1] == "S") {
            required = required && traslados_temp.required("iduniondestino");
        }
        required = required && traslados_temp.required("idmisiondestino");
        required = required && traslados_temp.required("iddistritomisionerodestino");
        required = required && traslados_temp.required("idiglesiadestino");


        if(required) {
        
            traslados_temp.guardar();
        }
    
    });

})