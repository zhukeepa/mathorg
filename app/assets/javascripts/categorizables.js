var ready = function() {
  $('.topic-list .links_list .glyphicon-edit').on("click", function(e) {
    $(this).closest('.topic-list').find('.edit').show();
    $(this).closest('.topic-list').find('.links_list').hide();
  });

  $('.topic-list .edit .btn').on("click", function(e) {
    var section = $(this).closest('.topic-list'); 
    var data = { 'klass': section.data('class'), 
                 'id': section.data('id'), 
                 'name': section.data('name'), 
                 'topics_string': section.find('#categorizable___topics_string').val() };
    
    $.ajax({
      url: '/categorizables/update_topic_list', 
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