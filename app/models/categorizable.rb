##::TODO:: move this somewhere more appropriate 

module Categorizable

  # If A and B are included and A is a parent of B, only keep B. 
  def leaf_topics
  	# We make the assumption here that if A is an ancestor of B, then 
  	# everything in between A and B is included as well. 
  	
    # Working set of topics, which we'll extract branches from
    w_topics = self.topics
    finished = []

    # ::TODO_LATER:: can almost certainly be made more efficient, but whatever. 
    # ::TODO_LATER:: test this more extensively to see if it's actually bug-free; 
    #                seems to work decently right now. 
    while w_topics.size > 0
      parentless = w_topics[ w_topics.index { |t| (t.parents & w_topics).empty? } ]
      parentless_ancestry = [parentless]
      while !(next_child = (parentless_ancestry.last.children & w_topics).first).nil?
      	parentless_ancestry.append(next_child)
      end

      finished.append(parentless_ancestry.last)
      w_topics -= parentless_ancestry
    end

    finished
  end

  def topics_string
    leaf_topics.map(&:name).join(', ')
  end

  # When a topic is stored, also assign it all the parents of the topic at hand
  def topics_string=(ts)
    topic_names_array = ts.split(",").map(&:strip).uniq.reject(&:empty?)
    topics_array = Topic.find_all_by_name(topic_names_array)
    self.topics = topics_array.empty? ? [] : topics_array.map(&:ancestor_topics).reduce(:|).uniq
  end
end