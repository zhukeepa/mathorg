class Solution < ActiveRecord::Base
  serialize  :hints

  belongs_to :problem

  has_many :topic_solutions, dependent: :destroy
  has_many :topics, through: :topic_solutions

  def initialize(*args)
    super 
    self.hints ||= []
  end

  def self.hint_string_to_array(hints_string)
    "\n#{hints_string}".split("\n*").map { |h| h.strip }.reject(&:empty?)
  end

  def self.hint_array_to_string(hints_array)
    hints_array.map { |h| "* #{h}\n\n" }.join.rstrip
  end
end
