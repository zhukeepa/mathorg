def sign_up(username, email, password)
  visit '/users/sign_up'

  within '#new_user' do 
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_button 'Sign up'
  end
end

def sign_in(email, password)
  visit '/users/sign_in'
  
  within '#new_user' do 
    fill_in :user_login, with: email
    fill_in :user_password, with: password
    click_button 'Sign in'
  end
end

def sign_out
  page.driver.submit :delete, '/users/sign_out', {}
end

def signed_in?
  has_content?('Logout')
end

def log_in_with(username, email, password)
  sign_up(username, email, password)
  if !signed_in? 
    sign_in(email, password)
  end
end