# == Schema Information
#
# Table name: topic_topicables
#
#  id             :integer          not null, primary key
#  weight         :float
#  topicable_id   :integer
#  topicable_type :string(255)
#  topic_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class TopicTopicable < ActiveRecord::Base
  belongs_to :topicable, polymorphic: true
  belongs_to :topic
end
