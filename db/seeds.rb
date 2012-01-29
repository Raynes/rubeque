# puts 'EMPTY THE MONGODB DATABASE'
# Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

Problem.delete_all

######################################################################################################################

Problem.create!(#_id: 1,
                difficulty: 0,
                title: "The Truth",
                tag_list: "booleans",
                instructions: "Here's a hint: true equals true.",
                code: "assert_equal true, __",
                approved: true)

######################################################################################################################

Problem.create!(#_id: 1,
                difficulty: 0,
                title: "Hello World",
                instructions: "",
                tag_list: "strings",
                code: "assert_equal 'HELLO WORLD', 'hello world'.__",
                approved: true)

######################################################################################################################

Problem.create!(#_id: 2,
                difficulty: 0,
                title: "Nil Values",
                instructions: "Enter in a boolean value for what #nil? will return.",
                tag_list: "nil, booleans",
                code: "[0, '', 'chunky_bacon'].each { |v| assert_equal v.nil?, __ }",
                approved: true)

######################################################################################################################

Problem.create!(#_id: 3,
                difficulty: 0,
                title: "Reverse",
                instructions: "What happens when you apply reverse? Hint: don't forget to quote your strings!",
                tag_list: "strings",
                code: "assert_equal 'nocab yknuhc'.reverse, __",
                approved: true)

######################################################################################################################

Problem.create!(#_id: 3,
                difficulty: 0,
                title: "Maximum",
                instructions: "Find the max in a given set of numbers",
                tag_list: "numbers",
                approved: true,
                code: <<-code_block
def maximum(arr)
  __
end

assert_equal maximum([2, 42, 22, 02]), 42
assert_equal maximum([-2, 0, 33, 304, 2, -2]), 304
assert_equal maximum([1]), 1
code_block
                )

######################################################################################################################

Problem.create!(#_id: 4,
                difficulty: 0,
                title: "FizzBuzz",
                instructions: "If a number is divisible by 3, return \"Fizz\". If a number is divisible by 5, return \"Buzz\". If a number
                               is divisible by 3 and 5, return \"FizzBuzz\"",
                tag_list: "arithmetic, strings",
                approved: true,
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

######################################################################################################################

Problem.create!(#_id: 5,
                difficulty: 0,
                title: "Map",
                instructions: "How would you create an array that contains the squares of all elements in a range?",
                tag_list: "enumerables",
                code: "assert_equal [1, 4, 9, 16], (1..4).map { __ }",
                approved: true)

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "The Curious Case of the Missing Method",
                instructions: "Stop this code from throwing an exception. Hint: find the right seven-letter array
                  method: http://ruby-doc.org/core-1.9.3/Array.html",
                tag_list: "enumerables, arrays",
                code: "assert_equal [1, 4, nil, 9, 16, nil].__.inject(0) {|sum, number| sum + number}, 30",
                approved: true)

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "Home on the Range",
                instructions: "Fill in a range to complete the problem.",
                approved: true,
                tag_list: "ranges",
                code: <<-code_block
assert_equal (1..100).to_a[__].reduce(:+), 4494
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "Blackjack",
                instructions: "Write a method that takes any number of integers and returns true if they sum to 21, false otherwise. Hint: splat operator.",
                approved: true,
                tag_list: "arithmetic, splat operator",
                code: <<-code_block
__

assert_equal twenty_one?(3, 4, 5, 6, 3), true
assert_equal twenty_one?(3, 11, 10), false
assert_equal twenty_one?(10, 11), true
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "The Curious Case of the Missing Method Part 2",
                instructions: "Fill in the missing method. Hint: find the right six-letter enumerable method:
                  http://ruby-doc.org/core-1.9.3/Enumerable.html. There's also a four-letter alias for the method too.",
                tag_list: "enumerables",
                code: "assert_equal [1, 3, 7, 4, 9, 8].__(&:even?), 4",
                approved: true)

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "Injected and Rejected",
                instructions: "Write a method using inject and reject that takes an array of integers and gets the sum for all numbers greater than 50",
                approved: true,
                tag_list: "arithmetic, enumerables",
                code: <<-code_block
def sum_over_50(arr)
  arr.__
end

