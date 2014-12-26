class Explanation < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
    
  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables
end