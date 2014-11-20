class Explanation < ActiveRecord::Base
  has_many :topic_explanations, dependent: :destroy
  has_many :topics, through: :topic_explanations
end
