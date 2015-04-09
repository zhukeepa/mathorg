require 'rails_helper'
require_relative 'features_helper'

RSpec.feature "Signups, sign-ins, and sign-outs", type: :feature do
  let(:problem) { Problem.create!(description: "description", body: "body fat", topics_string: "Topic 1") }
  let(:user) { User.new(email: "example@example.com") }

  scenario "A visitor registers an account" do
    register(user.email, "password")
    expect(current_path).to eq '/'
    # some other test to ensure that you're logged in?? 
  end

  scenario "A user registers, signs out, and signs in" do 
    register(user.email, "password")
    expect(current_path).to eq '/'
    sign_out 
    sign_in(user.email, "password")
  end
end
