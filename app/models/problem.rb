# == Schema Information
#
# Table name: problems
#
#  id             :integer          not null, primary key
#  body           :text
#  source         :text
#  author         :text
#  show_solution  :boolean
#  created_at     :datetime
#  updated_at     :datetime
#  description    :text
#  original_id    :integer
#  problem_set_id :integer
#

class Problem < ActiveRecord::Base
  acts_as_topicable
  acts_as_votable
  searchkick

  validates :body, presence: true

  markable_as :favorite, :working_on, :solved

  has_many :solutions
  belongs_to :problem_set

  belongs_to :original, class_name: 'Problem'
  has_many :duplicates, class_name: 'Problem', foreign_key: :original_id

  def initialize(*args)
    super
    self.original ||= self 
  end 

  def difficulty
    votes = get_upvotes(vote_scope: "difficulty")
    votes.sum(:vote_weight).to_f / votes.size
  end

  def solutions_sorted
    self.solutions.sort_by { |s| -s.rating }
  end

  def problem_set_with_name_source
    ProblemSet.where(name: source).first
  end

  def description_maybe_empty
    (description.length > 0) ? description : "No description"
  end

  def body_formatted
    RichText.new(text: self.body).to_html
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
