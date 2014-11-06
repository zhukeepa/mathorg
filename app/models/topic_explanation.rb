class TopicExplanation < ActiveRecord::Base
  belongs_to :topic
  belongs_to :explanation 
end