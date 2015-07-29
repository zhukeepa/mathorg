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

  # ::TODO:: test this! and the sorting
  def rating
    (get_upvotes.size + 2)/(get_downvotes.size + 2)
  end

  # ex: if hints == ["Hint 1", "Hint 2"], hint_string returns:
  # * Hint 1 
  # 
  # * Hint 2
  def hints_string
    self.hints.map { |h| "* #{h}\n\n" }.join.rstrip
  end

  def body_formatted
    RichText.new(text: self.body).to_html
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
