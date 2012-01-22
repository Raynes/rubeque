require 'ruby-debug'

Before('@javascript') do
  @javascript = true
end

# seed the database
Before do
  seed_file = File.join(Rails.root, "db", "seeds.rb")
  load(seed_file)
end
