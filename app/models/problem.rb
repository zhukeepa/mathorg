class Problem < ActiveRecord::Base
  searchkick
  has_many :solutions
end
