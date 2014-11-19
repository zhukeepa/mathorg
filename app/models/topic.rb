class Topic < ActiveRecord::Base
  has_many :topic_explanations
  has_many :explanations, through: :topic_explanations

  has_many :topic_child_parents, foreign_key: :child_id
  has_many :parents, through: :topic_child_parents, source: :topic, foreign_key: :child_id
  has_many :topic_parent_children, class_name: 'TopicChildParent', foreign_key: :parent_id
  has_many :children, through: :topic_parent_children, source: :topic, foreign_key: :parent_id

  ##::TODO::
  #def children
  #	 Topic.all.keep_if { |t| t.parents.map{ |tt| tt.id }.include? self.id }
  #end

  ##::TODO:: replace with global method
  def self.topics_string_to_topics_array(tag_string)
    topic_string_array = tag_string.split(",").map(&:strip).uniq
    Topic.find_all_by_name(topic_string_array)
  end
end
