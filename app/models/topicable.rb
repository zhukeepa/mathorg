# require 'active_support/concern'
module Topicable
  extend ActiveSupport::Concern

  # included do 
  #   validate :topics_string_all_valid_topics

  #   def topics_string_all_valid_topics
  #     topic_names_array = __topics_string.split(",").map(&:strip).uniq.reject(&:empty?)
  #     leftovers = topic_names_array - Topic.where(name: topic_names_array).to_a
  #     errors.add(:__topics_string, "has invalid topics #{leftovers.to_sentence}") unless leftovers.empty?
  #   end
  # end

  def __topics_string
    specificest_topics.map(&:name).join(', ')
  end
  
  def __topics_string=(ts)
    topic_names_array = ts.split(",").map(&:strip).uniq.reject(&:empty?)
    self.__topics = Topic.where(name: topic_names_array).to_a
    self.__topics = all_topic_ancestors
  end

  def specificest_topics
    self.__topics.find_all { |t| (t.children & self.__topics).empty? }
  end

private
  def all_topic_ancestors
    !self.__topics.empty? ? self.__topics.map(&:ancestors).reduce(:|).uniq : []
  end
end