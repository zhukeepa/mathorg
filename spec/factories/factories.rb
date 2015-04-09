FactoryGirl.define do
  factory :topic do 
    name "Topic name"
  end

  factory :problem do 
    description "Description"
    body "Problem body"
  end 

  factory :solution do 
    body "Solution body"
  end
end