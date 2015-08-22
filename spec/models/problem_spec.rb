# == Schema Information
#
# Table name: problems
#
#  id             :integer          not null, primary key
#  body           :text
#  source         :text
#  author         :text
#  show_solution  :boolean
#  created_at     :datetime
#  updated_at     :datetime
#  description    :text
#  original_id    :integer
#  problem_set_id :integer
#

require 'rails_helper'

RSpec.describe Problem, type: :model do
  let(:problem) { FactoryGirl.create(:problem) }

  describe "#description_maybe_empty" do 
    it "gives the description, or asks the user to add one if there is none" do 
      expect(problem.description.length > 0).to be true
      expect(problem.description_maybe_empty).to eq problem.description 

      problem.description = ""
      expect(problem.description_maybe_empty).to eq "No description"
    end
  end

  describe "#merge_with_duplicate" do 
    let!(:problem_dup) {  FactoryGirl.create(:problem2) } 

    it "merges their topics" do 
      t1 = Topic.create(name: "Topic 1")
      t2 = Topic.create(name: "Topic 2")
      t3 = Topic.create(name: "Topic 3")

      problem.topics = [t1, t3]
      problem_dup.topics = [t2, t3] 

      problem.merge_with_duplicate(problem_dup)
      expect(problem.topics.sort).to eq [t1, t2, t3].sort
    end

    describe "solution merging" do 
      before(:each) do 
        @s1 = FactoryGirl.create(:solution)
        @s2 = FactoryGirl.create(:solution2)

        problem.solutions = [@s1]
        problem_dup.solutions = [@s2] 
      end 

      it "merges their solutions when specified" do 
        problem.merge_with_duplicate(problem_dup, true)
        expect(problem.solutions.sort).to eq [@s1, @s2].sort
      end 

      it "doesn't merge their solutions when specified not to" do 
        problem.merge_with_duplicate(problem_dup, false)
        expect(problem.solutions).to eq [@s1]
      end
    end

    it "changes the duplicated problem's original problem to the current problem's original" do 
      problem.merge_with_duplicate(problem_dup)
      problem_dup.reload 
      expect(problem_dup.original).to eq problem
    end

    # it "replaces the id's in problem sources that include it, and leaves them in the correct order" do 
    #   ps1 = FactoryGirl.create(:problem_set)
    #   ps2 = FactoryGirl.create(:problem_set, name: "BAAAH")

    #   problem3 = FactoryGirl.create(:problem, body: "Yet another body or something")

    #   ps1.problem_ids = "#{problem_dup.id}, #{problem3.id}"
    #   ps2.problem_ids = "#{problem3.id}, #{problem_dup.id}"

    #   problem.merge_with_duplicate(problem_dup)

    #   ps1.reload 
    #   ps2.reload

    #   expect(ps1.problem_ids).to eq "#{problem.id}, #{problem3.id}"
    #   expect(ps2.problem_ids).to eq "#{problem3.id}, #{problem.id}"
    # end
  end 
end
