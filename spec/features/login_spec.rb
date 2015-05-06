require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'

RSpec.feature "Logins", type: :feature do
  let(:problem) { FactoryGirl.build(:problem) }
  let(:user) { User.new(username: "Alex", email: "example@example.com") }

  scenario "A visitor registers an account" do
    log_in_with(user.username, user.email, "password")
    expect(signed_in?).to be true
  end

  scenario "A user registers, signs out, and signs in", js: true do 
    # if user is already in db, delete him and start anew. 
    User.find_by_username(user.username).destroy if User.find_by_username(user.username)
     
    sign_up(user.username, user.email, "password")
    sign_out 
    #sign_in(user.email, "password")
  end
end
