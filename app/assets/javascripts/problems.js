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

$(function(){ 
  $("a").on("click", function(event) {
  	//console.log(this.id.substring(0,15));
    if (this.id.substring(0,15) == "solution_button")
    {
      sol_id = this.id.substring(15);
      $("#solution" + sol_id).slideDown(350);
    }
    else if (this.id.substring(0,11) == "hint_button")
    {
      sol_id = this.id.substring(11);
      show_next_hint(sol_id);
    }
  });
});