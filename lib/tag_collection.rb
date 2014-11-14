module TagCollection
  def topics_string_to_topics_array(tag_string)
    topic_string_array = tag_string.split(",").map(&:strip).uniq
    Topic.find_all_by_name(topic_string_array)
  end

  def topics_array_to_topics_string(topics)
    topics.map(&:name).join(', ')
  end
end