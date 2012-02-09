When /^I go to the problem page for "([^"]*)"$/ do |title|
  @problem = Problem.where(title: title).first
  @solution_count = Solution.count
  visit problem_path(@problem)
end

When /^I fill in "([^"]*)" for the solution code$/ do |answer|
  if @javascript
    page.find("#editor textarea").set(answer)
  else
    # there is no ace.js box
    page.find("#solution_code").set(answer)
  end
end

When /^I submit the solution$/ do
  click_button "Submit"
end

When /^I reset the solution code$/ do
  visit problem_path(@problem) # TODO: find a better way to clear the ace.js box
end

Then /^there should (be|not be) a new solution in the database$/ do |new_solution|
  if new_solution =~ /^not/
    Solution.count.should eql(@solution_count)
  else
    Solution.count.should eql(@solution_count + 1)
  end
end

Then /^I should see a "([^"]*)" error message$/ do |message|
  page.find("#error_explanation li").text.should include(message)
end
