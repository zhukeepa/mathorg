class ProblemSet < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }


  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables

  has_and_belongs_to_many :problems

  serialize :problem_order, Array

  def initialize(*args)
  	super
  	self.problem_order ||= []
  end

  def to_param
    self.name
  end

  def self.problem_ids_string_to_problems_array_and_ordering(problem_ids_string)
    problems_array = problem_ids_string.split(",").map(&:strip).reject(&:empty?).map(&:to_i)
    ordering = problems_array.map { |i| problems_array.sort.index(i) }
    problems = Problem.find_all_by_id(problems_array)

    return problems, ordering
  end

  def self.sort_array_by_order(array, ordering)
    s = array.length
    sorted_array = Array.new(s)

    for i in 0...s
      sorted_array[i] = array[ordering[i]]
    end

    sorted_array 
  end

  def self.problems_array_and_ordering_to_problem_ids_string(problems_array, ordering)
    problem_ids_array = problems_array.map(&:id)
    ProblemSet.sort_array_by_order(problem_ids_array, ordering).join(', ')
  end

#  def self.problem_set_string_to_problem_set_array(ps_string)
#    ps_string_array = ps_string.split(",").map(&:strip).uniq.reject(&:empty?)
#    ProblemSet.find_all_by_name(ps)
#  end
end
