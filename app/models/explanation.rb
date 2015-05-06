# == Schema Information
#
# Table name: explanations
#
#  id          :integer          not null, primary key
#  description :text
#  title       :text
#  depth       :integer
#  ordering    :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Explanation < ActiveRecord::Base
  acts_as_votable
  acts_as_topicable
  serialize :authors, Array

  belongs_to :user

  has_one :body, as: :bodyable, class_name: 'RichText'
  include Bodyable
  accepts_nested_attributes_for :body

  def authors_string
    self.authors.join(', ')
  end

  def authors_string=(as)
    self.authors = as.split(",").map(&:strip).uniq.reject(&:empty?)
    
    self.authors.each do |author| 
      self.user ||= User.find_by_username author
    end
  end
end
