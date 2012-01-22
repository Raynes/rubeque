When /^I go to the home page$/ do
  visit "/"
end

Then /^I should be on the homepage$/ do
  current_path.should == root_path
end

Then /^I should see an? (success|error) message$/ do |type|
  div_class = type == "success" ? "notice" : "alert"
  within "div#flash" do
    page.all("div##{div_class}").count.should >= 1
  end
end

Then /^I should see some error messages$/ do
  page.all("div#error_explanation").count.should == 1
end
