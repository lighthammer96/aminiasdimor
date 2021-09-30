
var delegados = new BASE_JS('delegados', 'asociados');


document.addEventListener("DOMContentLoaded", function() {
    $(function() {
        $('input[type="radio"], input[type="checkbox"]').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass   : 'iradio_minimal-blue'
        })
    })

    $('input[name=hora_arribo]').inputmask("hh:mm", {
        placeholder: "HH:MM", 
        insertMode: false, 
        showMaskOnHover: false,
        hourFormat: 12
      }
   );

    var format = "";
    if(idioma_codigo == "es") {
        format = "dd/mm/yyyy";
       
        $("input[name=fecha_pasaje], input[name=fecha_vencimiento_pasaporte], input[name=fecha_termina_seguro], input[name=fecha_inicia_seguro], input[name=fecha_vencimiento_visa]").attr("data-inputmask", "'alias': '"+format+"'");
    } else {
        format = "yyyy-mm-dd";
   
        $("input[name=fecha_pasaje], input[name=fecha_vencimiento_pasaporte], input[name=fecha_termina_seguro], input[name=fecha_inicia_seguro], input[name=fecha_vencimiento_visa]").attr("data-inputmask", "'alias': '"+format+"'");
        
    }

    $("input[name=fecha_pasaje], input[name=fecha_termina_seguro], input[name=fecha_inicia_seguro], input[name=fecha_vencimiento_pasaporte], input[name=fecha_vencimiento_visa]").inputmask();

 
    jQuery( "input[name=fecha_pasaje], input[name=fecha_termina_seguro], input[name=fecha_inicia_seguro], input[name=fecha_vencimiento_pasaporte], input[name=fecha_vencimiento_visa]" ).datepicker({
        format: format,
        language: "es",
        todayHighlight: true,
        todayBtn: "linked",
        autoclose: true,
        // endDate: "now()",

    });

    delegados.TablaListado({
        tablaID: '#tabla-asociados',
        url: "/buscar_datos",
        delegados: 1

    });

    document.getElementById("ingresar-datos").addEventListener("click", function(event) {
        event.preventDefault();

        var datos = delegados.datatable.row('.selected').data();
        if(typeof datos == "undefined") {
            BASE_JS.sweet({
                text: seleccionar_registro
            });
            return false;
        } 


        var promise = delegados.get(datos.idmiembro);

        promise.then(function(response) {
            
            
            
        })
        

    })


    document.getElementById("guardar-delegados").addEventListener("click", function(event) {
        event.preventDefault();

        var required = true;
        // required = required && delegados.required("perfil_descripcion");

        
        if(required) {
            var promise = delegados.guardar();
            delegados.CerrarModal();
            // delegados.datatable.destroy();
            // delegados.TablaListado({
            //     tablaID: '#tabla-delegados',
            //     url: "/buscar_datos",
            // });

            promise.then(function(response) {
               
            })

        }
        

    })


    document.getElementById("cancelar-delegados").addEventListener("click", function(event) {
        event.preventDefault();
        delegados.CerrarModal();
    })

   

    
    document.getElementById("calendar-fecha_pasaje").addEventListener("click", function(e) {
        e.preventDefault();

  
        if($("input[name=fecha_pasaje]").hasClass("focus-datepicker")) {
   
            $("input[name=fecha_pasaje]").blur();
            $("input[name=fecha_pasaje]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=fecha_pasaje]").focus();
            $("input[name=fecha_pasaje]").addClass("focus-datepicker");
        }
       
    });

    document.getElementById("calendar-fecha_inicia_seguro").addEventListener("click", function(e) {
        e.preventDefault();

  
        if($("input[name=fecha_inicia_seguro]").hasClass("focus-datepicker")) {
   
            $("input[name=fecha_inicia_seguro]").blur();
            $("input[name=fecha_inicia_seguro]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=fecha_inicia_seguro]").focus();
            $("input[name=fecha_inicia_seguro]").addClass("focus-datepicker");
        }
       
    });

    document.getElementById("calendar-fecha_termina_seguro").addEventListener("click", function(e) {
        e.preventDefault();

  
        if($("input[name=fecha_termina_seguro]").hasClass("focus-datepicker")) {
   
            $("input[name=fecha_termina_seguro]").blur();
            $("input[name=fecha_termina_seguro]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=fecha_termina_seguro]").focus();
            $("input[name=fecha_termina_seguro]").addClass("focus-datepicker");
        }
       
    });


    document.getElementById("calendar-fecha_vencimiento_visa").addEventListener("click", function(e) {
        e.preventDefault();

  
        if($("input[name=fecha_vencimiento_visa]").hasClass("focus-datepicker")) {
   
            $("input[name=fecha_vencimiento_visa]").blur();
            $("input[name=fecha_vencimiento_visa]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=fecha_vencimiento_visa]").focus();
            $("input[name=fecha_vencimiento_visa]").addClass("focus-datepicker");
        }
       
    });


    document.getElementById("calendar-fecha_vencimiento_pasaporte").addEventListener("click", function(e) {
        e.preventDefault();

  
        if($("input[name=fecha_vencimiento_pasaporte]").hasClass("focus-datepicker")) {
   
            $("input[name=fecha_vencimiento_pasaporte]").blur();
            $("input[name=fecha_vencimiento_pasaporte]").removeClass("focus-datepicker");
        } else {
            
            $("input[name=fecha_vencimiento_pasaporte]").focus();
            $("input[name=fecha_vencimiento_pasaporte]").addClass("focus-datepicker");
        }
       
    });


    document.getElementById("time-hora_arribo").addEventListener("click", function(e) {
        e.preventDefault();
        
        if($("input[name=hora_arribo]").hasClass("focus-time")) {
   
            $("input[name=hora_arribo]").blur();
            $("input[name=hora_arribo]").removeClass("focus-time");
        } else {
            
            $("input[name=hora_arribo]").focus();
            $("input[name=hora_arribo]").addClass("focus-time");
        }
       
    }); 

})