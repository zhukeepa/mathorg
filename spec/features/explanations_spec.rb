require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/explanations_helper'

RSpec.feature "Add, edit, and delete explanations", type: :feature do
  let(:explanation) { FactoryGirl.build(:explanation) } 
  let(:explanation_edited) { FactoryGirl.build(:explanation_edited) }

  context "User is signed in and has added a new explanation" do 
    before(:each) do 
      log_in_with('example@example.com', 'password')
      add_explanation(explanation)
      expect(signed_in?).to be true
    end

    scenario "User finishes creating explanation" do
      expect(current_path).to match /\/explanations\/\d*\Z/ # /problems/[some number]

      [:title, :description, :topics_string].each do |method| 
        expect(page).to have_content(explanation.send(method))
      end 
      expect(page).to have_content(explanation.body.text)
    end

    scenario "User votes up and then down", js: true do 
      within ".vote" do 
        click_link '++'
        expect(page).to have_content('++ 1')
        expect(page).to have_content('-- 0')

        click_link '--'
        expect(page).to have_content('-- 0')
        expect(page).to have_content('++ 1')
      end
    end

    scenario "User edits an explanation" do 
      click_link 'Edit'
      expect(current_path).to match /\/explanations\/\d*\/edit\Z/

      within '.edit_explanation' do
        fill_in :explanation_title, with: explanation_edited.title
        fill_in :explanation_description, with: explanation_edited.description
        fill_in :explanation_topics_string, with: explanation_edited.topics_string
        fill_in :explanation_body_attributes_text, with: explanation_edited.body.text

        click_button 'Update Explanation'
      end

      [:title, :description, :topics_string].each do |method| 
        expect(page).to have_content(explanation_edited.send(method))
      end 
      expect(page).to have_content(explanation_edited.body.text)
    end

    scenario "User includes a problem tag in the explanation" do 
      click_link 'Edit'
      expect(current_path).to match /\/explanations\/\d*\/edit\Z/

      problem = FactoryGirl.create(:problem)
      explanation.body = RichText.new(text: "Hello [problem]#{problem.id}[/problem]")

      within '.edit_explanation' do
        fill_in :explanation_body_attributes_text, with: explanation.body.text

        click_button 'Update Explanation'
      end

      [:title, :description, :topics_string].each do |method| 
        expect(page).to have_content(explanation.send(method))
      end 

      expect(page).to have_content(problem.body.bbcode_to_html.gsub("\n", "<br/>"))
    end

    # ::TODO:: doesn't work
    # scenario "User edits topic", js: true do 
    #   t1, t2, t3, t4 = topics_diamond

    #   page.find('.glyphicon-edit').click

    #   within '.simple_form' do 
    #     fill_in 'categorizable___topics_string', with: "#{t1.name}, #{t4.name}, #{t3.name}, #{t2.name}"
    #     click_button 'Update topics'
    #   end

    #   expect(page).to have_content(t4.name)
    # end
  end
end