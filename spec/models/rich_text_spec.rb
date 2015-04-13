require 'rails_helper'

RSpec.describe RichText, type: :model do
  let!(:problem) { FactoryGirl.create(:problem) }
  let!(:problem2) { FactoryGirl.create(:problem_edited) }

  describe "#to_html" do 
    it "should replace problems in tags with the problem's body" do
      htmlified = RichText.new(text: "Blah [problem]#{problem.id}[/problem] [problem]#{problem2.id}[/problem]").to_html
      expect(htmlified.include?(problem.body)).to be true
      expect(htmlified.include?(problem2.body)).to be true
    end
  end 
end