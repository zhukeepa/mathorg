class Problem < ActiveRecord::Base
  has_many :solutions

  def all_hintsets
  	self.solutions.map(&:hintsets).flatten.map(&:hints)
  end
end