assert_equal sum_over_50([29, 52, 77, 102]), 231
assert_equal sum_over_50([5, 11, 50]), 0
assert_equal sum_over_50([4, 8, 15, 16, 23, 42]), 0
assert_equal sum_over_50([300, 22, 1, 55, 42]), 355
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "Baby Got Stacks",
                instructions: "Write a stack class. A stack is a data structure where elements are added at the end and removed from the end as well.",
                approved: true,
                tag_list: "classes, stacks",
                code: <<-code_block
class Stack
  __
end

stack = Stack.new([5, 6, 7, 8])

assert_equal stack.pop, 8
assert_equal stack.pop, 7
assert_equal stack.push([4, 2]), true
assert_equal stack.pop(2), [2, 4]
assert_equal stack.to_a, [5, 6]
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "Queue Continuum",
                instructions: "Write a queue class. A queue is a data structure where elements are added at the end and removed from the front.",
                approved: true,
                tag_list: "classes, queues",
                code: <<-code_block
class Queue
  __
end

queue = Queue.new([5, 6, 7, 8])

assert_equal queue.pop, 5
assert_equal queue.pop, 6
assert_equal queue.push([4, 2]), true
assert_equal queue.pop(2), [7, 8]
assert_equal queue.to_a, [4, 2]
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 0,
                title: "Temperature Robot",
                instructions: "Temperature bot is comfortable when it's room temperature (18-21C). Help him out by completing the method.",
                approved: true,
                tag_list: "case statements, ranges",
                code: <<-code_block
def temperature_bot(temp)
  # temperature bot is American but takes Celcius temperatures
  case temp
  when __
    "I like this temperature"
  else
    "This is uncomfortable for me"
  end
end

assert_equal temperature_bot(18), "I like this temperature"
assert_equal temperature_bot(21), "I like this temperature"
assert_equal temperature_bot(22), "This is uncomfortable for me"
assert_equal temperature_bot(-3), "This is uncomfortable for me"
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 1,
                title: "The Lambda Lambda Lambda Fraternity",
                instructions: "Write a proc or lambda that'll take one or two numbers and return true if one or both numbers are even.",
                approved: true,
                tag_list: "lambdas, procs, ruby 1.9",
                code: <<-code_block
even_check = __

assert_equal [[2, 4], [1, 2], [8, 12]].select{|arr| even_check.call(*arr)}, [[2, 4], [8, 12]]
assert_equal even_check.call(42), true
assert_equal [[2, 4], [2, 1], [8, 11]].select{|arr| even_check.call(*arr)}, [[2, 4]]
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 1,
                title: "Quelle Heure Est-Il?",
                instructions: "Write a function to parse some dates and return a standard format. Hint: the help page might be of use.",
                approved: true,
                tag_list: "dates, strings",
                code: <<-code_block
def pretty_date(date)
  __
end

assert_equal pretty_date("11-30-1835"), "Nov 30, 1835"
assert_equal pretty_date("July 20, 1933"), "Jul 20, 1933"
assert_equal pretty_date("1922-11-11"), "Nov 11, 1922"
assert_equal pretty_date("9/20/1978"), "Sep 20, 1978"
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 1,
                title: "Introduction to Regular Expressions",
                instructions: "Write a regular expression that will match emails in a string.",
                approved: true,
                tag_list: "strings, regular expressions",
                code: <<-code_block
assert_equal "john@mail.com to jane@mail.com".scan(/__/), ["john@mail.com", "jane@mail.com"]
assert_equal "why@ @chunkybacon.com why@chunkybacon.com".scan(/__/), ["why@chunkybacon.com"]
assert_equal "why @ @ why@chunkybacon".scan(/__/), []
code_block
               )

######################################################################################################################

Problem.create!(difficulty: 1,
                title: "Fixing Bad Code the Wrong Way",
                instructions: "Your coworker did a bad job defining a class. Fix it for him using #method_missing.",
                approved: true,
                tag_list: "method_missing, classes",
                code: <<-code_block
class Person
  def initialize(name, age, incoming_race)
    @name = name
    @age = age
    self.race = incoming_race
  end

  def nam
    @name.split.map(&:capitalize).join(" ")
  end

  def agE
    @age
  end

  def method_missing(m, *args)
    __
    else
      super
    end
  end
end

person = Person.new("kurt vonnegut", 89, "caucasian")

assert_equal person.name, "Kurt Vonnegut"
assert_equal person.race, "Caucasian"
assert_equal person.age, 89
code_block
                 )

