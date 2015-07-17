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

require 'rails_helper'

RSpec.describe Explanation, type: :model do
  let(:explanation) { FactoryGirl.create(:explanation) }
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, username: "Builder", email: "foo@bar.com") }

  describe "#authors_string" do 
    it "gives the list of authors" do
      explanation.authors = ["A1", "B4", "Alex", "Builder", "John"]
      expect(explanation.authors_string).to eq "A1, B4, Alex, Builder, John"
    end
  end

  describe "#authors_string=" do 
    it "sets the list of authors from a string" do
      authors = ["A1", "B4", "Alex", "Builder", "John"]
      explanation.authors_string = authors.join(', ')
      expect(explanation.authors.sort).to eq authors.sort
    end

    it "remembers from the list the set of users with usernames among the list of users" do
      authors = ["A1", "B4", "Alex", "Builder", "John"]
      explanation.authors_string = authors.join(', ')
      expect(explanation.users.map(&:username).sort).to eq ["Alex", "Builder"]
    end
  end
end
