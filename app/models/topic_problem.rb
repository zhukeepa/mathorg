class TopicProblem < ActiveRecord::Base
  belongs_to :topic
  belongs_to :problem
end