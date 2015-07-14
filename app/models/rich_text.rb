# == Schema Information
#
# Table name: rich_texts
#
#  id            :integer          not null, primary key
#  text          :text
#  bodyable_id   :integer
#  bodyable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  format        :string(255)
#

class RichText < ActiveRecord::Base
  belongs_to :bodyable, polymorphic: true
  
  def to_html
    markdown_to_html(replace_problems(clean_problems_solutions_markers(self.text)).bbcode_to_html)
  end

private
  def clean_problems_solutions_markers(text) 
    text.gsub("(((", "").gsub(")))", "").gsub("[[[", "").gsub("]]]", "")
  end

  def markdown_to_html(text)
    escaped = text.gsub("\\\\", "\\newline")
                  .gsub("\\[", "\\\\\\\\[")
                  .gsub("\\]", "\\\\\\\\]")
                  .gsub("\\{", "\\\\\\{")
                  .gsub("\\}", "\\\\\\}")
                  .gsub("*}", "\\*}")
    Kramdown::Document.new(escaped, input: 'markdown').to_html
  end

  def replace_problems(text)
    problem_re = /\[problem\]([0-9]*)\[\/problem\]/
    text_with_problems_replaced = text.gsub(problem_re) do |id|
      problem = Problem.find_by_id($1)
      if problem
        next problem.body + "([url=\"/problems/#{problem.id}\"]Link[/url])"
      else
        next "[color=red][i]Problem not found[/i][/color]"
      end
    end

    text_with_problems_replaced
  end
end
