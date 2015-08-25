function initTokenizeField() { 
$('input.tokenize').tokenfield({
    autocomplete: {
      source: function (request, response) {
        $.ajax("/topics/autocomplete_topic_name", {
            data: { 
              term: request.term
            },
            success: function (data) {
              response(data);
            }
        });
      },
      delay: 100
    },
    showAutocompleteOnFocus: true
  });
}

var ready = function() {
  initTokenizeField(); 

  $('body').on('click', '.topic-list .links_list .glyphicon-edit', function(e) {
    $(this).closest('.topic-list').find('.edit').show();
    $(this).closest('.topic-list').find('.links_list').hide();
  });

  $('body').on('submit', '.topic-list .edit .form-inline', function(e) {
    var section = $(this).closest('.topic-list'); 
    var topics_array = section.find('.form-control').tokenfield('getTokens').map(function (t) { 
      return t.label; 
    });

    var data = { 'klass': section.data('class'), 
                 'id': section.data('id'), 
                 'name': section.data('name'), 
                 'topics_string': topics_array.join(', ') };

    $.ajax({
      url: '/topicables/update_topic_list', 
      data: JSON.stringify(data),
      type: 'PATCH', 
      contentType: 'application/json', 
      success: function(response) { 
        section.replaceWith(response); 
        initTokenizeField(); 
      }
    });
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);