def add_problem(problem)
  visit '/problems/new'

  within '#new_problem' do 
    fill_in :problem_description, with: problem.description
    fill_in :problem_topics_string, with: problem.topics_string
    fill_in :problem_body, with: problem.body

    click_button 'Create Problem'
  end
end