require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'
require_relative 'user_actions/solutions_helper'

RSpec.feature "Add comments", type: :feature do
  let(:user) {FactoryGirl.create(:user) }
  let(:problem) { FactoryGirl.build(:problem) } 
  let(:solution) { FactoryGirl.build(:solution) } 

  context "User is signed in, added a new problem, and added a new solution." do 
    before(:each) do 
      sign_in(user)
      expect(signed_in?).to be true
      
      add_problem(problem)
      add_solution(solution)
    end

    scenario "User adds comment", js: true do
      click_link 'Show solution'
      click_link 'Comments'
      expect(page).to have_content("No comments have been submitted yet.")

      click_link 'Add comment'
      within '.comment-form' do 
        fill_in :comment_comment, with: "Comment 1"
        click_button 'Add comment'
      end 

      expect(page).to have_content("Comment 1")
    end
  end
end