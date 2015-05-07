# require 'rails_helper'
# require_relative 'user_actions/signins_helper'
# require_relative 'user_actions/problems_helper'

# RSpec.feature "Add and edit topics", type: :feature do
#   let(:problem) { FactoryGirl.build(:problem) } 
#   let(:problem2) { FactoryGirl.build(:problem, description: "new description", body: "edited body", topics_string: "Topic 2") }

#   scenario "User creates new problem" do 
#     sign_up('example@example.com', 'password')
#     add_problem(problem)

#     expect(current_path).to match /\/problems\/\d*\Z/ # /problems/[some number]
#     expect(page).to have_content(problem.description)
#     expect(page).to have_content(problem.body)
#     expect(page).to have_content(problem.topics_string)
#   end

#   scenario "User edits a problem" do 
#     sign_up('example@example.com', 'password')
#     add_problem(problem)

#     click_link 'Edit'
#     expect(current_path).to match /\/problems\/\d*\/edit\Z/

#     within '.edit_problem' do
#       fill_in :problem_description, with: problem2.description
#       fill_in :problem_topics_string, with: problem2.topics_string
#       fill_in :problem_body, with: problem2.body

#       click_button 'Update Problem'
#     end

#     expect(current_path).to match /\/problems\/\d*\Z/
#     expect(page).to have_content(problem2.description)
#     expect(page).to have_content(problem2.body)
#     expect(page).to have_content(problem2.topics_string)
#   end

#   scenario "User deletes a problem" do 
#     sign_up('example@example.com', 'password')
#     add_problem(problem)

#     click_link 'Destroy'
#     expect(page).to have_content("The problem has been destroyed.");
#   end
# end