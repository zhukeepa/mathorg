require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'

RSpec.feature "Add, edit, and delete problems", type: :feature do
  let(:problem) { FactoryGirl.build(:problem) } 
  let(:problem_edited) { FactoryGirl.build(:problem2) }

  context "User is signed in and has added a problem" do 
    before(:each) do 
      log_in_with('Bob', 'example@example.com', 'password')
      add_problem(problem)
      expect(signed_in?).to be true
    end


    scenario "User finishes creating problem" do
      expect(current_path).to match /\/problems\/\d*\Z/ # /problems/[some number]
      [:description, :body, :topics_string].each do |method| 
        expect(page).to have_content(problem.send method)
      end
    end

    scenario "User edits a problem" do 
      click_link 'Edit'
      expect(current_path).to match /\/problems\/\d*\/edit\Z/

      within '.edit_problem' do
        fill_in :problem_description, with: problem_edited.description
        fill_in :problem_body, with: problem_edited.body

        click_button 'Update Problem'
      end

      expect(current_path).to match /\/problems\/\d*\Z/
      [:description, :body, :topics_string].each do |method| 
        expect(page).to have_content(problem_edited.send method)
      end
    end

    scenario "User deletes a problem" do 
      click_link 'Destroy'
      expect(page).to have_content("The problem has been destroyed.");
    end

    scenario "User merges problems", js: true do 
      p_id, p_path = problem_id_from_page, current_path

      problem2 = FactoryGirl.build(:problem2)
      add_problem(problem2)
      p2_id, p2_path = problem_id_from_page, current_path 
      expect(page).not_to have_content("This problem is a duplicate.")

      merge_with(p_id)
      visit p2_path 
      expect(page).to have_content("This problem is a duplicate.")
      click_link 'here.'
      expect(current_path).to eq p_path

      problem3 = FactoryGirl.build(:problem, description: "Third problem")
      add_problem(problem3)
      p3_path = current_path

      merge_with(p2_id)
      visit p3_path 
      expect(page).to have_content("This problem is a duplicate.")
      click_link 'here.'
      expect(current_path).to eq p_path

      expect(page).to have_content("Duplicate problems:")
      expect(page).to have_content(problem2.description)
      expect(page).to have_content(problem3.description)
    end

    # scenario "User edits topic", js: true do 
    #   t1, t2, t3, t4 = topics_diamond

    #   page.find('.glyphicon-edit').click

    #   within '.simple_form' do 
    #     fill_in 'topicable___topics_string', with: "Topic 4, Topic 1, Topic 3, Topic 2"# "#{t1.name}, #{t4.name}, #{t3.name}, #{t2.name}"
    #     click_button 'Update topics'
    #   end

    #   expect(page).to have_content("Topic 2")
    # end
  end
end