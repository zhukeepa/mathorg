// get this to work with paloma, maybe??

var latest_hint_shown = [];
function show_next_hint(solution_id)
{
  if (typeof(latest_hint_shown[solution_id]) == 'undefined')
    latest_hint_shown[solution_id] = 0; 
  
  $("#hint_button" + solution_id).html('Show next hint<br>');
  $("#hint_" + solution_id + "_" + latest_hint_shown[solution_id]).slideDown(350);
 
  ++latest_hint_shown[solution_id];

  if (typeof($("#hint_" + solution_id + "_" + latest_hint_shown[solution_id])[0]) == 'undefined')
    $("#hint_button" + solution_id).slideUp(350); 
}

var ready;
ready = function() {
  /* Activating Best In Place */
  $(".best_in_place").best_in_place();

  //::TODO:: create classes 
  //$("a.solution").on("click", function())

  $("a").on("click", function(event) {
    // ::TODO:: use regexes instead
    if (this.id.substring(0,15) == "solution_button")
    {
      sol_id = this.id.substring(15);
      $("#solution" + sol_id).slideToggle(350);
    }
    else if (this.id.substring(0,11) == "hint_button")
    {
      sol_id = this.id.substring(11);
      show_next_hint(sol_id);
    }
    else if (this.id.substring(0,13) == "merge_button_")
    {
      prob_id = this.id.substring(13);
      $("#problem_merge_" + prob_id).slideToggle(350);
    }
  });
}

// Relevant when Turbolinks screws things up. 
$(document).ready(ready);
$(document).on('page:load', ready);
