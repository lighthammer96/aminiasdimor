var instituciones = new BASE_JS('instituciones', 'instituciones');

document.addEventListener("DOMContentLoaded", function() {
        
   
    instituciones.TablaListado({
        tablaID: '#tabla-instituciones',
        url: "/buscar_datos",
    });


    // instituciones.enter("descripcion", "idioma", function() {
    //     var required = true;
    //     required = instituciones.required("idioma");

    //     if(!required) {
    //         return false;
    //     }

    //     var idioma_id = document.getElementsByName("idioma")[0];
    //     var descripcion = document.getElementsByName("descripcion")[0];
    //     // console.log(idioma_id.options[idioma_id.selectedIndex].text);
    //     // console.log(descripciom);
    //     var objeto = {
    //         idioma_id: idioma_id.value,
    //         idioma_descripcion: idioma_id.options[idioma_id.selectedIndex].text,
    //         descripcion: descripcion.value
    //     }


    //     document.getElementById("detalle-traducciones").getElementsByTagName("tbody")[0].appendChild(html_detalle_traducciones(objeto));
    
    //     instituciones.limpiarDatos("limpiar");
    // });


    // function html_detalle_traducciones(objeto, disabled) {
    //     var attr = '';
    //     var html = '';
    //     if(typeof disabled != "undefined") {
    //         attr = 'disabled="disabled"';
    //     }
    //     var tr = document.createElement("tr");

    //     html = '  <input type="hidden" name="idioma_id[]" value="'+objeto.idioma_id+'" >';
    //     html += '  <input type="hidden" name="pi_descripcion[]" value="'+objeto.descripcion+'" >';
    //     html += '  <td>'+objeto.idioma_descripcion+'</td>';
    //     html += '  <td>'+objeto.descripcion+'</td>';
    //     html += '  <td><center><button '+attr+' type="button" class="btn btn-danger btn-xs eliminar-traduccion"><i class="fa fa-trash-o" aria-hidden="true"></i></button></center></td>';

    //     tr.innerHTML = html;
    //     return tr;
    // }


    document.addEventListener("click", function(event) {
        var id = event.srcElement.id;
        if(id == "" && !event.srcElement.parentNode.disabled) {
            id = event.srcElement.parentNode.id;
        }
        //console.log(event.srcElement);
        switch (id) {
            case 'nuevo-institucion':
                event.preventDefault();
            
                instituciones.abrirModal();
            break;

            case 'modificar-institucion':
                event.preventDefault();
            
                modificar_institucion();
            break;

            case 'eliminar-institucion':
                event.preventDefault();
                eliminar_institucion();
            break;

            case 'guardar-institucion':
                event.preventDefault();
                guardar_institucion();
            break;

        }

    })


    function modificar_institucion() {
        var datos = instituciones.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            
            return false;
        } 

        var promise = instituciones.get(datos.idinstitucion);

        promise.then(function(response) {
            // instituciones.ajax({
            //     url: '/obtener_traducciones',
            //     datos: { idinstitucion: response.idinstitucion, _token: _token }
            // }).then(function(response) {
            //     if(response.length > 0) {
            //         for(let i = 0; i < response.length; i++){
            //             document.getElementById("detalle-traducciones").getElementsByTagName("tbody")[0].appendChild(html_detalle_traducciones(response[i]));
            //         }
            //     }
            //     //console.log(response);
            // })
        })
    }

    function guardar_institucion() {
        var required = true;
        // required = required && instituciones.required("perfil_descripcion");

        var detalle = document.getElementById("detalle-traducciones").getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    
        if(detalle.length <= 0) {
            BASE_JS.sweet({
                text: elemento_detalle
            });

            return false;
        }
        if(required) {
            var promise = instituciones.guardar();
            instituciones.CerrarModal();
            // instituciones.datatable.destroy();
            // instituciones.TablaListado({
            //     tablaID: '#tabla-instituciones',
            //     url: "/buscar_datos",
            // });

            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }
                // $("select[name=idinstitucion]").chosen("destroy");
                instituciones.select({
                    name: 'idinstitucion',
                    url: '/obtener_instituciones',
                    placeholder: seleccione,
                    selected: response.id
                })
            })

        }
    }

    function eliminar_institucion() {
        var datos = instituciones.datatable.row('.selected').data();
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
                instituciones.Operacion(datos.idinstitucion, "E");
                // instituciones.datatable.destroy();
                // instituciones.TablaListado({
                //     tablaID: '#tabla-instituciones',
                //     url: "/buscar_datos",
                // });
            }
        });
    }



    document.addEventListener("keydown", function(event) {
            // alert(modulo_controlador);
        if(modulo_controlador == "instituciones/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-instituciones').is(':visible')) {
            
                switch (event.code) {
                    case 'F1':
                        instituciones.abrirModal();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    case 'F2':
                        modificar_institucion();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    // case 'F4':
                    // 	VerPrecio();
                    // 	event.preventDefault();
                    // 	event.stopPropagation();
                    
                    //     break;
                    case 'F7':
                        eliminar_institucion();
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
                
                if($('#modal-instituciones').is(':visible')) {
                    guardar_institucion();
                }
                event.preventDefault();
                event.stopPropagation();
            }
            
        
        
        
        }
        // alert("ola");
        
    })

    document.getElementById("cancelar-institucion").addEventListener("click", function(event) {
        event.preventDefault();
        instituciones.CerrarModal();
    })


    document.addEventListener("click", function(event) {

        // console.log(event.target.classList);
        // console.log(event.srcElement.parentNode.parentNode.parentNode.parentNode);
        if(event.target.classList.value.indexOf("eliminar-traduccion") != -1) {
            event.preventDefault();
            event.srcElement.parentNode.parentNode.parentNode.remove();

        }

        if(event.srcElement.parentNode.classList.value.indexOf("eliminar-traduccion") != -1 && !event.srcElement.parentNode.disabled) {
            event.preventDefault();
            ///console.log(event.srcElement.parentNode);
            event.srcElement.parentNode.parentNode.parentNode.parentNode.remove();
        }

    })

})