require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/explanations_helper'

RSpec.feature "Add, edit, and delete explanations", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:explanation) { FactoryGirl.create(:explanation_with_author) } 
  let(:explanation2) { FactoryGirl.build(:explanation2) }

  context "User is signed in and visits explanation he added" do 
    before(:each) do 
      sign_in(user)
      expect(signed_in?).to be true


      visit "/explanations/#{explanation.id}"
    end

    scenario "User adds new explanation" do 
      add_explanation(explanation2)
      expect(current_path).to match /\/explanations\/\d*\Z/ # /problems/[some number]

      [:title, :description, :topics_string].each do |method| 
        expect(page).to have_content(explanation2.send(method))
      end 
      expect(page).to have_content(explanation2.body.text)
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
        fill_in :explanation_title, with: explanation2.title
        fill_in :explanation_description, with: explanation2.description
        fill_in :explanation_topics_string, with: explanation2.topics_string
        fill_in :explanation_body_attributes_text, with: explanation2.body.text

        click_button 'Update Explanation'
      end

      [:title, :description, :topics_string].each do |method| 
        expect(page).to have_content(explanation2.send(method))
      end 
      expect(page).to have_content(explanation2.body.text)
    end

    scenario "User includes a problem tag in the explanation" do 
      click_link 'Edit'

      problem = FactoryGirl.create(:problem)

      within '.edit_explanation' do
        fill_in :explanation_body_attributes_text, with: "Hello [problem]#{problem.id}[/problem]"

        click_button 'Update Explanation'
      end

      [:title, :description, :topics_string].each do |method| 
        expect(page).to have_content(explanation.send(method))
      end 

      expect(page).to have_content(problem.body.bbcode_to_html.gsub("\n", "<br/>"))
    end

    scenario "User adds authors aside from himself and visits page" do 
      click_link 'Edit'

      FactoryGirl.create(:user, username: "Charlie", email: "Charlie@Sheen.win")

      within '.edit_explanation' do
        fill_in :explanation_authors_string, with: "#{user.username}, Jones, Charlie"

        click_button 'Update Explanation'
      end

      expect(page).to have_content("#{user.username}, Jones, and Charlie")
      click_link "Charlie"
    end

    # ::TODO:: doesn't work
    # scenario "User edits topic", js: true do 
    #   t1, t2, t3, t4 = topics_diamond

    #   page.find('.glyphicon-edit').click

    #   within '.simple_form' do 
    #     fill_in 'topicable___topics_string', with: "#{t1.name}, #{t4.name}, #{t3.name}, #{t2.name}"
    #     click_button 'Update topics'
    #   end

    #   expect(page).to have_content(t4.name)
    # end
  end
end