# assumes you are on a problem page
def add_solution(solution)
  click_link 'Add solution'

  within '#new_solution' do 
    fill_in :solution_body, with: solution.body
    fill_in :solution_hints_string, with: solution.hints_string
    fill_in :solution_topics_string, with: solution.topics_string

    click_button 'Create Solution'
  end
end