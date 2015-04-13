require 'rails_helper'

RSpec.describe ProblemSet, type: :model do
  let!(:p1) { FactoryGirl.create(:problem) }
  let!(:p2) { FactoryGirl.create(:problem) }
  let!(:p3) { FactoryGirl.create(:problem) }
  let!(:p4) { FactoryGirl.create(:problem) }

  let (:ps) { FactoryGirl.build(:problem_set) } 

  describe "#problem_ids=" do 
    it "should set associated problems based on list" do
      ps.problem_ids = "#{p1.id}, #{p3.id}, #{p2.id}, #{p4.id}"
      expect(ps.problems.sort).to eq [p1, p2, p3, p4].sort
    end
  end 

  describe "#problems" do 
    it "should remember the order its problems were set" do 
      ps.problem_ids = "#{p1.id}, #{p3.id}, #{p2.id}, #{p4.id}"
      expect(ps.problems).to eq [p1, p3, p2, p4]

      ps.problem_ids = "#{p4.id}, #{p1.id}, #{p3.id}"
      expect(ps.problems).to eq [p4, p1, p3]
    end
  end

  describe "#problem_ids" do 
    it "should return the list of id's in the order they were set" do 
      p_ids = "#{p1.id}, #{p3.id}, #{p2.id}, #{p4.id}"
      ps.problem_ids = p_ids
      expect(ps.problem_ids).to eq p_ids
    end
  end 
end