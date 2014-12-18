class ProblemResource < ActiveRecord::Base
  serialize :problem_ids, Array
end
