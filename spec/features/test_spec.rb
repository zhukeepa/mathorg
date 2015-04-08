require 'rails_helper'
# require 'features_helper'

RSpec.describe Categorizable, type: :feature do
  let(:problem) { Problem.create!(description: "description", body: "body fat", topics_string: "Topic 1") }

  def setup
    
  end

  def method_name
    
  end
  
  it "should visit the root page and not crash" do
    visit '/topics'

    click_link 'New topic'
  end

  it "should successfully create problems" do 
    visit '/problems/new'

    within '#new_problem' do 
      fill_in :problem_description, with: problem.description
      fill_in :problem_topics_string, with: problem.topics_string
      fill_in :problem_body, with: problem.body

      click_button 'Create Problem'
    end 

    expect(current_path).to match /\/problems\/*/

    expect(has_content?(problem.description)).to be true
    expect(has_content?(problem.body)).to be true
    expect(has_content?(problem.topics_string)).to be true
  end

  private

  def login
    visit '/login'

    wt....
    ...
    ..end
  end
end
