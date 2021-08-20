var importar = new BASE_JS('importar', 'importar');

document.addEventListener("DOMContentLoaded", function() {
        
   
   
    document.getElementById("importar").addEventListener("click", function(event) {
        event.preventDefault();
        var promise = importar.guardar();

        promise.then(function(response) {

        })
    })


 

})