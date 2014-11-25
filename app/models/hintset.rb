class Hintset < ActiveRecord::Base
  belongs_to :solution
  serialize :hints
end
