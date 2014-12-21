class Problem < ActiveRecord::Base
  acts_as_votable
  validates :description, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  searchkick
  has_many :solutions
end
