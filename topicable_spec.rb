require 'rails_helper'

RSpec.describe Topicable, type: :model do
  before(:each) do
    @t1, @t2, @t3, @t4 = topics_diamond

    @t5 = FactoryGirl.create(:topic, name: "Topic 5")
    @t6 = FactoryGirl.create(:topic, name: "Topic 6")

    @problem = FactoryGirl.create(:problem)
  end

  describe "#specificest_topics" do 
    it "gives the list of most specific topics categorized under" do 
      @problem.topics = [@t1, @t2, @t3, @t4]
      expect(@problem.specificest_topics).to eq [@t4]
    end
  end

  describe "#topics_string=" do 
    context "topics have no ancestry relation" do 
      it "sets topics from strings" do 
        @problem.topics_string = "Topic 5, Topic 6"
        expect(@problem.topics.sort).to eq [@t5, @t6].sort
      end
    end

    # it "does not "
  end 

  describe "#topics_string" do 
    context "topics have no ancestry relation" do 
      it "shows all topics" do 
        @problem.topics = [@t5, @t6]
        expect(["Topic 6, Topic 5", "Topic 5, Topic 6"].include?(@problem.topics_string)).to be true
      end
    end

    context "topics have ancestry relations" do 
      it "only shows the most specific topics" do 
        @problem.topics = [@t1, @t2, @t3, @t4]
        expect(@problem.topics_string).to eq "Topic 4"
      end
    end
  end
end
