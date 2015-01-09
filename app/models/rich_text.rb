class RichText < ActiveRecord::Base
  belongs_to :bodyable, polymorphic: true
  
  def to_html
  	problem_re = /\[problem\]([0-9]*)\[\/problem\]/
    text_with_problems_replaced = self.text.gsub(problem_re) do |id|
      problem = Problem.find_by_id($1)
      if problem
      	next problem.body + "([url=\"/problems/#{problem.id}\"]Link[/url])"
      else
      	next "[color=red][i]Problem not found[/i][/color]"
      end
  	end

    text_with_problems_replaced.bbcode_to_html.gsub("\n", "<br/>")
  end
end
