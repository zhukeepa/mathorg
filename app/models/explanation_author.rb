class ExplanationAuthor < ActiveRecord::Base
  belongs_to :explanation
  belongs_to :user
end
