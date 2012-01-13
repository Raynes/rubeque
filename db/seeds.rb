# puts 'EMPTY THE MONGODB DATABASE'
# Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

Problem.delete_all

Problem.create!(_id: 1,
                difficulty: "easy",
                title: "Hello World",
                instructions: "",
                code: "assert_equal 'hello world'.__, 'HELLO WORLD'")

Problem.create!(_id: 2,
                difficulty: "easy",
                title: "Nil Values",
                instructions: "Enter in a boolean value for what #nil? will return.",
                code: "[0, '', 'chunky_bacon'].each { |v| assert_equal v.nil?, __ }")

Problem.create!(_id: 3,
                difficulty: "easy",
                title: "Reverse",
                instructions: "What happens when you apply reverse? Hint: don't forget to quote your strings!",
                code: "assert_equal 'nocab yknuhc'.reverse, __")

Problem.create!(_id: 4,
                difficulty: "easy",
                title: "FizzBuzz",
                instructions: "If a number is divisible by 3, return \"Fizz\". If a number is divisible by 5, return \"Buzz\". If a number
                               is divisible by 3 and 5, return \"FizzBuzz\"",
                code: <<-eos
def fizzbuzz(x)
  __
end

assert_equal fizzbuzz(3), "Fizz"
assert_equal fizzbuzz(50), "Buzz"
assert_equal fizzbuzz(15), "FizzBuzz"
assert_equal fizzbuzz(5175), "FizzBuzz"
eos
               )

User.delete_all
User.create!(:username => 'admin',
             :email => 'kbennoune@gmail.com',
             :admin => true,
             :password => 'Secret1234')
