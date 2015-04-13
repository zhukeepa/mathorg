FactoryGirl.define do
  factory :topic do 
    name "Topic name"
  end

  factory :problem do 
    description "Description"
    body "Problem body"
  end 

  factory :problem_edited, class: 'Problem' do 
    description "new description"
    body "edited body"
  end

  factory :solution do 
    body "Solution body"
    hints = ["Hint 1", "Hint 2", "Hint 3"]
  end

  factory :solution_edited, class: 'Solution' do 
    body "Edited solution body"
    hints = ["Hint 3", "Hint 2", "Hint 1"]
  end

  factory :explanation do 
    title "Explanation title"
    description "Here is a description of an explanation"
    body RichText.new(text: "Hello")
  end

  factory :explanation_edited, class: 'Explanation' do 
    title "Explanation title edited!!1!"
    description "Here is another description of an explanation"
    body RichText.new(text: "GOODBYE FOREVER")
  end

  factory :problem_set do 
    name "Problem set name"
  end
end