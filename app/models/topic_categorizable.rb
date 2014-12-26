class TopicCategorizable < ActiveRecord::Base
  belongs_to :categorizable, polymorphic: true
  belongs_to :topic
end
