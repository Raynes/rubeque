When /I go to the problems page/ do
  visit problems_path
  #debugger
  1
end

Given /^the following problems:$/ do |table|
  Problem.delete_all
  table.hashes.each do |hash|
    problem = Problem.new(hash)
    problem.save :validate => false
  end
end

When /^I sort by "([^"]*)"$/ do |column|
  page.find(:xpath, "//table[@id='problems']//th[contains(., '#{column}')]").click
end

Then /^I should see problems in this order:$/ do |table|
  expected_order = table.raw
  actual_order = []

  rows = page.all('tr.problem')
  rows.each do |row|
    # We just want the first and third td in our cells array
    cells = row.all('td').select.with_index { |element, index| [0, 2].include? index }
    actual_order << cells.map { |cell| cell.text }
  end

  actual_order.should == expected_order
end
