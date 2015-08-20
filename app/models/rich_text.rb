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
    self.text.bbcode_to_html.gsub("\n", "<br/>").gsub(/<pre><code>(.*?)<\/code><\/pre>/m) { next $1 }
  end

  def to_html_with_custom_replacements
    convert_bbcode_headers(replace_solutions(replace_problems(self.text)).bbcode_to_html.gsub("\n\n", "<br/><br/>"))
    #RichText.new(text: replace_solutions(replace_problems(self.text))).to_html
  end

private
  def lol(text)
    foo = text.gsub("(((", "[color=red]")
              .gsub(")))", "[/color]")
              .gsub("{{{", "[color=blue]")
              .gsub("}}}", "[/color] (Link)")

    foo
  end

  def convert_bbcode_headers(text)
    foo = text.gsub("[h1]", "<h1>").gsub("[/h1]", "</h1>")
              .gsub("[h2]", "<h2>").gsub("[/h2]", "</h2>")
              .gsub("[h3]", "<h3>").gsub("[/h3]", "</h3>")
              .gsub("[h4]", "<h4>").gsub("[/h4]", "</h4>")

    foo
  end

  def markdown_to_html(text)
    escaped = text.gsub("\\\\", "\\newline")
                  .gsub("\\[", "\\\\\\\\[")
                  .gsub("\\]", "\\\\\\\\]")
                  .gsub("\\{", "\\\\\\\\{")
                  .gsub("\\}", "\\\\\\\\}")
                  .gsub("*}", "\\*}")
                  .gsub("_{", "\\_{")

    Kramdown::Document.new(escaped, input: 'markdown').to_html
  end

  def replace_problems(text)
    problem_re = /\[problem\]([0-9]*)\[\/problem\]/
    text_with_problems_replaced = text.gsub(problem_re) do |id|
      problem = Problem.find_by_id($1)
      if problem
        next problem.body + " ([url=\"/problems/#{problem.id}\"]Link[/url])"
      else
        next "[color=red][i]Problem not found[/i][/color]"
      end
    end

    text_with_problems_replaced
  end

  def replace_solutions(text)
    solution_re = /\[solution\]([0-9]*)\.([0-9]*)\[\/solution\]/
    text_with_solutions_replaced = text.gsub(solution_re) do |id|
      problem = Problem.find_by_id($1)
      if problem && problem.solutions.size >= 1 + $2.to_i
        next problem.solutions[$2.to_i].body
      else
        next "[color=red][i]Solution not found[/i][/color]"
      end
    end

    text_with_solutions_replaced
  end
end
