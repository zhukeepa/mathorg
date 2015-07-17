var ready = function() {
  $(".show-comments-button").on("click", function(e) { 
    $(this).closest("div").find(".comments").slideToggle(350);
  });

  $(".show-comment-form-button").on("click", function(e) { 
    $(this).closest(".comments").find(".comment-form").slideToggle(350);
  });

  $('body').on('submit', '.comment-form', function(e) {
    var section = $(this).closest('.comments'); 
    var data = { 'klass': section.data('class'), 
                 'id': section.data('id'), 
                 'comment': section.find('#comment_comment').val() };
    
  $.ajax({
      url: '/comments', 
      data: JSON.stringify(data),
      type: 'POST', 
      contentType: 'application/json', 
      success: function(response) { 
        section.find('.comment-list').replaceWith(response); 
        setTimeout(function(){MathJax.Hub.Queue(["Typeset", MathJax.Hub, $('#preview')[0]])}, 500);
      }
    });
  });
};

// Relevant when Turbolinks screws things up. 
$(document).ready(ready);
$(document).on('page:load', ready);