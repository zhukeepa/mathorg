class Explanation < ActiveRecord::Base
  acts_as_votable

  belongs_to :user

  has_one :body, as: :bodyable, class_name: 'RichText'
  include Bodyable
  
  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables
  include Categorizable
end