class Explanation < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
    
  has_many :topic_explanations, dependent: :destroy
  has_many :topics, through: :topic_explanations
end
