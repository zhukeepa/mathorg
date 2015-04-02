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



  acts_as_topicable :topic, :explanation
  acts_as_topicable :topic, :solution 

  belongs_to :user

  has_one :body, as: :bodyable, class_name: 'RichText'
  include Bodyable
  accepts_nested_attributes_for :body
  
  include Categorizable
end
