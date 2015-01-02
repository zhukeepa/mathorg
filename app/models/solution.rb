class Solution < ActiveRecord::Base
  acts_as_commentable
  acts_as_votable

  serialize  :hints

  belongs_to :problem
  belongs_to :author, class_name: 'User'

  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables

  def initialize(*args)
    super 
    self.hints ||= []
  end

  # ex: if hints == ["Hint 1", "Hint 2"], hint_string returns:
  # * Hint 1 
  # 
  # * Hint 2
  def hints_string
    hints.map { |h| "* #{h}\n\n" }.join.rstrip
  end

  # Takes in a list of hints, listed by asterisks, like: 
  # --- 
  # * Hint 1
  # * Hint 2
  # ---
  # and sets hints to ["Hint 1", "Hint 2"]
  def hints_string=(hints_string)
    self.hints = "\n#{hints_string}".split("\n*").map { |h| h.strip }.reject(&:empty?)
  end
end
