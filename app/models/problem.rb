# == Schema Information
#
# Table name: problems
#
#  id            :integer          not null, primary key
#  body          :text
#  source        :text
#  author        :text
#  show_solution :boolean
#  created_at    :datetime
#  updated_at    :datetime
#  description   :text
#

#::TODO:: remove
require './lib/acts_as_topicable.rb'

class Problem < ActiveRecord::Base
  acts_as_topicable
  acts_as_votable
  searchkick

  validates :body, presence: true, length: { minimum: 5 }

  has_many :solutions
  has_and_belongs_to_many :sources, class_name: 'ProblemSet'

  def sources_string
    sources.map(&:name).join(', ')
  end

  def show_description
    if description.length > 0
      description
    else 
      "No description yet — click to add one!"
    end
  end
end
