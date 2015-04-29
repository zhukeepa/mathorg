# == Schema Information
#
# Table name: problems
#
#  id            :integer          not null, primary key
#  body          :text
#  source        :text
#  author        :text
#  show_solution :boolean
#  created_at    :datetime
#  updated_at    :datetime
#  description   :text
#

class Problem < ActiveRecord::Base
  acts_as_topicable
  acts_as_votable
  searchkick

  validates :body, presence: true, length: { minimum: 5 }

  has_many :solutions
  has_and_belongs_to_many :sources, class_name: 'ProblemSet'

  def sources_string
    sources.map(&:name).join(', ')
  end

  def show_description
    (description.length > 0) ? description : "No description yet — click to add one!"
  end

  def merge_with_duplicate(duplicate_problem)
    self.topics    << duplicate_problem.topics 
    self.solutions << duplicate_problem.solutions 

    duplicate_problem.sources.each do |s|
      s.problem_ids = s.problem_ids.gsub("#{duplicate_problem.id}", "#{id}")
    end

    duplicate_problem.destroy
  end
end
