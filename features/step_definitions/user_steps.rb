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
end

Then /^there should be a new user account$/ do
  User.count.should eql(@user_count + 1)
end
