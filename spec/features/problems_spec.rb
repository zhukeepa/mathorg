require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'

RSpec.feature "Add, edit, and delete problems", type: :feature do
  let(:problem) { FactoryGirl.build(:problem) } 
  let(:problem_edited) { FactoryGirl.build(:problem_edited) }

  context "User is signed in and has added a problem" do 
    before(:each) do 
      log_in_with('example@example.com', 'password')
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
        fill_in :problem_topics_string, with: problem_edited.topics_string
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

    scenario "User edits topic", js: true do 
      t1, t2, t3, t4 = topics_diamond

      page.find('.glyphicon-edit').click

      within '.simple_form' do 
        page.driver.debug
        fill_in 'categorizable___topics_string', with: "Topic 4, Topic 1, Topic 3, Topic 2"# "#{t1.name}, #{t4.name}, #{t3.name}, #{t2.name}"
        click_button 'Update topics'
        binding.pry
      end

      expect(page).to have_content("Topic 2")
    end
  end
end