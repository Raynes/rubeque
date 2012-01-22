When /^I dump the page$/ do
  puts response.body
end

Then /^fail now$/ do
  :need_to_fail.should == :proceed
end

Given /^(?:we |I |)mark the log(?: with|)\s*(.*)$/ do |message|
  Rails.logger.debug "*"*40
  Rails.logger.debug(message) if message.present?
end

def trigger_debugger
  if require 'ruby-debug'
     Debugger.start
     Debugger.settings[:autoeval] = 1
     Debugger.settings[:autolist] = 1
   end
   debugger
end

When 'I debug' do
  trigger_debugger
  true
end

Then /^inspect the (.+)$/ do |what|
  puts "The #{what} os #{instance_variable_get(:"@#{what}").inspect}"
end


Then /(.*) or I debug$/ do |test|
  begin
    Then test
  rescue
    Then 'I debug'
  end
end

When /^(?:we |I |)pause\s*(.*)$/ do |prompt|
  puts "pausing #{prompt}"
  STDIN.gets
end

When /^(?:we |I |)sleep (\d+) seconds?$/ do |seconds|
  sleep(seconds.to_i)
end

Then /^show me the page and pause\s*(.*)$/ do |prompt|
  save_and_open_page unless @javascript
  When "I pause #{prompt}"
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^show me the page and( let me|) debug/ do |polite|
  Then %{show me the page}
  trigger_debugger
end

Then /^I eval: (.*)$/ do |string|
  ret = eval(string)
  if ret.is_a? String
    puts ret
  elsif ret.respond_to? :map
    puts ret.map(&:inspect).join("\n")
  else
    p ret
  end
end

Then /^is pending "([^\"]*)"$/ do |msg|
  pending(msg)
end
