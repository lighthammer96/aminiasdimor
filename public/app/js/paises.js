
var paises = new BASE_JS('paises', 'paises');

paises.TablaListado({
    tablaID: '#tabla-paises',
    url: "/buscar_datos",
});





document.addEventListener("click", function(event) {
    var id = event.srcElement.id;
    if(id == "" && !event.srcElement.parentNode.disabled) {
        id = event.srcElement.parentNode.id;
    }
    //console.log(event.srcElement);
    switch (id) {
        case 'nuevo-pais':
            event.preventDefault();
          
            paises.abrirModal();
        break;

        case 'modificar-pais':
            event.preventDefault();
          
            modificar_pais();
        break;

        case 'eliminar-pais':
            event.preventDefault();
            eliminar_pais();
        break;

        case 'guardar-pais':
            event.preventDefault();
            guardar_pais();
        break;

    }

})


function modificar_pais() {
    var datos = paises.datatable.row('.selected').data();
    if(typeof datos == "undefined") {
        BASE_JS.sweet({
            text: "DEBE SELECCIONAR UN REGISTRO!"
        });
        
        return false;
    } 

    paises.get(datos.pais_id);
}

function guardar_pais() {
    var required = true;
    required = required && paises.required("pais_descripcion");
    if(required) {
        var promise = paises.guardar();
        paises.CerrarModal();
        paises.datatable.destroy();
        paises.TablaListado({
            tablaID: '#tabla-paises',
            url: "/buscar_datos",
        });

        promise.then(function(response) {
			if(typeof response.status == "undefined" || response.status.indexOf("e") != -1) {
				return false;
			}
            // $("select[name=pais_id]").chosen("destroy");
            paises.select({
                name: 'pais_id',
                url: '/obtener_paises',
                placeholder: 'Seleccione Pais',
                selected: response.id
            })
        })

    }
}

function eliminar_pais() {
    var datos = paises.datatable.row('.selected').data();
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
            paises.Operacion(datos.pais_id, "E");
            paises.datatable.destroy();
            paises.TablaListado({
                tablaID: '#tabla-paises',
                url: "/buscar_datos",
            });
        }
    });
}



document.addEventListener("keydown", function(event) {
        // alert(modulo_controlador);
    if(modulo_controlador == "paises/index") {
        //ESTOS EVENTOS SE ACTIVAN SUS TECLAS RAPIDAS CUANDO EL MODAL DEL FORMULARIO ESTE CERRADO
        if(!$('#modal-paises').is(':visible')) {
           
            switch (event.code) {
                case 'F1':
					paises.abrirModal();
					event.preventDefault();
					event.stopPropagation();
                    break;
                case 'F2':
					modificar_pais();
					event.preventDefault();
					event.stopPropagation();
                    break;
                // case 'F4':
				// 	VerPrecio();
				// 	event.preventDefault();
				// 	event.stopPropagation();
				
                //     break;
				case 'F7':
					eliminar_pais();
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
            
            if($('#modal-paises').is(':visible')) {
                guardar_pais();
			}
			event.preventDefault();
			event.stopPropagation();
        }
        
    
    
      
    }
	// alert("ola");
	
})

document.getElementById("cancelar-pais").addEventListener("click", function(event) {
	event.preventDefault();
	paises.CerrarModal();
})
