class Topic < ActiveRecord::Base
	has_many :topic_explanations
	has_many :explanations, through: :topic_explanations
end
