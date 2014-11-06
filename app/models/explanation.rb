class Explanation < ActiveRecord::Base
	has_many :topic_explanations
	has_many :topics, through: :topic_explanations
end
