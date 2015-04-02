# == Schema Information
#
# Table name: topic_categorizables
#
#  id                 :integer          not null, primary key
#  weight             :float
#  categorizable_id   :integer
#  categorizable_type :string(255)
#  topic_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class TopicCategorizable < ActiveRecord::Base
  belongs_to :categorizable, polymorphic: true
  belongs_to :topic
end
