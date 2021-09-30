var asignacion_delegados = new BASE_JS('asignacion_delegados', 'asociados');
var niveles = new BASE_JS('niveles', 'niveles');
var cargos = new BASE_JS('cargos', 'cargos');
var tipos_cargo = new BASE_JS('tipos_cargo', 'tipos_cargo');
var asambleas = new BASE_JS('asambleas', 'asambleas');


document.addEventListener("DOMContentLoaded", function() {

    
    asignacion_delegados.select({
        name: 'idgradoinstruccion',
        url: '/obtener_nivel_educativo',
        placeholder: seleccione
    }).then(function() {
        // asignacion_delegados.enter("idgradoinstruccion","idocupacion");
        
    }) 

    
    asambleas.select({
        name: 'asamblea_id',
        url: '/obtener_asambleas',
        placeholder: seleccione
    }).then(function() {
        // asignacion_delegados.enter("idocupacion","observaciones");   
        
    }) 

    asignacion_delegados.select({
        name: 'idocupacion',
        url: '/obtener_profesiones',
        placeholder: seleccione
    }).then(function() {
        // asignacion_delegados.enter("idocupacion","observaciones");   
        
    }) 


    tipos_cargo.select({
        name: 'idtipocargo',
        url: '/obtener_tipos_cargo',
        placeholder: seleccione
    }).then(function() {
        $("#idtipocargo").trigger("change", ["", ""]);
        $("#idnivel").trigger("change", ["", ""]);
        //$("#idcargo").trigger("change", ["", ""]);
    
    }) 



    $(document).on('change', '#idtipocargo', function(event, idtipocargo, idcargo) {
        //var valor = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : "1"; 
        // var array = valor.toString().split("|");

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idtipocargo != "undefined" && idtipocargo != null) ? idtipocargo : d_id;

        // var d_id = array[0];
        // var posee_nivel = array[1];
        var selected = (typeof idcargo != "undefined")  ? idcargo : "";
        


        niveles.select({
            name: 'idnivel',
            url: '/obtener_niveles',
            placeholder: seleccione,
            selected: selected,
            datos: { idtipocargo: d_id }
        }).then(function() {
        
            var condicion = typeof idtipocargo == "undefined" && idtipocargo != "";
            condicion = condicion && typeof idcargo == "undefined" && idcargo != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idtipocargo");
                // if(required) {
                    // if(posee_nivel == "N") {
                    //     //$("#idcargo")[0].selectize.focus();
                    // } else {
                    //     $("#idnivel")[0].selectize.focus();
                    // }
                    $("#idnivel")[0].selectize.focus();
                    // $("#idnivel").focus();
                    
                // }
            } 
        
        
            
        })



    });


    $(document).on('change', '#idnivel', function(event, idnivel, idcargo) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;     
        d_id = (typeof idnivel != "undefined" && idnivel != null) ? idnivel : d_id;
        var selected = (typeof idcargo != "undefined")  ? idcargo : "";
       

        cargos.select({
            name: 'idcargo',
            url: '/obtener_cargos',
            placeholder: seleccione,
            selected: selected,
            datos: { idnivel: d_id }
        }).then(function() {
        
            var condicion = typeof idnivel == "undefined" && idnivel != "";
            condicion = condicion && typeof idcargo == "undefined" && idcargo != "";
        
            if(condicion) {
                // var required = true;
                // required = required && asociados.required("idtipocargo");
                // if(required) {
                    $("#idcargo")[0].selectize.focus();
                    // $("#idcargo").focus();
                // }
            } 
        })

 

    });


    document.getElementById("filtrar").addEventListener("click", function(e) {
        e.preventDefault();
        // alert("hola");
        var nombres = document.getElementsByName("nombres")[0].value;
        var idgradoinstruccion = document.getElementsByName("idgradoinstruccion")[0].value;
        var idocupacion = document.getElementsByName("idocupacion")[0].value;
        var idcargo = document.getElementsByName("idcargo")[0].value;
        var idnivel = document.getElementsByName("idnivel")[0].value;
        var idtipocargo = document.getElementsByName("idtipocargo")[0].value;
        var promise = asignacion_delegados.ajax({
            url: '/filtrar_asociados',
            datos: { nombres: nombres, idgradoinstruccion: idgradoinstruccion, idocupacion: idocupacion, idcargo: idcargo, idnivel: idnivel, idtipocargo: idtipocargo, _token: _token }
        }).then(function(response) {
            // console.log(response);

            if(response.length > 0) {
                var html = '';
                for (let index = 0; index < response.length; index++) {
                    html += '<tr>';
                    html += '   <td>'+response[index].nombres+'</td>';
                    html += '   <td>'+response[index].documento+'</td>';
                    html += '   <td>'+response[index].cargo+'</td>';
                    html += '   <td>'+response[index].delegado+'</td>';
                    html += '   <td>'+response[index].pais+'</td>';
                    html += '   <td>'+response[index].jerarquia+'</td>';
                    html += '   <td>'+response[index].correo+'</td>';
                    html += '   <td>'+response[index].telefono+'</td>';
                    html += '   <td>'+response[index].convocatoria+'</td>';
                    html += '   <td><center><input checked="checked" class="minimal entrada" type="checkbox" name="idmiembro[]" value="'+response[index].idmiembro+'" ></center></td>';

                    html += '</tr>';
                    
                }

                document.getElementById("asociados").getElementsByTagName("tbody")[0].innerHTML = html; 
                $("#asociados").show();
                $("#boton-asignar").show();
            } else {
                BASE_JS.sweet({
                    text: no_hay_datos
                })
            }
        })
    })

    document.getElementById("todos").addEventListener("click", function(e) {
        e.preventDefault();
        // var checkboxs = $("input[name='idmiembro[]'");

        // for (let index = 0; index < checkboxs.length; index++) {
            if($("#todos").hasClass("todos")) {
                $("input[name='idmiembro[]'").prop("checked", true);
                $("#todos").removeClass("todos");
                $("#todos").addClass("ninguno");
            } else {
                $("input[name='idmiembro[]'").prop("checked", false);
                $("#todos").removeClass("ninguno");
                $("#todos").addClass("todos");
            }
            
        // }
       
    })


    document.getElementById("asignar").addEventListener("click", function(e) {
        e.preventDefault();
       
        // console.log($("input[name='idmiembro[]'").val());

        var checkboxs = $("input[name='idmiembro[]'");
        var array = [];
        for (let index = 0; index < checkboxs.length; index++) {
            if($(checkboxs[index]).is(":checked")) {

                array.push($(checkboxs[index]).val());
            }
            
        }
        

        if(array.length == 0) {
            BASE_JS.sweet({
                text: seleccionar_menos_asociado
            });
            return false;
        }

        asignacion_delegados.abrirModal();
        $("#miembros").val(array.join("|"));
        // console.log(array.join("|"));
    })

    document.getElementById("cancelar-asignacion_delegados").addEventListener("click", function(event) {
        event.preventDefault();
        asignacion_delegados.CerrarModal();
    })


    document.getElementById("guardar-asignacion_delegados").addEventListener("click", function(e) {
        e.preventDefault();

       
        var required = true;

        required = required &&  asignacion_delegados.required("asamblea_id");
        required = required &&  asignacion_delegados.required("delegado_tipo");

        if(required) {
            var promise = asignacion_delegados.guardar();
            asignacion_delegados.CerrarModal();
            promise.then(function(response) {
                if(response.status == "i") {
                    BASE_JS.sweet({
                        confirm: true,
                        text: imprimir_listado_delegados,
                        callbackConfirm: function() {
                            
                        }
                    });
                }  
            
            })

        }
       
    })

})