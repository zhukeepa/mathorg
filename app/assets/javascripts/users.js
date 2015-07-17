var ready = function() {
  $('body').on('click', '.notification a', function(e) { 
    var i = $(this).closest('.notification').data('index'); 
    var self = $(this); 

    $.ajax({
      url: '/users/delete_notification', 
      data: JSON.stringify({'index': String(i)}),
      type: 'POST', 
      contentType: 'application/json', 
      success: function(response) { 
          self.closest('.notifications').html(response); 
        }
    });
  });
};

// Relevant when Turbolinks screws things up. 
$(document).ready(ready);
$(document).on('page:load', ready);
