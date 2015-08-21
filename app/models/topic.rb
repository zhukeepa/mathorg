# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime
#  updated_at :datetime
#

class Topic < ActiveRecord::Base
  searchkick
  has_many :topic_topicables

  # regex: no commas
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }, format: { with: /\A[^,]*\Z/ }

  acts_as_topicable topics_name: :parents, topicable_name: :children, topicable_class: 'Topic'

  def ancestors
    (self.parents.empty? ? [self] : self.parents.map(&:ancestors).flatten.append(self)).uniq
  end

  def descendants
    (self.children.empty? ? [self] : self.children.map(&:descendants).flatten.append(self)).uniq
  end

  def problems_and_solutions_ids
    (self.problems.map(&:id) | self.solutions.map(&:problem).map(&:id)).uniq
  end

  # ::TODO_LATER:: this still has a bug. if, e.g., Problem has_many preqresuites, for exampl, and
  # we need to reference it via topic.prerequisites_from_problems rather than topic.problems, 
  # we're going to run into trouble. 
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
