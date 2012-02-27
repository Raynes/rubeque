When /^I go to register$/ do
  @user_count = User.count
  click_link "Register"
end

When /^I fill in a username$/ do
  fill_in "Username", with: "test1234"
end

When /^I fill in an email address$/ do
  fill_in "Email", with: "test1234@aol.com"
end

When /^I fill in a bad email address$/ do
  fill_in "Email", with: "test1234"
end

When /^I fill in a password with confirmation$/ do
  fill_in "Password", with: "secret1234"
  fill_in "Password confirmation", with: "secret1234"
end

When /^I click signup$/ do
  click_button "Sign up"
  @current_user = User.last
end

Then /^there should be a new user account$/ do
  User.count.should eql(@user_count + 1)
end

Given /^I am logged in as an? (user|admin) named "([^"]*)"$/ do |user_type, username|
  step %Q{there is a #{user_type} account named "#{username}"}
  step %Q{I go to the login page}
  step %Q{I fill in my username}
  step %Q{I fill in my password}
  step %Q{I press the login button}
  @current_user = User.first(conditions: {username: username})
end

Given /^there is an? (admin|user) account named "([^"]*)"$/ do |user_type, username|
  admin = user_type == "admin"
  @current_user = User.create!(username: username,
                               email: "#{username}@aol.com",
                               password: "secret1234",
                               password_confirmation: "secret1234",
                               admin: admin
                              )
end

When /^I go to the login page$/ do
  visit new_user_session_path
end

When /^I fill in my username$/ do
  fill_in "Username", with: @current_user.username
end

When /^I fill in my password$/ do
  fill_in "Password", with: "secret1234"
end

When /^I press the login button$/ do
  click_button "Sign in"
end

Then /^I should see my username on the page$/ do
  page.find("span.username").text.strip.should eql(@current_user.username)
end
