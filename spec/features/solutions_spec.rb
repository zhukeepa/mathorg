require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'
require_relative 'user_actions/solutions_helper'

RSpec.feature "Add, edit, and delete solutions", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:problem) { FactoryGirl.create(:problem) } 
  let(:solution) { FactoryGirl.build(:solution) } 
  let(:solution2) { FactoryGirl.build(:solution2) } 

  context "User is signed in and visits the problem" do
    before(:each) do 
      sign_in(user)
      expect(signed_in?).to be true

      solution.author = user
      problem.solutions << solution
      visit "/problems/#{problem.id}"
      binding.pry
    end

    scenario "User adds new solution" do 
      add_solution(solution2)
      expect(current_path).to eq "/problems/#{problem.id}"
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
      within '.solution' do 
        click_link '(Edit)'

        within '.edit_solution' do
          fill_in :solution_body, with: solution2.body
          fill_in :solution_hints_string, with: solution2.hints_string

          click_button 'Update Solution'
        end
      end

      click_link 'Show solution'
      expect(page).to have_content(solution2.body) 
    end
  end
end