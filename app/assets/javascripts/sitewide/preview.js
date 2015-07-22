function preview(body_id, title_id, custom_replacements)
{
  var body_text  = $("#" + body_id).val(); 
  if (typeof title_id !== 'undefined')
    var title_text = '[b]' + $("#" + title_id).val() + '[/b]\n\n'
  else
    var title_text = ''; 

  var preview_text = title_text + body_text; 

  $.post('/services/preview', {text: preview_text, custom_replacements: custom_replacements}, function(data) { 
    $('#preview').html(data.preview_html); 
    console.log(data.preview_html); 
  });
  
  //If we don't give it a delay, MathJax doesn't seem to notice the preview content 
  //quickly enough. 
  setTimeout(function(){MathJax.Hub.Queue(["Typeset", MathJax.Hub, $('#preview')[0]])}, 500);
}