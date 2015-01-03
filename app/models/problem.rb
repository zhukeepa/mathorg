class Problem < ActiveRecord::Base
  acts_as_votable
  searchkick

  #validates :description, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  has_many :solutions

  has_and_belongs_to_many :sources, class_name: 'ProblemSet'


  ##::TODO:: there should be some way to DRY this across all categorizables 
  ## [analogous for solution.rb; problem_set.rb; explanation.rb]
  has_many :topic_categorizables, as: :categorizable
  has_many :topics, through: :topic_categorizables
  include Categorizable

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
