var ready = function() {
  $('body').on("click", '.topic-list .links_list .glyphicon-edit', function(e) {
    $(this).closest('.topic-list').find('.edit').show();
    $(this).closest('.topic-list').find('.links_list').hide();
  });

  $("body").on("click", ".topic-list .edit .btn", function(e) {
    var section = $(this).closest('.topic-list'); 
    var data = { 'klass': section.data('class'), 
                 'id': section.data('id'), 
                 'name': section.data('name'), 
                 'topics_string': section.find('#topicable___topics_string').val() };
    
    $.ajax({
      url: '/topicables/update_topic_list', 
      data: JSON.stringify(data),
      type: 'PATCH', 
      contentType: 'application/json', 
      success: function(response) { 
        section.replaceWith(response); 
      }
    });
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);