function show_result(data){
    const result = document.getElementById("result");
    result.innerHTML = "<hr/>" + data.value +
        "<hr/><p id = 'date'>"+Date()+"</p>";
}
$(document).ready(function(){
    $("#chisla_form").bind("ajax:success",
        function(xhr, data, status) {
// data is already an object
            show_result(data)
        })
})