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

  belongs_to :original, class_name: 'Problem'
  has_many :duplicates, class_name: 'Problem', foreign_key: :original_id

  def initialize(*args)
    super
    self.original ||= self 
  end 

  def sources_string
    sources.map(&:name).join(', ')
  end

  def show_description
    (description.length > 0) ? description : "No description yet — click to add one!"
  end

  def is_duplicate?
    self.original != self
  end 

  def is_original?
    !is_duplicate?
  end

  def duplicates
    super - [self]
  end 

  def merge_with_duplicate(duplicate_problem, should_merge_solutions = true)
    self.topics |= duplicate_problem.topics 
    self.solutions << duplicate_problem.solutions if should_merge_solutions

    duplicate_problem.update(original: self.original)
  end
end
