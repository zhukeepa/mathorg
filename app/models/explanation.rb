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

#::TODO:: remove
require './lib/acts_as_topicable.rb'

class Explanation < ActiveRecord::Base
  acts_as_votable
  acts_as_topicable

  belongs_to :user

  has_one :body, as: :bodyable, class_name: 'RichText'
  include Bodyable
  accepts_nested_attributes_for :body
end
