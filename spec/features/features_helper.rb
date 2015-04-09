def register(email, password)
  visit '/users/sign_up'

  within '#new_user' do 
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_button 'Sign up'
  end
end

def sign_in(email, password)
  visit '/users/sign_in'
    within '#new_user' do 
    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_button 'Sign in'
  end

  expect(current_path).to eq '/'
end

def sign_out
  # visit '/users/sign_out'
  page.driver.submit :delete, '/users/sign_out', {}
  expect(current_path).to eq '/'
end