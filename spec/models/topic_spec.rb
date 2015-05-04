# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Topic, type: :model do 
  before(:each) do
    @t1, @t2, @t3, @t4 = topics_diamond
  end

  it "should not allow commas in name" do 
    expect(FactoryGirl.build(:topic, name: 'hello, there').valid?).to be false
  end

  describe "#ancestors" do 
    it "shows all ancestors, including self" do 
      expect(@t4.ancestors.sort).to eq [@t1, @t2, @t3, @t4].sort
      expect(@t3.ancestors.sort).to eq [@t1, @t3].sort
      expect(@t2.ancestors.sort).to eq [@t1, @t2].sort
      expect(@t1.ancestors.sort).to eq [@t1]
    end
  end 

  describe "#descendants" do 
    it "shows all children, including self" do 
      expect(@t1.descendants.sort).to eq [@t1, @t2, @t3, @t4].sort
      expect(@t2.descendants.sort).to eq [@t2, @t4].sort
      expect(@t3.descendants.sort).to eq [@t3, @t4].sort
      expect(@t4.descendants.sort).to eq [@t4].sort
    end
  end
end
