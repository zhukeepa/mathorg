module ApplicationHelper
  ## lmao; fix this when actual design happens and you work with CSS
  def long_entry_row_num
    8
  end

  def elegance_rating_meanings
    { "-2" => "oh god", 
      "-1" => "ugly", 
      "0" => "good",
      "1" => "really nice",  
      "2" => "amazing" }
  end

  def difficulty_rating_meanings
    { "1" => "<= AIME", 
      "2" => "IMO 1/4", 
      "3" => "Easier 2/5",
      "4" => "Medium 2/5",  
      "5" => "Trickier 2/5", 
      "6" => "Easier 3/6",
      "7" => "Reasonable 3/6", 
      "8" => "Insane" }
  end
end
