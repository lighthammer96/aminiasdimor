//var tabID = sessionStorage.tabID ? sessionStorage.tabID : sessionStorage.tabID = Math.random();

var url = this.window.location.pathname;
var partesUrl = url.split("/");
// var route = partesUrl[partesUrl.length-1];
var ruta = partesUrl[partesUrl.length-2] + "/" + partesUrl[partesUrl.length-1];
var elementos = document.getElementsByClassName("modulosUrl");
for(let i = 0; i < elementos.length; i++) {
	if(typeof elementos[i].getAttribute("modulo_controlador") != "undefined" && elementos[i].getAttribute("modulo_controlador") == ruta) {
		
		// var tipodoc_id = elementos[i].getAttribute("tipodoc_id");
		
		var modulo_id = elementos[i].getAttribute("modulo_id");
		var modulo_controlador = elementos[i].getAttribute("modulo_controlador");
		elementos[i].parentNode.classList.add("active");
		elementos[i].parentNode.parentNode.parentNode.classList.add("active");
		
		
	}

}

var modulos_pantalla_completa = ["DocumentosController"];

document.addEventListener("DOMContentLoaded", function() {

	// $("input[name=fecha_proceso]").inputmask();
	//alert(session.fecha_proceso);
	// document.getElementsByName("fecha_proceso")[0].value = (typeof session.fecha_proceso == "undefined") ?BASE_JS.ObtenerFechaActual("user") : BASE_JS.FormatoFecha(session.fecha_proceso, "user");

	// jQuery("input[name=fecha_proceso]").datepicker({
	// 	format: "dd/mm/yyyy",
	// 	language: "es",
	// 	todayHighlight: true,
	// 	todayBtn: "linked",
	// 	autoclose: true,
	// 	endDate: "now()",

	// });
	var botones = document.getElementsByTagName("button");

	setTimeout(function() {
		for (let index = 0; index < botones.length; index++) {
			botones[index].disabled = false;

		}
	}, '1000');


	// $.post(BaseUrl + 'PrincipalController/validarInicioSistema', {}, function(data, textStatus, xhr) {
	//     if(data.response == "NO") {
	//         $("#modalConfig").modal("show");
	//     } else {
	//         $("#modalConfig").modal("hide");
	//     }
	// }, 'json');

	//PARA MINIMIZAR MENU LATERAL Y QUE LA TABLA GANE MAS ESPACIO
	// if(modulos_pantalla_completa.indexOf(modulo_controlador) != -1) {
	// 	var modulosUrl = document.getElementsByClassName("modulosUrl");
	// 	for (let index = 0; index < modulosUrl.length; index++) {
	// 		if(modulosUrl[index].getAttribute("modulo_controlador") == modulo_controlador) {
	// 			//alert("ola");
	// 			//modulosUrl[index].classList.remove("active");
	// 			modulosUrl[index].parentNode.parentNode.style = "";
	// 		}

	// 	}
	// 	document.getElementById("wrapper").classList.add("forced");
	// 	document.getElementById("wrapper").classList.add("enlarged");
	// } else {
	// 	document.getElementById("wrapper").classList.remove("forced");
	// 	document.getElementById("wrapper").classList.remove("enlarged");
	// }



});



// HTMLElement.prototype.prependHtml = function (element) {
//     const div = document.createElement('div');
//     div.innerHTML = element;
//     this.insertBefore(div, this.firstChild);
// };

// HTMLElement.prototype.appendHtml = function (element) {
//     const div = document.createElement('div');
//     div.innerHTML = element;
//     while (div.children.length > 0) {
//         this.appendChild(div.children[0]);
//     }
// };


$(document).on("click", "#idioma_sistema", function(e) {
	e.preventDefault();
	var array = this.value.toString().split("|");
	$.ajax({
		url: BaseUrl+'/principal/cambiar_idioma',
		type: 'POST',
		dataType: 'json',
		data: "idioma_id="+array[0]+"&idioma_codigo="+array[1]+"&_token="+_token
	}).done(function(json) {
		// console.log(json);
		if(json.response == 'ok') {
			// alert();
			window.location = BaseUrl+"/"+modulo_controlador;
		} else {
			
		}
	}).fail(function() {
		console.log("ERROR 1");
	}).always(function() {
		console.log("ERROR 2");
	});
})

