# == Schema Information
#
# Table name: solutions
#
#  id         :integer          not null, primary key
#  hints      :text
#  problem_id :integer
#  created_at :datetime
#  updated_at :datetime
#  body       :text
#  author_id  :integer
#

#::TODO:: remove
require './lib/acts_as_topicable.rb'

class Solution < ActiveRecord::Base
  acts_as_commentable
  acts_as_votable

  serialize  :hints

  belongs_to :problem
  belongs_to :author, class_name: 'User'

  acts_as_topicable 

  def initialize(*args)
    super 
    self.hints ||= []
  end

  # ex: if hints == ["Hint 1", "Hint 2"], hint_string returns:
  # * Hint 1 
  # 
  # * Hint 2
  def hints_string
    self.hints.map { |h| "* #{h}\n\n" }.join.rstrip
  end

  # Takes in a list of hints, listed by asterisks, like: 
  # --- 
  # * Hint 1
  # * Hint 2
  # ---
  # and sets hints to ["Hint 1", "Hint 2"]
  def hints_string=(hints_string)
    self.hints = "\n#{hints_string}".split("\n*").map(&:strip).reject(&:empty?)
  end
end
