module VotesHelper
  def format_scope(s)
  	if not s
  	  return nil
  	else
  	  return s.sub ' ', '-'
  	end
  end
end
