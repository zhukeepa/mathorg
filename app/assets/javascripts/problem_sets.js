ready = function(){ 
  $(".contest-link").on("click", function(event) {
    //console.log("#" + this.id + "_list");
    $("#" + this.id + "_list").slideToggle(350);
  });
}

// Relevant when Turbolinks screwed things up. 
$(document).ready(ready);
$(document).on('page:load', ready);
