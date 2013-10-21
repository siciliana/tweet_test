$(document).ready(function() {

  var username = $("h1").data("user");
  console.log(username);
  $.post("/add_new_tweets", {username: username}, function(response){
    $(".latest_tweets").replaceWith(response);
  });
 
});