
var divisiones = new BASE_JS('divisiones', 'divisiones');

divisiones.TablaListado({
    tablaID: '#tabla-divisiones',
    url: "/buscar_datos",
});



divisiones.select({
    name: 'iddivision',
    url: '/obtener_divisiones',
    placeholder: 'Seleccione División',
   
})

document.addEventListener("click", function(event) {
    var id = event.srcElement.id;
    if(id == "" && !event.srcElement.parentNode.disabled) {
        id = event.srcElement.parentNode.id;
    }
    //console.log(event.srcElement);
    switch (id) {
        case 'nueva-division':
            event.preventDefault();
          
            divisiones.abrirModal();
        break;

        case 'modificar-division':
            event.preventDefault();
          
            modificar_division();
        break;

        case 'eliminar-division':
            event.preventDefault();
            eliminar_division();
        break;

        case 'guardar-division':
            event.preventDefault();
            guardar_division();
        break;

    }

})


function modificar_division() {
    var datos = divisiones.datatable.row('.selected').data();
    if(typeof datos == "undefined") {
        BASE_JS.sweet({
            text: "DEBE SELECCIONAR UN REGISTRO!"
        });
        
        return false;
    } 

    divisiones.get(datos.iddivision);
}

function guardar_division() {
    var required = true;
    required = required && divisiones.required("descripcion");
    if(required) {
        var promise = divisiones.guardar();
        divisiones.CerrarModal();
        divisiones.datatable.destroy();
        divisiones.TablaListado({
            tablaID: '#tabla-divisiones',
            url: "/buscar_datos",
        });

        promise.then(function(response) {
			if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
				return false;
			}
            // $("select[name=iddivision]").chosen("destroy");
            divisiones.select({
                name: 'iddivision',
                url: '/obtener_divisiones',
                placeholder: 'Seleccione División',
                selected: response.id
            })
        })

    }
}

function eliminar_division() {
    var datos = divisiones.datatable.row('.selected').data();
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
            divisiones.Operacion(datos.iddivision, "E");
            divisiones.datatable.destroy();
            divisiones.TablaListado({
                tablaID: '#tabla-divisiones',
                url: "/buscar_datos",
            });
        }
    });
}



document.addEventListener("keydown", function(event) {
        // alert(modulo_controlador);
    if(modulo_controlador == "divisiones/index") {
        //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
        if(!$('#modal-divisiones').is(':visible')) {
           
            switch (event.code) {
                case 'F1':
					divisiones.abrirModal();
					event.preventDefault();
					event.stopPropagation();
                    break;
                case 'F2':
					modificar_division();
					event.preventDefault();
					event.stopPropagation();
                    break;
                // case 'F4':
				// 	VerPrecio();
				// 	event.preventDefault();
				// 	event.stopPropagation();
				
                //     break;
				case 'F7':
					eliminar_division();
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
            
            if($('#modal-divisiones').is(':visible')) {
                guardar_division();
			}
			event.preventDefault();
			event.stopPropagation();
        }
        
    
    
      
    }
	// alert("ola");
	
})

document.getElementById("cancelar-division").addEventListener("click", function(event) {
	event.preventDefault();
	divisiones.CerrarModal();
})
