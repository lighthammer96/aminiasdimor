var actividad_misionera = new BASE_JS('actividad_misionera', 'actividad_misionera');
var divisiones = new BASE_JS('divisiones', 'divisiones');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var distritos_misioneros = new BASE_JS('distritos_misioneros', 'distritos_misioneros');
var iglesias = new BASE_JS('iglesias', 'iglesias');


document.addEventListener("DOMContentLoaded", function() {
    

    actividad_misionera.select({
        name: 'idtrimestre',
        url: '/obtener_trimestres',
        placeholder: seleccione
    })
    
    actividad_misionera.select({
        name: 'anio',
        url: '/obtener_anios',
        placeholder: seleccione
    })
    
   
    divisiones.select({
        name: 'iddivision',
        url: '/obtener_divisiones',
        placeholder: seleccione
    }).then(function() {

        $("#iddivision").trigger("change", ["", ""]);
        $("#pais_id").trigger("change", ["", ""]);
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


    document.addEventListener("click", function(event) {
        var id = event.srcElement.id;
        if(id == "" && !event.srcElement.parentNode.disabled) {
            id = event.srcElement.parentNode.id;
        }
        //console.log(event.srcElement);
        switch (id) {
            case 'nuevo-perfil':
                event.preventDefault();
            
                actividad_misionera.abrirModal();
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
        var datos = actividad_misionera.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: "DEBE SELECCIONAR UN REGISTRO!"
            });
            
            return false;
        } 

        var promise = actividad_misionera.get(datos.perfil_id);

        promise.then(function(response) {
            actividad_misionera.ajax({
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
        // required = required && actividad_misionera.required("perfil_descripcion");

        var detalle = document.getElementById("detalle-traducciones").getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    
        if(detalle.length <= 0) {
            BASE_JS.sweet({
                text: 'DEBE INGRESAR AL MENOS UN ELEMENTO AL DETALLE!'
            });

            return false;
        }
        if(required) {
            var promise = actividad_misionera.guardar();
            actividad_misionera.CerrarModal();
            // actividad_misionera.datatable.destroy();
            // actividad_misionera.TablaListado({
            //     tablaID: '#tabla-actividad_misionera',
            //     url: "/buscar_datos",
            // });

            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }
                // $("select[name=perfil_id]").chosen("destroy");
                actividad_misionera.select({
                    name: 'perfil_id',
                    url: '/obtener_actividad_misionera',
                    placeholder: seleccione,
                    selected: response.id
                })
            })

        }
    }

    function eliminar_perfil() {
        var datos = actividad_misionera.datatable.row('.selected').data();
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
                actividad_misionera.Operacion(datos.perfil_id, "E");
                // actividad_misionera.datatable.destroy();
                // actividad_misionera.TablaListado({
                //     tablaID: '#tabla-actividad_misionera',
                //     url: "/buscar_datos",
                // });
            }
        });
    }



    document.addEventListener("keydown", function(event) {
            // alert(modulo_controlador);
        if(modulo_controlador == "actividad_misionera/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-actividad_misionera').is(':visible')) {
            
                switch (event.code) {
                    case 'F1':
                        actividad_misionera.abrirModal();
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
                
                if($('#modal-actividad_misionera').is(':visible')) {
                    guardar_perfil();
                }
                event.preventDefault();
                event.stopPropagation();
            }
            
        
        
        
        }
        // alert("ola");
        
    })

    document.getElementById("ver").addEventListener("click", function(event) {
        event.preventDefault();

        var pais_id = document.getElementsByName("pais_id")[0].value;
        var array_pais = pais_id.split("|");

        var required = true;

        required = required && actividad_misionera.required("iddivision");
        required = required && actividad_misionera.required("pais_id");
        // required = required && actividad_misionera.required("iddivision");
        if(array_pais[1] == "S") {
            required = required && actividad_misionera.required("idunion");
        }
        required = required && actividad_misionera.required("idmision");
        required = required && actividad_misionera.required("iddistritomisionero");
        required = required && actividad_misionera.required("idiglesia");
        required = required && actividad_misionera.required("anio");
        required = required && actividad_misionera.required("idtrimestre");

        if(!required) {
            actividad_misionera.ajax({
                url: '/obtener_actividades',
                
            }).then(function(response) {
                // console.log(response);

                var html = "";
                var semanal = "<tr></tr><th>Descripcion</th><th>Valor</th></tr>";
                var actmasiva = "<tr></tr><th>Descripcion</th><th>Valor</th></tr>";
                var actmasiva2 = "<tr></tr><th>Descripcion</th><th>Cantidad</th><th>Asistentes</th><th>Interesados</th></tr>";
                var materialestudiado = "<tr></tr><th>Descripcion</th><th>Valor</th></tr>";
                var cont = 1;
                if(response.length > 0) {
                    for (let index = 0; index < response.length; index++) {
                        if(response[index].tipo == "semanal") {
                            semanal += '<tr>';
                            semanal += '    <td>'+response[index].descripcion+'</td>';
                            semanal += '    <td style="width: 60px !important;"><input autofocus="autofocus" semana="'+cont+'" accion="valor" idactividadmisionera="'+response[index].idactividadmisionera+'" cont="'+cont+'" style="width: 100%; margin: 0 !important;" class="form-control input-sm" name="valor[]" type="number"></td>';
                            semanal += '</tr>';
                        }

                        if(response[index].tipo == "actmasiva") {
                            actmasiva += '<tr>';
                            actmasiva += '    <td>'+response[index].descripcion+'</td>';
                            actmasiva += '    <td style="width: 60px !important;"><input cont="'+cont+'" style="width: 100%; margin: 0 !important;" class="form-control input-sm" name="valor[]" type="number"></td>';
                            actmasiva += '</tr>';
                        }

                        if(response[index].tipo == "actmasiva2") {
                            actmasiva2 += '<tr>';
                            actmasiva2 += '    <td>'+response[index].descripcion+'</td>';
                            actmasiva2 += '    <td style="width: 60px !important;"><input cont="'+cont+'" style="width: 100%; margin: 0 !important;" class="form-control input-sm" name="valor[]" type="number"></td>';
                            cont++;
                            actmasiva2 += '    <td style="width: 60px !important;"><input cont="'+cont+'" style="width: 100%; margin: 0 !important;" class="form-control input-sm" name="valor[]" type="number"></td>';
                            cont++;
                            actmasiva2 += '    <td style="width: 60px !important;"><input cont="'+cont+'" style="width: 100%; margin: 0 !important;" class="form-control input-sm" name="valor[]" type="number"></td>';
                            actmasiva2 += '</tr>';
                        }

                        if(response[index].tipo == "materialestudiado") {
                            materialestudiado += '<tr>';
                            materialestudiado += '    <td>'+response[index].descripcion+'</td>';
                            materialestudiado += '    <td style="width: 60px !important;"><input cont="'+cont+'" style="width: 100%; margin: 0 !important;" class="form-control input-sm" name="valor[]" type="number"></td>';
                            materialestudiado += '</tr>';
                        }
                        cont++;
                    }

                    html += '<div class="col-md-5">';
                    html += '   <fieldset>';
                    html += '       <legend><strong>Actividad Misionera</strong></legend>';
                    html += '       <table style="margin-bottom: 0px !important;" class="table table-bordered table-striped" width="100%" bgcolor="#999999" border="0" align="center" cellpadding="3" cellspacing="1"><tbody>'+semanal+'</tbody></table>';
                    html += '   </fieldset>';
                    html += '</div>';

                    html += '<div class="col-md-7">';
                    html += '   <fieldset>';
                    html += '       <legend><strong>Actividades Masivas</strong></legend>';
                    html += '       <table style="margin-bottom: 0px !important;" class="table table-bordered table-striped" width="100%" bgcolor="#999999" border="0" align="center" cellpadding="3" cellspacing="1"><tbody>'+actmasiva+'</tbody></table>';
                    html += '   </fieldset>';
                    html += '   <fieldset>';
                    html += '       <legend><strong>Eventos Masivos</strong></legend>';
                    html += '       <table style="margin-bottom: 0px !important;" class="table table-bordered table-striped" width="100%" bgcolor="#999999" border="0" align="center" cellpadding="3" cellspacing="1"><tbody>'+actmasiva2+'</tbody></table>';
                    html += '   </fieldset>';
                    html += '   <fieldset>';
                    html += '       <legend><strong>Material Estudiado</strong></legend>';
                    html += '       <table style="margin-bottom: 0px !important;" class="table table-bordered table-striped" width="100%" bgcolor="#999999" border="0" align="center" cellpadding="3" cellspacing="1"><tbody>'+materialestudiado+'</tbody></table>';
                    html += '   </fieldset>';
                    html += '</div>';

                    document.getElementById("actividades").innerHTML = html;

                    $(document).on("keydown", "input[name='valor[]']", function() {
                        // console.log($(this));
                        var cont = parseInt($(this).attr("cont"));
                        if($(this).val() != "") {
                            $("input[cont="+(cont+1)+"]").focus();
                        }
                    })

                    $(document).on("change", "input[name='valor[]']", function() {
                        console.log($(this).val());
                    })
                }
                
            })  
            
        }
    })


})