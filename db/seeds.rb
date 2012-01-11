# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# puts 'EMPTY THE MONGODB DATABASE'
# Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

Problem.delete_all

Problem.create!(:difficulty => "easy",
                :title => "Hello World",
                :instructions => "",
                :code => "assert_equal 'hello world'.__, 'HELLO WORLD'")

Problem.create!(:difficulty => "easy",
                :title => "Nil Values",
                :instructions => "Enter in a boolean value for what #nil? will return.",
                :code => "[0, '', 'chunky_bacon'].each do { |v| assert_equal v.nil?, __ }")
