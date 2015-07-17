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

FactoryGirl.define do
  factory :explanation_author, :class => 'ExplanationAuthor' do
    weight 1.5
    user_id 1
    explanation_id 1
  end

end
