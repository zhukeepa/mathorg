// get this to work with paloma, maybe??

var latest_hint_shown = [];
function show_next_hint(hint_button)
{
  var solution_id = hint_button.data('id');
  if (typeof(latest_hint_shown[solution_id]) == 'undefined') {
    latest_hint_shown[solution_id] = 0; 
    hint_button.html('Show next hint<br>');
  }
  
  var hints = hint_button.closest("div").find(".hint");
  var hint = $.grep(hints, function(h) { return ($(h).data('id') == latest_hint_shown[solution_id]); })[0];
  $(hint).slideDown(350);
 
  ++latest_hint_shown[solution_id];

  if ($.grep(hints, function(h) { return ($(h).data('id') == latest_hint_shown[solution_id]); }).length == 0)
    hint_button.slideUp(350); 
}

var ready = function() {
  /* Activating Best In Place */
  $(".best_in_place").best_in_place();

  //::TODO:: create classes 
  //$("a.solution").on("click", function())

  $(".show_solution").on("click", function(e) { 
    $(this).closest("div").find(".solution").slideToggle(350);
  });

  $(".show_hint").on("click", function(e) { 
    show_next_hint($(this));
  });

  $(".merge_button").on("click", function(e) { 
    $(this).parent().find(".merge").slideToggle(350);
  });
};

// Relevant when Turbolinks screws things up. 
$(document).ready(ready);
$(document).on('page:load', ready);
