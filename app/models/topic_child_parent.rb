class TopicChildParent < ActiveRecord::Base
  belongs_to :topic, foreign_key: :child_id
  belongs_to :topic, foreign_key: :parent_id
end
