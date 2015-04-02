def acts_as_topicable(options = {})
  topics_name     = options[:topics_name]     || :topics
  topicable_name  = options[:topicable_name]  || name.tableize.to_sym
  topicable_class = options[:topicable_class] || name

  self.class_eval do 
    has_many :topic_categorizables, as: :categorizable
    has_many topics_name, through: :topic_categorizables, source: :topic

    include Categorizable
  end

  Topic.class_eval do 
    has_many topicable_name, through: :topic_categorizables, source: :categorizable, source_type: topicable_class
  end 
end