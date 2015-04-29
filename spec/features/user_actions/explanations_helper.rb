def add_explanation(explanation)
  visit '/explanations/new'

  within '#new_explanation' do 
    fill_in :explanation_title, with: explanation.title
    fill_in :explanation_description, with: explanation.description
    fill_in :explanation_topics_string, with: explanation.topics_string
    fill_in :explanation_body_attributes_text, with: explanation.body.text

    click_button 'Create Explanation'
  end
end