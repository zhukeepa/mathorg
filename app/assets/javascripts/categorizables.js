var ready;
ready = function() {
  $('.topic-list .show .glyphicon-edit').on("click", function(e) {
    //hide self, and get the location of edit from DOM
    $('.topic-list .show').hide();
    $('.topic-list .edit').show();
  });
}

function updateTopics(e) { 
  //access contents of form submission
  alert("foo");

  // send post request

  // reload the form ?? 
}

$(document).ready(ready);
$(document).on('page:load', ready);