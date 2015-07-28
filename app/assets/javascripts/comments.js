var ready = function() {
  $(".show-comments-button").on("click", function(e) { 
    $(this).closest("div").find(".comments").slideToggle(350);
    $(this).blur(); 
  });

  $(".show-comment-form-button").on("click", function(e) { 
    $(this).closest(".comments").find(".comment-form").slideToggle(350);
    $(this).blur(); 
  });

  $('body').on('submit', '.comment-form', function(e) {
    var section = $(this).closest('.comments'); 
    var textarea = section.find("#comment_comment"); 
    var data = { 'klass': section.data('class'), 
                 'id': section.data('id'), 
                 'comment': textarea.val() };
    
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

    textarea.val(""); 
    $(this).blur(); 
  });
}

// Relevant when Turbolinks screws things up. 
$(document).ready(ready);
$(document).on('page:load', ready);