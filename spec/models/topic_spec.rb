require 'rails_helper'

RSpec.describe Topic, type: :model do 
  before(:each) do
    @topic1 = FactoryGirl.create(:topic, name: "Topic 1")
    @topic2 = FactoryGirl.create(:topic, name: "Topic 2")
    @topic3 = FactoryGirl.create(:topic, name: "Topic 3")
    @topic4 = FactoryGirl.create(:topic, name: "Topic 4")

    @topic1.children = [@topic2, @topic3]
    @topic4.parents = [@topic2, @topic3]
  end

  it "should not allow commas in name" do 
    expect(FactoryGirl.build(:topic, name: 'hello, there').valid?).to be false
  end

  describe "#ancestors" do 
    it "shows all ancestors, including self" do 
      expect(@topic4.ancestors.sort).to eq [@topic1, @topic2, @topic3, @topic4].sort
      expect(@topic3.ancestors.sort).to eq [@topic1, @topic3].sort
      expect(@topic2.ancestors.sort).to eq [@topic1, @topic2].sort
      expect(@topic1.ancestors.sort).to eq [@topic1]
    end
  end 

  describe "#descendants" do 
    it "shows all children, including self" do 
      expect(@topic1.descendants.sort).to eq [@topic1, @topic2, @topic3, @topic4].sort
      expect(@topic2.descendants.sort).to eq [@topic2, @topic4].sort
      expect(@topic3.descendants.sort).to eq [@topic3, @topic4].sort
      expect(@topic4.descendants.sort).to eq [@topic4].sort
    end
  end
end