class Problem < ActiveRecord::Base
  validates :description, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  searchkick
  has_many :solutions
end
