class TopicSolution < ActiveRecord::Base
  belongs_to :topic
  belongs_to :solution
end