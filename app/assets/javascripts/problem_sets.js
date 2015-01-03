ready = function(){ 
  $(".contest_link").on("click", function(event) {
    //console.log("#" + this.id + "_list");
    $("#" + this.id + "_list").slideToggle(350);
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
