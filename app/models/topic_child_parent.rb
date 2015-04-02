# == Schema Information
#
# Table name: topic_child_parents
#
#  id         :integer          not null, primary key
#  weight     :float
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class TopicChildParent < ActiveRecord::Base
  belongs_to :child , class_name: 'Topic'
  belongs_to :parent, class_name: 'Topic'
end
