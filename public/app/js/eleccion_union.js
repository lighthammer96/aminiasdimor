var eleccion_union = new BASE_JS('eleccion_union', 'eleccion');
var divisiones = new BASE_JS('divisiones', 'divisiones');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var distritos_misioneros = new BASE_JS('distritos_misioneros', 'distritos_misioneros');
var iglesias = new BASE_JS('iglesias', 'iglesias');
var asociados = new BASE_JS('asociados', 'asociados');

document.addEventListener("DOMContentLoaded", function() {

    eleccion_union.select_init({
        placeholder: seleccione
    })

    eleccion_union.buscarEnFormulario("feligresiaanterior").solo_numeros();
    eleccion_union.buscarEnFormulario("delegados").solo_numeros();
    eleccion_union.buscarEnFormulario("feligresiaactual").solo_numeros();


    $(function() {
        $('input[type="radio"], input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass   : 'iradio_minimal-blue'
        })
    })


    var format = "";
    if(idioma_codigo == "es") {
        format = "dd/mm/yyyy";
        // document.getElementsByName("fechaingresoiglesia")[0].setAttribute("default-value", BASE_JS.ObtenerFechaActual("user"));
        $("input[name=fecha], input[name=fechaanterior]").attr("data-inputmask", "'alias': '"+format+"'");
    } else {
        format = "yyyy-mm-dd";
        // document.getElementsByName("fechaingresoiglesia")[0].setAttribute("default-value", BASE_JS.ObtenerFechaActual("server"));
        $("input[name=fecha], input[name=fechaanterior]").attr("data-inputmask", "'alias': '"+format+"'");

    }

    $("input[name=fecha], input[name=fechaanterior]").inputmask();


    jQuery( "input[name=fechaanterior]" ).datepicker({
        format: format,
        language: "es",
        todayHighlight: true,
        todayBtn: "linked",
        autoclose: true,
        endDate: "now()",

    });

    jQuery( "input[name=fecha]" ).datepicker({
        format: format,
        language: "es",
        todayHighlight: true,
        todayBtn: "linked",
        autoclose: true,
        // endDate: "now()",

    });


    eleccion_union.TablaListado({
        tablaID: '#tabla-eleccion_union',
        url: "/buscar_datos_union",
    });



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
                // required = required && iglesias.required("iddivision");
                // if(required) {
                    $("#pais_id")[0].selectize.focus();
                // }
            }

        })
    });



    $(document).on('change', '#pais_id', function(event, pais_id, idunion) {

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
        //var selected_iddepartamento = (typeof iddepartamento != "undefined")  ? iddepartamento : "";
        // jerarquia(d_id);

        uniones.select({
            name: 'idunion',
            url: '/obtener_uniones_paises',
            placeholder: seleccione,
            selected: selected,
            datos: { pais_id: d_id }
        }).then(function() {

            var condicion = typeof pais_id == "undefined" && pais_id != "";
            condicion = condicion && typeof idunion == "undefined" && idunion != "";
            // condicion = condicion && typeof iddepartamento == "undefined" && iddepartamento != "";

            if(condicion) {
                // var required = true;
                // required = required && iglesias.required("pais_id");
                // if(required) {
                    $("#idunion")[0].selectize.focus();
                // }


                // if(session_pais_id != d_id) {

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
                // required = required && iglesias.required("idunion");
                // if(required) {
                    $("#idmision")[0].selectize.focus();
                // }
            }

        })
    });

    // $(document).on('change', '#idmision', function(event, idmision, iddistritomisionero) {

    //     var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;
    //     d_id = (typeof idmision != "undefined" && idmision != null) ? idmision : d_id;
    //     var selected = (typeof iddistritomisionero != "undefined")  ? iddistritomisionero : "";

    //     distritos_misioneros.select({
    //         name: 'iddistritomisionero',
    //         url: '/obtener_distritos_misioneros',
    //         placeholder: seleccione,
    //         selected: selected,
    //         datos: { idmision: d_id }
    //     }).then(function() {

    //         var condicion = typeof idmision == "undefined" && idmision != "";
    //         condicion = condicion && typeof iddistritomisionero == "undefined" && iddistritomisionero != "";

    //         if(condicion) {
    //             // var required = true;
    //             // required = required && iglesias.required("idmision");
    //             // if(required) {
    //                 $("#iddistritomisionero")[0].selectize.focus();
    //             // }
    //         }

    //     })
    // });

    // $(document).on('change', '#iddistritomisionero', function(event, iddistritomisionero, idiglesia) {

    //     var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;
    //     d_id = (typeof iddistritomisionero != "undefined" && iddistritomisionero != null) ? iddistritomisionero : d_id;
    //     var selected = (typeof idiglesia != "undefined")  ? idiglesia : "";

    //     iglesias.select({
    //         name: 'idiglesia',
    //         url: '/obtener_iglesias',
    //         placeholder: seleccione,
    //         selected: selected,
    //         datos: { iddistritomisionero: d_id }
    //     }).then(function() {

    //         var condicion = typeof iddistritomisionero == "undefined" && iddistritomisionero != "";
    //         condicion = condicion && typeof idiglesia == "undefined" && idiglesia != "";

    //         if(condicion) {
    //             // var required = true;
    //             // required = required && asociados.required("iddistritomisionero");
    //             // if(required) {
    //                 $("#idiglesia")[0].selectize.focus();
    //             // }
    //         }

    //     })
    // });



    document.addEventListener("click", function(event) {
        var id = event.srcElement.id;
        if(id == "" && !event.srcElement.parentNode.disabled) {
            id = event.srcElement.parentNode.id;
        }
        //console.log(event.srcElement);
        switch (id) {
            case 'nueva-eleccion_union':
                event.preventDefault();

                eleccion_union.abrirModal();
            break;

            case 'modificar-eleccion_union':
                event.preventDefault();

                modificar_eleccion_union();
            break;

            case 'eliminar-eleccion_union':
                event.preventDefault();
                eliminar_eleccion_union();
            break;

            case 'guardar-eleccion_union':
                event.preventDefault();
                guardar_eleccion_union();
            break;

        }

    })


    function modificar_eleccion_union() {
        var datos = eleccion_union.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });

            return false;
        }

        var promise = eleccion_union.get(datos.ideleccion);

        promise.then(function(response) {


            document.getElementById("detalle-oficiales").getElementsByTagName("tbody")[0].innerHTML = "";
            eleccion_union.ajax({
                url: '/obtener_oficiales',
                datos: { ideleccion: response.ideleccion }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-oficiales").getElementsByTagName("tbody")[0].appendChild(html_detalle_oficiales(response[i]));
                    }
                }
                //console.log(response);
            })


            if(response.posee_union == "N") {
                $(".union").hide();
            } else {
                $(".union").show();
            }

            $("#iddivision").trigger("change", [response.iddivision, response.pais_id]);
            $("#pais_id").trigger("change", [response.pais_id, response.idunion]);
            $("#idunion").trigger("change", [response.idunion, response.idmision]);
            // $("#idmision").trigger("change", [response.idmision, response.iddistritomisionero]);

        })
    }

    function guardar_eleccion_union() {
        var pais_id = document.getElementsByName("pais_id")[0].value;
        var array_pais = pais_id.split("|");
        var required = true;

        var detalle = document.getElementById("detalle-oficiales").getElementsByTagName("tbody")[0].getElementsByTagName("tr");

        if(detalle.length <= 0) {
            BASE_JS.sweet({
                text: elemento_detalle
            });

            return false;
        }
        // required = required && eleccion_union.required("perfil_descripcion");

        required = required && eleccion_union.required("iddivision");
        required = required && eleccion_union.required("pais_id");
        // required = required && eleccion_union.required("iddivision");
        if(array_pais[1] == "S") {
            required = required && eleccion_union.required("idunion");
        }
        // required = required && eleccion_union.required("idmision");
        // required = required && eleccion_union.required("iddistritomisionero");
        // required = required && eleccion_union.required("idiglesia");
        required = required && eleccion_union.required("periodoini");
        required = required && eleccion_union.required("periodofin");
        required = required && eleccion_union.required("fechaanterior");
        required = required && eleccion_union.required("feligresiaanterior");
        required = required && eleccion_union.required("fecha");
        required = required && eleccion_union.required("supervisor");
        required = required && eleccion_union.required("delegados");
        required = required && eleccion_union.required("feligresiaactual");
        required = required && eleccion_union.required("tiporeunion");
        if(required) {
            var promise = eleccion_union.guardar();
            eleccion_union.CerrarModal();


            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }

                // if(response.posee_union == "N") {
                //     $(".union").hide();
                // } else {
                //     $(".union").show();
                // }

                // $("#iddivision").trigger("change", [response.iddivision, response.pais_id]);
                // $("#pais_id").trigger("change", [response.pais_id, response.idunion, response.iddepartamento]);
                // $("#idunion").trigger("change", [response.idunion, response.idmision]);
                // $("#idmision").trigger("change", [response.idmision, response.iddistritomisionero]);
                // $("#iddistritomisionero").trigger("change", [response.iddistritomisionero, response.idiglesia]);

            })

        }
    }

    function eliminar_eleccion_union() {
        var datos = eleccion_union.datatable.row('.selected').data();
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
                eleccion_union.Operacion(datos.ideleccion, "E");

            }
        });
    }



    document.addEventListener("keydown", function(event) {
            // alert(modulo_controlador);
        if(modulo_controlador == "eleccion_union/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-eleccion_union').is(':visible')) {

                switch (event.code) {
                    case 'F1':
                        eleccion_union.abrirModal();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    case 'F2':
                        modificar_eleccion_union();
                        event.preventDefault();
                        event.stopPropagation();
                        break;

                    case 'F7':
                        eliminar_eleccion_union();
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

                if($('#modal-eleccion_union').is(':visible')) {
                    guardar_eleccion_union();
                }
                event.preventDefault();
                event.stopPropagation();
            }




        }
        // alert("ola");

    })

    document.getElementById("cancelar-eleccion_union").addEventListener("click", function(event) {
        event.preventDefault();
        eleccion_union.CerrarModal();
    })

    document.getElementById("calendar-fecha").addEventListener("click", function(e) {
        e.preventDefault();
        $("input[name=fecha]").focus();
    });

    document.getElementById("calendar-fechaanterior").addEventListener("click", function(e) {
        e.preventDefault();
        $("input[name=fechaanterior]").focus();
    });

    /*************
     * ASOCIADOS *
     *************/
    asociados.TablaListado({
        tablaID: '#tabla-asociados',
        url: "/buscar_datos",
    });

    document.getElementById("buscar_asociado").addEventListener("click", function(event) {
        event.preventDefault();
        $("#modal-lista-asociados").modal("show");
    })

    function cargar_datos_asociado(datos) {
        eleccion_union.limpiarDatos("datos-asociado");
        //console.log(datos);
        eleccion_union.asignarDatos({
            idmiembro: datos.idmiembro,
            asociado: datos.nombres,
            fechanacimiento: datos.fechanacimiento,
            direccion: datos.direccion,
            telefono: datos.telefono,
            fax: datos.fax,
            email: datos.email,

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
        // console.log(datos);
        cargar_datos_asociado(datos);
    });

    document.getElementById("agregar-oficial").addEventListener("click", function(e) {
        e.preventDefault();
        required = true;
        required = required && eleccion_union.required("asociado");
        required = required && eleccion_union.required("idcargo_union");

        if(required) {
            var asociado = document.getElementsByName("asociado")[0];
            var idcargo = document.getElementsByName("idcargo_union")[0];
            var idmiembro = document.getElementsByName("idmiembro")[0];
            var fechanacimiento = document.getElementsByName("fechanacimiento")[0];
            var direccion = document.getElementsByName("direccion")[0];
            var telefono = document.getElementsByName("telefono")[0];
            var fax = document.getElementsByName("fax")[0];
            var email = document.getElementsByName("email")[0];

            var objeto = {
                asociado: asociado.value,
                idcargo: idcargo.value,
                cargo: idcargo.options[idcargo.selectedIndex].text,
                idmiembro: idmiembro.value,
                fechanacimiento: fechanacimiento.value,
                direccion: direccion.value,
                telefono: telefono.value,
                fax: fax.value,
                email: email.value,
            }

            var miembros = document.getElementsByName("idmiembro[]");

            for (let m = 0; m < miembros.length; m++) {
                if(idmiembro.value == miembros[m].value) {
                    BASE_JS.sweet({
                        text: miembro_agregado
                    });
                    return false;
                }


            }
            // var cargos = document.getElementsByName("idcargo[]");
            // for (let c = 0; c < cargos.length; c++) {
            //     if(idcargo.value == cargos[c].value) {
            //         BASE_JS.sweet({
            //             text: cargo_agregado
            //         });

            //         return false;
            //     }


            // }


            // console.log(miembros);
            // console.log(cargos);


            document.getElementById("detalle-oficiales").getElementsByTagName("tbody")[0].appendChild(html_detalle_oficiales(objeto));
            eleccion_union.limpiarDatos("limpiar-oficiales");

        }



    })

    function html_detalle_oficiales(objeto, disabled) {
        // alert(disabled)
        var attr = '';
        var html = '';
        if(document.getElementsByName("idcargo_union")[0].disabled) {
            attr = 'disabled="disabled"';
        }
        var tr = document.createElement("tr");




        html = '  <input type="hidden" name="idtipocargo[]" value="2" >';
        html += '  <input type="hidden" name="idnivel[]" value="4" >';
        html += '  <input type="hidden" name="idcargo[]" value="'+objeto.idcargo+'" >';
        html += '  <input type="hidden" name="idmiembro[]" value="'+objeto.idmiembro+'" >';

        html += '  <td>'+objeto.asociado+'</td>';
        html += '  <td>'+objeto.fechanacimiento+'</td>';
        html += '  <td>'+objeto.direccion+'</td>';
        html += '  <td>'+objeto.telefono+'</td>';
        html += '  <td>'+objeto.fax+'</td>';
        html += '  <td>'+objeto.email+'</td>';
        html += '  <td>'+objeto.cargo+'</td>';

        html += '  <td><center><button '+attr+' type="button" class="btn btn-danger btn-xs eliminar-oficial"><i class="fa fa-trash-o" aria-hidden="true"></i></button></center></td>';

        tr.innerHTML = html;
        return tr;
    }

    document.addEventListener("click", function(event) {

        // console.log(event.target.classList);
        // console.log(event.srcElement.parentNode.parentNode.parentNode.parentNode);
        if(event.target.classList.value.indexOf("eliminar-oficial") != -1) {
            event.preventDefault();
            event.srcElement.parentNode.parentNode.parentNode.remove();

        }

        if(event.srcElement.parentNode.classList.value.indexOf("eliminar-oficial") != -1 && !event.srcElement.parentNode.disabled) {
            event.preventDefault();
            ///console.log(event.srcElement.parentNode);
            event.srcElement.parentNode.parentNode.parentNode.parentNode.remove();
        }
    })
})
