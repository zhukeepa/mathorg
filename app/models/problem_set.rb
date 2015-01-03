class ProblemSet < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }


  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables
  include Categorizable

  has_and_belongs_to_many :problems

  serialize :problem_order, Array

  def to_param
    self.name
  end

  def initialize(*args)
  	super
  	self.problem_order ||= []
  end

  def problem_ids_string
    ProblemSet.sort_array_by_order(problem_ids.sort, self.problem_order).join(', ')
  end

  def problem_ids_string=(problem_ids_string)
    problem_ids_array = problem_ids_string.split(",").map(&:strip).reject(&:empty?).map(&:to_i)
    self.problem_order = problem_ids_array.map { |i| problem_ids_array.sort.index(i) }
    self.problems = Problem.find_all_by_id(problem_ids_array)
  end

  def problems_sorted
    ProblemSet.sort_array_by_order(self.problems.sort_by(&:id), self.problem_order)
  end

private
  def self.sort_array_by_order(array, ordering)
    s = array.length
    sorted_array = Array.new(s)

    for i in 0...s
      sorted_array[i] = array[ordering[i]]
    end

    sorted_array 
  end
end
