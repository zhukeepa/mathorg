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
#  authors     :text
#

class Explanation < ActiveRecord::Base
  acts_as_votable
  acts_as_topicable
  serialize :authors, Array

  has_many :explanation_authors
  has_many :users, through: :explanation_authors

  has_one :body, as: :bodyable, class_name: 'RichText'
  include Bodyable
  accepts_nested_attributes_for :body

  def authors_string
    self.authors.join(', ')
  end

  def authors=(as)
    super
    self.users = []
    self.authors.each do |author| 
      if (u = User.find_by_username author) 
        self.users << u
      end
    end
  end

  def authors_string=(as)
    self.authors = as.split(",").map(&:strip).uniq.reject(&:empty?)
  end
end
