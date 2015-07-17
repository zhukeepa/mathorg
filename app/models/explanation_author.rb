# == Schema Information
#
# Table name: explanation_authors
#
#  id             :integer          not null, primary key
#  weight         :float
#  user_id        :integer
#  explanation_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class ExplanationAuthor < ActiveRecord::Base
  belongs_to :explanation
  belongs_to :user
end
