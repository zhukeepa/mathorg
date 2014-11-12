class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def up? 
  	positive
  end 

  def down?
  	positive
  end

#private 

#  def positive
#  	self[:positive]
#  end

#  def positive=(val)
#    write_attribute :positive, val
#  end
end