# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime
#  updated_at :datetime
#

#::TODO:: remove
require './lib/acts_as_topicable.rb'

class Topic < ActiveRecord::Base
  searchkick
  has_many :topic_categorizables

  # regex: no commas
  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }, format: { with: /\A[^,]*\Z/ }

  acts_as_topicable topics_name: :parents, topicable_name: :children, topicable_class: 'Topic'

  def ancestors
    (self.parents.empty? ? [self] : self.parents.map(&:ancestors).flatten.append(self)).uniq
  end

  def descendants
    (self.children.empty? ? [self] : self.children.map(&:descendants).flatten.append(self)).uniq
  end

  # ::TODO:: this is SO HACKY there must be a better way...?? also, doesn't fully work...
  def method_missing(m, *args, &block)
    # e.g. if doing topic.problems, touch the Problem class, so that it loads and
    # adds the problems method to Problem from acts_as_topicable. 
    klass = m.to_s.titleize.gsub(' ', '').singularize.constantize
    if Topic.instance_methods.include?(m)
      self.send m
    else
      super 
    end
  rescue
    super
  end
end
