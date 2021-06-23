
var iglesias = new BASE_JS('iglesias', 'iglesias');

iglesias.TablaListado({
    tablaID: '#tabla-iglesias',
    url: "/buscar_datos",
});



iglesias.select({
    name: 'idiglesia',
    url: '/obtener_iglesias',
    placeholder: 'Seleccione Iglesia',
   
})

document.addEventListener("click", function(event) {
    var id = event.srcElement.id;
    if(id == "" && !event.srcElement.parentNode.disabled) {
        id = event.srcElement.parentNode.id;
    }
    //console.log(event.srcElement);
    switch (id) {
        case 'nueva-iglesia':
            event.preventDefault();
          
            iglesias.abrirModal();
        break;

        case 'modificar-iglesia':
            event.preventDefault();
          
            modificar_iglesia();
        break;

        case 'eliminar-iglesia':
            event.preventDefault();
            eliminar_iglesia();
        break;

        case 'guardar-iglesia':
            event.preventDefault();
            guardar_iglesia();
        break;

    }

})


function modificar_iglesia() {
    var datos = iglesias.datatable.row('.selected').data();
    if(typeof datos == "undefined") {
        BASE_JS.sweet({
            text: "DEBE SELECCIONAR UN REGISTRO!"
        });
        
        return false;
    } 

    iglesias.get(datos.idiglesia);
}

function guardar_iglesia() {
    var required = true;
    required = required && iglesias.required("descripcion");
    if(required) {
        var promise = iglesias.guardar();
        iglesias.CerrarModal();
        iglesias.datatable.destroy();
        iglesias.TablaListado({
            tablaID: '#tabla-iglesias',
            url: "/buscar_datos",
        });

        promise.then(function(response) {
			if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
				return false;
			}
            // $("select[name=idiglesia]").chosen("destroy");
            iglesias.select({
                name: 'idiglesia',
                url: '/obtener_iglesias',
                placeholder: 'Seleccione Iglesia',
                selected: response.id
            })
        })

    }
}

function eliminar_iglesia() {
    var datos = iglesias.datatable.row('.selected').data();
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
            iglesias.Operacion(datos.idiglesia, "E");
            iglesias.datatable.destroy();
            iglesias.TablaListado({
                tablaID: '#tabla-iglesias',
                url: "/buscar_datos",
            });
        }
    });
}



document.addEventListener("keydown", function(event) {
        // alert(modulo_controlador);
    if(modulo_controlador == "iglesias/index") {
        //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
        if(!$('#modal-iglesias').is(':visible')) {
           
            switch (event.code) {
                case 'F1':
					iglesias.abrirModal();
					event.preventDefault();
					event.stopPropagation();
                    break;
                case 'F2':
					modificar_iglesia();
					event.preventDefault();
					event.stopPropagation();
                    break;
                // case 'F4':
				// 	VerPrecio();
				// 	event.preventDefault();
				// 	event.stopPropagation();
				
                //     break;
				case 'F7':
					eliminar_iglesia();
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
            
            if($('#modal-iglesias').is(':visible')) {
                guardar_iglesia();
			}
			event.preventDefault();
			event.stopPropagation();
        }
        
    
    
      
    }
	// alert("ola");
	
})

document.getElementById("cancelar-iglesia").addEventListener("click", function(event) {
	event.preventDefault();
	iglesias.CerrarModal();
})
