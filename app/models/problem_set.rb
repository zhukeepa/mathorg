# == Schema Information
#
# Table name: problem_sets
#
#  id            :integer          not null, primary key
#  problem_order :text
#  name          :string(255)
#  official      :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class ProblemSet < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  acts_as_topicable

  has_and_belongs_to_many :problems

  # represents the permutation of the sorted list of problem id's corresponding to 
  # the ordering of the list of problems. 
  serialize :problem_order, Array

  def to_param
    self.name
  end

  def initialize(*args)
  	super
  	self.problem_order ||= []
  end

  def problem_ids
    problems.map(&:id).join(', ')
  end

  def problem_ids=(problem_ids)
    problem_ids_array = problem_ids.split(",").map(&:strip).reject(&:empty?).map(&:to_i)
    sorted_problem_ids_array = problem_ids_array.sort

    self.problem_order = problem_ids_array.map { |i| sorted_problem_ids_array.index(i) }
    self.problems = Problem.find_all_by_id(problem_ids_array)
    save
  end

  def problems
    ProblemSet.sort_array_by_order(super.sort_by(&:id), problem_order)
  end

private
  def self.sort_array_by_order(array, ordering)
    (0...array.length).map { |i| array[ordering[i]] }
  end
end