######################################################################################################################

Problem.create!(#_id: 6,
                difficulty: 1,
                title: "Reverse Each Word",
                instructions: "Write a method that takes a sentence and returns it with each word reversed in place.",
                tag_list: "strings, enumerables",
                approved: true,
                code: <<-code_block
def reverse_each_word(sentence)
 __
end

assert_equal "olleH ,ereht dna woh era ?uoy", reverse_each_word("Hello there, and how are you?")
code_block
               )

######################################################################################################################

Problem.create!(#_id: 7,
                difficulty: 1,
                title: "Your Favorite and Mine, Fibonacci!",
                instructions: "Write a method that handles Fibonacci sequences. Have it return the nth item in the Fibonacci sequence.  
                  Hint: The first item in the sequence is 0.",
                approved: true,
                tag_list: "arithmetic",
                code: <<-code_block
def fibo_finder(n)
  __
end

assert_equal 0, fibo_finder(0)
assert_equal 1, fibo_finder(1)
assert_equal 3, fibo_finder(4)
assert_equal 13, fibo_finder(7)
assert_equal 55, fibo_finder(10)
code_block
                 )

######################################################################################################################

Problem.create!(difficulty: 1,
                title: "Unique By",
                instructions: "Write a method #unique_by that takes an enumerable and a block and returns a unique array of elements 
                  based on what's returned by a block. When elements match, keep the first.",
                approved: true,
                tag_list: "enumerables",
                excluded_methods: ["uniq_by"],
                code: <<-code_block
__

class Programmer
  def initialize(name)
    @name = name
  end
  attr_accessor :name
end

programmers = [Programmer.new("David"), Programmer.new("Joe"), Programmer.new("Michael"), 
  Programmer.new("Kamal"), Programmer.new("david")]

assert_equal unique_by(programmers) {|u| u.name.downcase}, programmers[0..3]
assert_equal unique_by([1.1, 2.1, 1.5, 3.1, 6, 2]) {|x| x.to_i}, [1.1, 2.1, 3.1, 6]
assert_equal unique_by([3, 6, 9, 2, 4, 8, 33, 1]) {|i| i.remainder(3)}, [3, 2, 4]
code_block
                 )


######################################################################################################################

Problem.create!(difficulty: 1,
                title: "A Man, A Plan, A Canal--Panama!",
                instructions: "A palindrome is a string that is written the same forward as it is in reverse. Write a method to 
                  return the longest palindrome in a given string",
                approved: true,
                tag_list: "strings",
                code: <<-code_block
__

assert_equal longest_palindrome("xyzzy"), "yzzy"
assert_equal longest_palindrome("afbbbfjdjklgdfdhfdkjfffhhfffjkdfhdhkyejejfjkd"), "dhfdkjfffhhfffjkdfhd"
assert_equal longest_palindrome("bartarcarracecarbartar"), "racecar"
assert_equal longest_palindrome("3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982"), "46264"
code_block
                 )

######################################################################################################################

Problem.create!(#_id: 8,
               difficulty: 2,
               title: "Hello? Yes, This Is Dog",
               instructions: 'Write a method to validate some strings that could potentially represent phone numbers. See if you can do it with a
                single regular expression.',
               approved: true,
               tag_list: "strings, regular expressions",
               code: <<-eos
def phone_number?(num)
  __
end

assert_equal phone_number?("5555555555"), true
assert_equal phone_number?("555555555"), false # missing a digit
assert_equal phone_number?("555-5555"), true
assert_equal phone_number?("(555) 555-5555"), true
assert_equal phone_number?("(555) 555-555"), false
assert_equal phone_number?("555-555-555"), true
assert_equal phone_number?("(555-555-555"), false
eos
               )

######################################################################################################################

