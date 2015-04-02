# require 'active_support/concerns'

module Categorizable
  extend ActiveSupport::Concern

  # If A and B are included and A is a parent of B, only keep B. 
  def leaf_topics # rename this to be less confusing ::TODO::
  	# We make the onceassumption here that if A is an ancestor of B, then 
  	# everything in between A and B is included as well. 
  	
    # Working set of topics, which we'll extract branches from
    w_topics = self.__topics
    finished = []

    # ::TODO_LATER:: can almost certainly be made more efficient, but whatever. 
    # ::TODO_LATER:: test this more extensively to see if it's actually bug-free; 
    #                seems to work decently right now. 
    while w_topics.size > 0
      parentless = w_topics.find { |t| (t.parents & w_topics).empty? }
      parentless_ancestry = [parentless]
      while !(next_child = (parentless_ancestry.last.children & w_topics).first).nil?
        parentless_ancestry.append(next_child)
      end
      finished.append(parentless_ancestry.last)
      w_topics -= parentless_ancestry
    end

    finished
  end

  def topics_all_ancestors
    !self.__topics.empty? ? self.__topics.map(&:ancestor_topics).reduce(:|).uniq : []
  end

  def topics_string
    leaf_topics.map(&:name).join(', ')
  end
  
  # ::TODO:: doesn't handle __topics with commas in it
  def topics_string=(ts)
    topic_names_array = ts.split(",").map(&:strip).uniq.reject(&:empty?)
    self.__topics = Topic.find_all_by_name(topic_names_array)
    self.__topics = topics_all_ancestors
  end
end