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
                :code => "[0, '', 'chunky_bacon'].each { |v| assert_equal v.nil?, __ }")

Problem.create!(:difficulty => "easy",
                :title => "Reverse",
                :instructions => "What happens when you apply reverse? Hint: don't forget to quote your strings!",
                :code => "assert_equal 'nocab yknuhc'.reverse, __")
