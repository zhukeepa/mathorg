FactoryGirl.define do
  factory :topic do 
    name "Topic name"
  end

  factory :problem do 
    body "Problem body"
  end 

  factory :explanation do 
    body "Explanaton body" 
  end

  factory :solution do 
    body "Solution body"
  end
end