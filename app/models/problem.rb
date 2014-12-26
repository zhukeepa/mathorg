class Problem < ActiveRecord::Base
  acts_as_votable
  searchkick

  validates :description, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  has_many :solutions

  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables
end
