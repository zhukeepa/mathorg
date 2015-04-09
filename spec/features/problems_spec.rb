require 'rails_helper'
require_relative 'features_helper'

RSpec.feature "Adding problems", type: :feature do
  let(:problem) { Problem.new(description: "description", body: "body fat", topics_string: "Topic 1") }
  let(:problem_edited) { Problem.new(description: "new description", body: "edited body", topics_string: "Topic 2") }

  scenario "User can create new problems" do 
    register('example@example.com', 'password')

    visit '/problems/new'

    # why is within necessary below? 
    #within '#new_problem' do 
      fill_in :problem_description, with: problem.description
      fill_in :problem_topics_string, with: problem.topics_string
      fill_in :problem_body, with: problem.body

      click_button 'Create Problem'
    #end 

    # /problems/[some number]
    expect(current_path).to match /\/problems\/\d*\Z/

    expect(has_content?(problem.description)).to be true
    expect(has_content?(problem.body)).to be true
    expect(has_content?(problem.topics_string)).to be true

    click_link 'Edit'
    expect(current_path).to match /\/problems\/\d*\/edit\Z/

    # how to get id here??
    # within '#edit_problem_#{id}'
      fill_in :problem_description, with: problem_edited.description
      fill_in :problem_topics_string, with: problem_edited.topics_string
      fill_in :problem_body, with: problem_edited.body

      click_button 'Update Problem'
    #end

    expect(current_path).to match /\/problems\/\d*\Z/

    expect(has_content?(problem_edited.description)).to be true
    expect(has_content?(problem_edited.body)).to be true
    expect(has_content?(problem_edited.topics_string)).to be true    
  end
end