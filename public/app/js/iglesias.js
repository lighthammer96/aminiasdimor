
var iglesias = new BASE_JS('iglesias', 'iglesias');
var principal = new BASE_JS('principal', 'principal');
var divisiones = new BASE_JS('divisiones', 'divisiones');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var distritos_misioneros = new BASE_JS('distritos_misioneros', 'distritos_misioneros');

iglesias.TablaListado({
    tablaID: '#tabla-iglesias',
    url: "/buscar_datos",
});


principal.select({
    name: 'idcategoriaiglesia',
    url: '/obtener_categorias_iglesia',
    placeholder: 'Seleccione ...',
   
})

principal.select({
    name: 'idtipoconstruccion',
    url: '/obtener_tipos_construccion',
    placeholder: 'Seleccione ...',
   
})


principal.select({
    name: 'idtipodocumentacion',
    url: '/obtener_tipos_documentacion',
    placeholder: 'Seleccione ...',
   
})

principal.select({
    name: 'idtipoinmueble',
    url: '/obtener_tipos_inmueble',
    placeholder: 'Seleccione ...',
   
})


principal.select({
    name: 'idcondicioninmueble',
    url: '/obtener_condicion_inmueble',
    placeholder: 'Seleccione ...',
   
})

iglesias.select({
    name: 'idiglesia',
    url: '/obtener_iglesias',
    placeholder: 'Seleccione ...',
   
})



principal.select({
    name: 'iddepartamento',
    url: '/obtener_departamentos',
    placeholder: 'Seleccione ...'
}).then(function() {
    
    $("#iddepartamento").trigger("change", ["", "", ""]);
    $("#idprovincia").trigger("change", ["", "", ""]);
}) 



$(document).on('change', '#iddepartamento', function(event, iddepartamento, idprovincia) {

    var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
    d_id = (typeof iddepartamento != "undefined" && iddepartamento != null) ? iddepartamento : d_id;
    var selected = (typeof idprovincia != "undefined")  ? idprovincia : "";
   
    principal.select({
        name: 'idprovincia',
        url: '/obtener_provincias',
        placeholder: 'Seleccione ...',
        selected: selected,
        datos: { iddepartamento: d_id }
    }).then(function() {
       
        var condicion = typeof iddepartamento == "undefined";
        condicion = condicion && typeof idprovincia == "undefined";
       
        if(condicion) {
            var required = true;
            required = required && iglesias.required("iddepartamento");
            if(required) {
                $("#idprovincia")[0].selectize.focus();
            }
        } 
       
       
        
    })

});


$(document).on('change', '#idprovincia', function(event, idprovincia, iddistrito) {

    var p_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
    p_id = (typeof idprovincia != "undefined") ? idprovincia : p_id;
    var selected = (typeof iddistrito != "undefined")  ? iddistrito : "";

    
    principal.select({
        name: 'iddistrito',
        url: '/obtener_distritos',
        placeholder: 'Seleccione ...',
        selected: selected,
        datos: { idprovincia:  p_id }
    }).then(function() {
        iglesias.enter("iddistrito","iddistritomisionero");
        
        var condicion = typeof idprovincia == "undefined";
        condicion = condicion && typeof iddistrito == "undefined";

        if(condicion) {
            var required = true;
            required = required && iglesias.required("idprovincia");
            if(required) {
                $("#iddistrito")[0].selectize.focus();
            }
           
        } 
    })


});



divisiones.select({
    name: 'iddivision',
    url: '/obtener_divisiones',
    placeholder: 'Seleccione ...'
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
        placeholder: 'Seleccione ...',
        selected: selected,
        datos: { iddivision: d_id }
    }).then(function(response) {
        
        var condicion = typeof iddivision == "undefined";
        condicion = condicion && typeof pais_id == "undefined";
       
        if(condicion) {
            var required = true;
            required = required && iglesias.required("iddivision");
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
        placeholder: 'Seleccione ...',
        selected: selected,
        datos: { pais_id: d_id }
    }).then(function() {
      
        var condicion = typeof pais_id == "undefined";
        condicion = condicion && typeof idunion == "undefined";
       
        if(condicion) {
            var required = true;
            required = required && iglesias.required("pais_id");
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
            placeholder: 'Seleccione ...',
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
        placeholder: 'Seleccione ...',
        selected: selected,
        datos: { idunion: d_id }
    }).then(function() {
      
        var condicion = typeof idunion == "undefined";
        condicion = condicion && typeof idmision == "undefined";
       
        if(condicion) {
            var required = true;
            required = required && iglesias.required("idunion");
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
        placeholder: 'Seleccione ...',
        selected: selected,
        datos: { idmision: d_id }
    }).then(function() {
      
        var condicion = typeof idmision == "undefined";
        condicion = condicion && typeof iddistritomisionero == "undefined";
       
        if(condicion) {
            var required = true;
            required = required && iglesias.required("idmision");
            if(required) {
                $("#iddistritomisionero")[0].selectize.focus();
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
                placeholder: 'Seleccione ...',
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
