var grafico_feligresia = new BASE_JS('grafico_feligresia', 'reportes');
var divisiones = new BASE_JS('divisiones', 'divisiones');
var paises = new BASE_JS('paises', 'paises');
var uniones = new BASE_JS('uniones', 'uniones');
var misiones = new BASE_JS('misiones', 'misiones');
var distritos_misioneros = new BASE_JS('distritos_misioneros', 'distritos_misioneros');
var iglesias = new BASE_JS('iglesias', 'iglesias');


document.addEventListener("DOMContentLoaded", function () {

    grafico_feligresia.select_init({
        placeholder: seleccione
    })

    $(document).on('change', '#iddivision_all', function (event, iddivision_all, pais_id_all) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : session["iddivision_all"];
        d_id = (typeof iddivision_all != "undefined" && iddivision_all != null) ? iddivision_all : d_id;
        var selected = (typeof pais_id_all != "undefined") ? pais_id_all : "";

        paises.select({
            name: 'pais_id_all',
            url: '/obtener_paises_asociados_all',
            placeholder: seleccione,
            selected: selected,
            datos: { iddivision: d_id }
        }).then(function (response) {

            var condicion = typeof iddivision_all == "undefined";
            condicion = condicion && typeof pais_id_all == "undefined";

            if (condicion) {
                var required = true;
                required = required && grafico_feligresia.required("iddivision_all");
                if (required) {
                    $("#pais_id_all")[0].selectize.focus();
                }
            }

        })
    });



    $(document).on('change', '#pais_id_all', function (event, pais_id_all, idunion_all) {
        var valor = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : session['pais_id_all'] + "|" + session['posee_union'];
        var array = valor.toString().split("|");
        //var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : 1;

        var d_id = array[0];
        var posee_union = array[1];

        var selected = (typeof idunion_all != "undefined") ? idunion_all : "";
        uniones.select({
            name: 'idunion_all',
            url: '/obtener_uniones_paises_all',
            placeholder: seleccione,
            selected: selected,
            datos: { pais_id: d_id }
        }).then(function () {

            var condicion = typeof pais_id_all == "undefined";
            condicion = condicion && typeof idunion_all == "undefined";

            if (condicion) {
                var required = true;
                required = required && grafico_feligresia.required("pais_id_all");
                if (required) {
                    $("#idunion_all")[0].selectize.focus();
                }
            }

        })
        if (posee_union == "N") {
            $(".union").hide();

            misiones.select({
                name: 'idmision_all',
                url: '/obtener_misiones_all',
                placeholder: seleccione,
                datos: { pais_id: d_id }
            })
        } else {
            $(".union").show();
        }

    });



    $(document).on('change', '#idunion_all', function (event, idunion_all, idmision_all) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : session["idunion_all"];
        d_id = (typeof idunion_all != "undefined" && idunion_all != null) ? idunion_all : d_id;
        var selected = (typeof idmision_all != "undefined") ? idmision_all : "";

        misiones.select({
            name: 'idmision_all',
            url: '/obtener_misiones_all',
            placeholder: seleccione,
            selected: selected,
            datos: { idunion: d_id }
        }).then(function () {

            var condicion = typeof idunion_all == "undefined";
            condicion = condicion && typeof idmision_all == "undefined";

            if (condicion) {
                var required = true;
                required = required && grafico_feligresia.required("idunion_all");
                if (required) {
                    $("#idmision_all")[0].selectize.focus();
                }
            }

        })
    });

    $(document).on('change', '#idmision_all', function (event, idmision_all, iddistritomisionero_all) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : session["idmision_all"];
        d_id = (typeof idmision_all != "undefined" && idmision_all != null) ? idmision_all : d_id;
        var selected = (typeof iddistritomisionero_all != "undefined") ? iddistritomisionero_all : "";

        distritos_misioneros.select({
            name: 'iddistritomisionero_all',
            url: '/obtener_distritos_misioneros_all',
            placeholder: seleccione,
            selected: selected,
            datos: { idmision: d_id }
        }).then(function () {

            var condicion = typeof idmision_all == "undefined";
            condicion = condicion && typeof iddistritomisionero_all == "undefined";

            if (condicion) {
                var required = true;
                required = required && grafico_feligresia.required("idmision_all");
                if (required) {
                    $("#iddistritomisionero_all")[0].selectize.focus();
                }
            }

        })
    });

    $(document).on('change', '#iddistritomisionero_all', function (event, iddistritomisionero_all, idiglesia_all) {

        var d_id = ($(this).val() != "" && $(this).val() != null) ? $(this).val() : session["iddistritomisionero_all"];
        d_id = (typeof iddistritomisionero_all != "undefined" && iddistritomisionero_all != null) ? iddistritomisionero_all : d_id;
        var selected = (typeof idiglesia_all != "undefined") ? idiglesia_all : "";

        iglesias.select({
            name: 'idiglesia_all',
            url: '/obtener_iglesias_all',
            placeholder: seleccione,
            selected: selected,
            datos: { iddistritomisionero: d_id }
        }).then(function () {

            var condicion = typeof iddistritomisionero_all == "undefined";
            condicion = condicion && typeof idiglesia_all == "undefined";

            if (condicion) {
                var required = true;
                required = required && grafico_feligresia.required("iddistritomisionero_all");
                if (required) {
                    $("#idiglesia_all")[0].selectize.focus();
                }
            }

        })
    });





    document.getElementById("ver-reporte").addEventListener("click", function(e) {
        e.preventDefault();
        // Create the chart
        var iddivision_all = document.getElementById("iddivision_all").value
        var pais_id_all = document.getElementById("pais_id_all").value
        var idunion_all = document.getElementById("idunion_all").value
        var idmision_all = document.getElementById("idmision_all").value
        var iddistritomisionero_all = document.getElementById("iddistritomisionero_all").value
        var idiglesia_all = document.getElementById("idiglesia_all").value
        grafico_feligresia.ajax({
            url: '/obtener_feligresia',
            datos: {
                iddivision: iddivision_all,
                pais_id: pais_id_all,
                idunion: idunion_all,
                idmision: idmision_all,
                iddistritomisionero: iddistritomisionero_all,
                idiglesia: idiglesia_all
            }
        }).then(function(response) {
            if(response.length <= 0) {
                BASE_JS.sweet({
                    text: no_hay_datos
                });
                return false;
            }
            // console.log(response);
            Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: titulo_grafico_feligresia
                },
                // subtitle: {
                //     text: 'Click the columns to view versions. Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>'
                // },
                accessibility: {
                    announceNewData: {
                        enabled: true
                    }
                },
                xAxis: {
                    type: 'category'
                },
                yAxis: {
                    title: {
                        text: porcentaje
                    }

                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            format: '{point.y:.1f}%'
                        }
                    }
                },

                tooltip: {
                    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
                },

                series: [
                    {
                        name: "",
                        colorByPoint: true,
                        data: response

                    }
                ],

            });
        });

    })








})
