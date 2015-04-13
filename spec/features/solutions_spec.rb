require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'
require_relative 'user_actions/solutions_helper'

RSpec.feature "Add, edit, and delete solutions", type: :feature do
  let(:problem) { FactoryGirl.build(:problem) } 
  let(:solution) { FactoryGirl.build(:solution) } 
  let(:solution_edited) { FactoryGirl.build(:solution_edited) } 

  context "User is signed in, added a new problem, and added a new solution." do 

    before(:each) do 
      log_in_with('example@example.com', 'password')
      expect(signed_in?).to be true
      
      add_problem(problem)
      add_solution(solution)
    end

    scenario "User finishes creating solution" do
      expect(current_path).to match /\/problems\/\d*\Z/ # /problems/[some number]
    end

    scenario "User clicks on 'Show hints' to see all hints", js: true do 
      solution.hints.each_with_index do |h, i| 
        expect(page).to have_no_content(h)
        click_link (i > 0 ? "Show next hint" : "Show hints")
        expect(page).to have_content(h)
      end
    end

    scenario "User clicks on 'Show solution'", js: true do 
      click_link 'Show solution'
      expect(page).to have_content(solution.body) 
    end

    scenario "User shows solution and edits it", js: true do 
      click_link 'Show solution'
      click_link 'Edit solution'

      within '.edit_solution' do
        fill_in :solution_body, with: solution_edited.body
        fill_in :solution_hints_string, with: solution_edited.hints_string
        fill_in :solution_topics_string, with: solution_edited.topics_string

        click_button 'Update Solution'
      end

      click_link 'Show solution'
      expect(page).to have_content(solution_edited.body) 
    end
  end
end