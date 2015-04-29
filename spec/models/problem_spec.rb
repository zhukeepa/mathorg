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

require 'rails_helper'

RSpec.describe Problem, type: :model do
  let(:problem) { FactoryGirl.create(:problem) }

  describe "#show_description" do 
    it "gives the description, or asks the user to add one if there is none" do 
      expect(problem.description.length > 0).to be true
      expect(problem.show_description).to eq problem.description 

      problem.description = ""
      expect(problem.show_description).to eq "No description yet — click to add one!"
    end
  end

  describe "#merge_with_duplicate" do 
    let!(:problem_dup) {  FactoryGirl.create(:problem2) } 

    it "deletes the original problem" do 
      problem.merge_with_duplicate(problem_dup)
      expect(Problem.find_by_id(problem_dup.id)).to be_nil 
    end

    it "merges their topics" do 
      t1 = Topic.create(name: "Topic 1")
      t2 = Topic.create(name: "Topic 2")

      problem.topics = [t1]
      problem_dup.topics = [t2] 

      problem.merge_with_duplicate(problem_dup)
      expect(problem.topics.sort).to eq [t1, t2].sort
    end

    it "merges their solutions" do 
      s1 = FactoryGirl.create(:solution)
      s2 = FactoryGirl.create(:solution2)

      problem.solutions = [s1]
      problem_dup.solutions = [s2] 

      problem.merge_with_duplicate(problem_dup)
      expect(problem.solutions.sort).to eq [s1, s2].sort
    end

    it "replaces the id's in problem sources that include it, and leaves them in the correct order" do 
      ps1 = FactoryGirl.create(:problem_set)
      ps2 = FactoryGirl.create(:problem_set, name: "BAAAH")

      problem3 = FactoryGirl.create(:problem, body: "Yet another body or something")

      ps1.problem_ids = "#{problem_dup.id}, #{problem3.id}"
      ps2.problem_ids = "#{problem3.id}, #{problem_dup.id}"

      problem.merge_with_duplicate(problem_dup)

      ps1.reload 
      ps2.reload

      expect(ps1.problem_ids).to eq "#{problem.id}, #{problem3.id}"
      expect(ps2.problem_ids).to eq "#{problem3.id}, #{problem.id}"
    end
  end 
end