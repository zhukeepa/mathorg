class Topic < ActiveRecord::Base
  searchkick

  validates :name, presence: true, length: { minimum: 5 }

  has_many :topic_explanations, dependent: :destroy
  has_many :explanations, through: :topic_explanations

  has_many :topic_solutions, dependent: :destroy
  has_many :solutions, through: :topic_solutions

  has_many :topic_child_parents, foreign_key: :child_id, dependent: :destroy 
  has_many :parents, through: :topic_child_parents, source: :parent
  has_many :topic_parent_children, class_name: 'TopicChildParent', foreign_key: :parent_id, dependent: :destroy 
  has_many :children, through: :topic_parent_children, source: :child

  def self.topics_string_to_topics_array(tag_string)
    topic_string_array = tag_string.split(",").map(&:strip).uniq.reject(&:empty?)
    Topic.find_all_by_name(topic_string_array)
  end

  def self.topics_array_to_topics_string(topics)
    topics.map(&:name).join(', ')
  end
end