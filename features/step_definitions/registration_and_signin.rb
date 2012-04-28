Given /^I have signed in$/ do
  Given "I am on the signin page"
  When "I fill in the login form"
  When "I click the Sign in button"
end

When /^I fill in the login form$/ do 
  fill_in('Email', :with => 'gthorisson@gmail.com')
  fill_in('Password', :with => 'ffffff')
end

When /^I click the Sign in button$/ do
  click_button 'Sign in'
end


When /^I fill in the registration form$/ do 
  fill_in('Email', :with => 'gthorisson@gmail.com')
  fill_in('Password', :with => 'ffffff')
  fill_in('Password confirmation', :with => 'ffffff')
end

When /^click the Sign up button$/ do
  click_button 'Sign up'
end

