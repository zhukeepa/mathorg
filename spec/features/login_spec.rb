require 'rails_helper'
require_relative 'user_actions/signins_helper'

RSpec.feature "Logins", type: :feature do
  let(:problem) { Problem.create!(description: "description", body: "body fat", topics_string: "Topic 1") }
  let(:user) { User.new(email: "example@example.com") }

  scenario "A visitor registers an account" do
    sign_up(user.email, "password")
    expect(signed_in?).to be true
  end

  scenario "A user registers, signs out, and signs in" do 
    sign_up(user.email, "password")
    sign_out 
    sign_in(user.email, "password")
  end
end
