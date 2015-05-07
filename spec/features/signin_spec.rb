require 'rails_helper'
require_relative 'user_actions/signins_helper'
require_relative 'user_actions/problems_helper'

RSpec.feature "Signins", type: :feature do
  let(:user) { FactoryGirl.build(:user) }

  scenario "A visitor registers an account" do
    sign_up(user)
    expect(signed_in?).to be true
  end

  scenario "A visitor registers, signs out, and signs in" do 
    sign_up(user)
    sign_out 
    sign_in(user)
  end

  scenario "A visitor lands on a page, registers, logs out, and signs in again" do 
    problem = FactoryGirl.create(:problem)
    visit "/problems/#{problem.id}"

    sign_up(user)
    expect(current_path).to eq "/problems/#{problem.id}"

    sign_out
    expect(current_path).to eq "/problems/#{problem.id}"

    sign_in(user)
    expect(current_path).to eq "/problems/#{problem.id}"
  end
end
