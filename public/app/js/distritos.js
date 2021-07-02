var distritos = new BASE_JS('distritos', 'distritos');

document.addEventListener("DOMContentLoaded", function() {
            
    
    distritos.TablaListado({
        tablaID: '#tabla-distritos',
        url: "/buscar_datos",
    });

    distritos.select({
        name: 'iddistrito',
        url: '/obtener_distritos',
        placeholder: seleccione
    }).then(function() {
        
        
    }) 




    document.addEventListener("click", function(event) {
        var id = event.srcElement.id;
        if(id == "" && !event.srcElement.parentNode.disabled) {
            id = event.srcElement.parentNode.id;
        }
        //console.log(event.srcElement);
        switch (id) {
            case 'nuevo-distrito':
                event.preventDefault();
            
                distritos.abrirModal();
            break;

            case 'modificar-distrito':
                event.preventDefault();
            
                modificar_distrito();
            break;

            case 'eliminar-distrito':
                event.preventDefault();
                eliminar_distrito();
            break;

            case 'guardar-distrito':
                event.preventDefault();
                guardar_distrito();
            break;

        }

    })


    function modificar_distrito() {
        var datos = distritos.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: "DEBE SELECCIONAR UN REGISTRO!"
            });
            
            return false;
        } 

        var promise = distritos.get(datos.iddistrito);

        promise.then(function(response) {
        
        })
    }

    function guardar_distrito() {
        var required = true;
        // required = required && distritos.required("perfil_descripcion");

        
        if(required) {
            var promise = distritos.guardar();
            distritos.CerrarModal();
            distritos.datatable.destroy();
            distritos.TablaListado({
                tablaID: '#tabla-distritos',
                url: "/buscar_datos",
            });

            promise.then(function(response) {
                if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
                    return false;
                }
                // $("select[name=iddistrito]").chosen("destroy");
                distritos.select({
                    name: 'iddistrito',
                    url: '/obtener_distritos',
                    placeholder: seleccione,
                    selected: response.id
                })
            })

        }
    }

    function eliminar_distrito() {
        var datos = distritos.datatable.row('.selected').data();
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
                distritos.Operacion(datos.iddistrito, "E");
                distritos.datatable.destroy();
                distritos.TablaListado({
                    tablaID: '#tabla-distritos',
                    url: "/buscar_datos",
                });
            }
        });
    }



    document.addEventListener("keydown", function(event) {
            // alert(modulo_controlador);
        if(modulo_controlador == "distritos/index") {
            //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
            if(!$('#modal-distritos').is(':visible')) {
            
                switch (event.code) {
                    case 'F1':
                        distritos.abrirModal();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    case 'F2':
                        modificar_distrito();
                        event.preventDefault();
                        event.stopPropagation();
                        break;
                    // case 'F4':
                    // 	VerPrecio();
                    // 	event.preventDefault();
                    // 	event.stopPropagation();
                    
                    //     break;
                    case 'F7':
                        eliminar_distrito();
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
                
                if($('#modal-distritos').is(':visible')) {
                    guardar_distrito();
                }
                event.preventDefault();
                event.stopPropagation();
            }
            
        
        
        
        }
        // alert("ola");
        
    })

    document.getElementById("cancelar-distrito").addEventListener("click", function(event) {
        event.preventDefault();
        distritos.CerrarModal();
    })

})