require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'

# poltergeist -- what does it actually do when js:true is set
# factory girl -- how it actually stubs out db. what happens on create? why do we have two different behaviors? 

RSpec.feature "Add, edit, and delete problems", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:problem) { FactoryGirl.create(:problem) } 
  let(:problem2) { FactoryGirl.build(:problem2) }

  context "User is signed in and visited the page of a problem" do 
    before(:each) do 
      sign_in(user)
      expect(signed_in?).to be true

      visit "/problems/#{problem.id}"
    end

    scenario "User adds a new problem" do 
      add_problem(problem2)
      expect(current_path).to match /\/problems\/(\d*)\Z/

      [:description, :body, :topics_string].each do |method| 
        expect(page).to have_content(problem2.send method)
      end
    end

    scenario "User edits a problem" do 
      click_link 'Edit'
      expect(current_path).to eq "/problems/#{problem.id}/edit"

      within '.edit_problem' do
        fill_in :problem_description, with: problem2.description
        fill_in :problem_body, with: problem2.body

        click_button 'Update Problem'
      end

      expect(current_path).to eq "/problems/#{problem.id}"
      [:description, :body, :topics_string].each do |method| 
        expect(page).to have_content(problem2.send method)
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
  end

  context "User is not signed in" do 
    scenario "User visits a problem" do 
      visit "/problems/#{problem.id}"
    end

    scenario "User tries to add a problem" do 
      visit "/problems/new"
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end

    scenario "User tries to edit a problem" do 
      visit "/problems/#{problem.id}"
      expect(page).not_to have_content "Edit" 

      visit "/problems/#{problem.id}/edit"
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end
end