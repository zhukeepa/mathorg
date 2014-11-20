class Problem < ActiveRecord::Base
  has_many :solutions, class_name: 'Explanation'
end