Problem.create!(#_id: 8,
               difficulty: 2,
               title: "Prime Factors",
               instructions: 'Find all of the prime factors for a given number',
               approved: true,
               tag_list: "arithmetic",
               code: <<-eos
def prime_factors(num)
  __
end

assert_equal prime_factors(102), [2, 3, 17]
assert_equal prime_factors(896680), [2, 5, 29, 773]
assert_equal prime_factors(42), [2, 3, 7]
eos
               )

######################################################################################################################

Problem.create!(#_id: 8,
               difficulty: 2,
               title: "Pigs Fly;  Wait, No They Don't.",
               instructions: 'Can you make a method return a differect value after a "return" is called?',
               approved: true,
               tag_list: "exceptions",
               code: <<-eos
def do_pigs_fly?
  return true
  __
end

assert_equal do_pigs_fly?, false
               eos
               )

######################################################################################################################

Problem.create!(#_id: 8,
               difficulty: 2,
               title: "Regular Expressions Revisted",
               instructions: 'Parse this list into a two dimensional array where the inner array has a number and name.',
               approved: true,
               tag_list: "regular expressions, strings, arrays",
               code: <<-eos
doctor_map = "One: William Hartnell
Two:Patrick Troughton
Three:: Jon Pertwee
Four: Tom Baker (longest run)
5: Peter Davison
six: Colin Baker
Seven:   Sylvester McCoy
Eight Paul McGann
Nine: Christopher Eccleston *series reboot*
Ten: David Tennant <- personal fav
Eleven: Matthew Robert Smith - the current doctor"

doctors = doctor_map.scan(/__/)

assert_equal doctors[0][1], "William Hartnell"
assert_equal doctors[4][1], "Peter Davison"
assert_equal doctors[3][1], "Tom Baker"
assert_equal doctors[4][0], "5"
assert_equal doctors[7][0], "Eight"
assert_equal doctors[9][1], "David Tennant"
assert_equal doctors[10][1], "Matthew Robert Smith"
eos
               )

######################################################################################################################

Problem.create!(#_id: 9,
                  difficulty: 2,
                  title: "Happy Numbers",
                  instructions: "Happy numbers are positive integers that follow a particular formula: take each individual digit,
                                 square it, and then sum the squares to get a new number. Repeat with the new number and eventually,
                                 you might get to a number whose squared sum is 1. This is a happy number. An unhappy number (or
                                 sad number) is one that loops endlessly. Write a function that determines if a number is happy or not.",
                  approved: true,
                  tag_list: "arithmetic",
                  code: <<-code_block
 __

 assert_equal happy_number?(7), true
 assert_equal happy_number?(986543210), true
 assert_equal happy_number?(2), false
 assert_equal happy_number?(3), false
 code_block
                 )

######################################################################################################################

Problem.create!(difficulty: 3,
                title: "Mason's Spades Problem",
                instructions: %Q{In the game of spades, one player deals all 52 cards to four players so that each has 13 cards in his or her hand.
                  The cards are shuffled prior to dealing, so that the distribution is random. The first play of the game is for each player to
                  lay down his or her lowest club (where clubs are ordered from low to high as: 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace).
                  <br/><br/>Once all four lowest clubs are on the table, the player who threw the highest of those four cards wins the cards (in other words,
                  he or she wins the "trick"). If a player has no clubs, he or she must play a heart or a diamond, and that card has no chance
                  of winning the trick. If a player has no clubs, no hearts, and no diamonds, then the player must play a spade, and will be
                  guaranteed to win the trick.<br/><br/>Write a class that has a method #winning_probablity that will return the probability of
                  a given card. Cards will be supplied in the format "2H" where two is the numeric value and H stands for hearts. Face value cards
                  will be of the format "AC" for ace of clubs, or "KS" for king of spades, etc. Results must contain two significant digits
                  after the decimal.},
               tag_list: "probability, arithmetic",
               approved: true,
               code: <<-code_block
__

assert_equal first_trick.winning_probability("2C"), 0.00
assert_equal first_trick.winning_probability("10C"), 9.08
assert_equal first_trick.winning_probability("KC"), 3.50
assert_equal first_trick.winning_probability("9C"), 11.87
assert_equal first_trick.winning_probability("2S"), 0.00
assert_equal first_trick.winning_probability("AH"), 0.00
code_block
)
