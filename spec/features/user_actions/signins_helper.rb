def sign_up(user)
  visit '/users/sign_up'

  within '#new_user' do 
    fill_in :user_username, with: user.username
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password

    click_button 'Sign up'
  end
end

def sign_in(user)
  visit '/users/sign_in'
  
  within '#new_user' do 
    fill_in :user_login, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Sign in'
  end
end

def sign_out
  page.driver.submit :delete, '/users/sign_out', {}
end

def signed_in?
  has_content?('Logout')
end