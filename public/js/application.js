$(document).ready(function() {
  $(document).on("submit", "form", function(event){
    event.preventDefault();
    var userName = $("input").val();
    
    $.get("/" + userName, function(response){
      $("#tweets").html(response);
    })
  })
});