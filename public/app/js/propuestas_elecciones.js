var propuestas_elecciones = new BASE_JS('propuestas_elecciones', 'propuestas');



document.addEventListener("DOMContentLoaded", function() {
  

   
    var eventClick = new Event('click');

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
    
        var objeto = {
            dp_descripcion: propuesta.value,
           
        }


        document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(objeto));
    
        propuestas_elecciones.limpiarDatos("limpiar");
    });

    function html_detalle_propuesta(objeto, disabled) {
        var attr = '';
        var html = '';
        if(typeof disabled != "undefined") {
            attr = 'disabled="disabled"';
        }
        var tr = document.createElement("tr");

        html = '  <input type="hidden" name="dp_descripcion[]" value="'+objeto.dp_descripcion+'" >';

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






    document.getElementById("nueva-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
      
        propuestas_elecciones.abrirModal();

        
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


        var promise = propuestas_elecciones.get(datos.pe_id);

        promise.then(function(response) {
            
            document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].innerHTML = "";
            propuestas_elecciones.ajax({
                url: '/obtener_detalle_propuesta',
                datos: { pe_id: response.pe_id, _token: _token }
            }).then(function(response) {
                if(response.length > 0) {
                    for(let i = 0; i < response.length; i++){
                        document.getElementById("detalle-propuesta").getElementsByTagName("tbody")[0].appendChild(html_detalle_propuesta(response[i]));
                    }
                }
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




    document.getElementById("guardar-propuesta-eleccion").addEventListener("click", function(event) {
        event.preventDefault();
 

        var required = true;

        required = required && propuestas_elecciones.required("pe_descripcion");
        required = required && propuestas_elecciones.required("pe_idioma");
     
        required = required && propuestas_elecciones.required("estado");
       
       

   
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


    

    
    

})

