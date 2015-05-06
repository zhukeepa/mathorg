def add_problem(problem)
  visit '/problems/new'

  within '#new_problem' do 
    fill_in :problem_description, with: problem.description
    fill_in :problem_body, with: problem.body

    click_button 'Create Problem'
  end
end

def problem_id_from_page
  current_path.scan(/\/problems\/(\d*)\Z/)[0][0]
end

def merge_with(original_id)
  expect(current_path).to match /\/problems\/\d*\Z/
  click_link 'Repeated problem?'
  within '.merge' do 
    fill_in :problem_merge_original_problem_id, with: original_id
    click_button 'Merge'
  end
end