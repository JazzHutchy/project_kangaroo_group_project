# y = "Milk and Honey"
require_relative 'person'
def say(word)
    new_word = word + '!'
    return new_word
end

def ice_cream_menu
    choice = gets.chomp
    puts "Pick a choice"
    puts '1. eat ice cream'
    puts '2. trash ice cream'
    puts '3. give ice cream to dog'
    puts '4. give ice cream back and ask for refund'
end

def print_ideas
#### CODE HERE
end

def vote_idea
    ## CODE HERE
    #1. print_ideas
    #3. match the chosen idea to vote on with the person's idea
    #2. vote on an idea (add a vote number to that idea)
end 

def find_winner
    # 1. have list of people
    # 2. each person has a idea
    # 3. each person's idea has a vote number on that idea
    ## GIVE ME BACK THE WINNER OR RETURN ME WINNER OR PRINT ME THE WINNER
end



# def addFive(number)
#     calc = number + 5
#     return calc
# end

# # say is going to take ANY word,
# # call it word, and then create a new word, 
# # take the old word and combine it with !


x = say(y) #say(y) #
# z = addFive(5)

# people = []

# def add_person(arr, name)
#     arr << name
#     return arr
# end

# Person.new #just John
#     #people, just john's people array
# Person.new #just Sally
#     #people, just Sally's people array
# Person.new #just Peter
#     #people, just Peter's people array

people = []

people << Person.new("John")
people << Person.new("Sally")
people << Person.new("Peter")


people.each do |person|
        puts person.name
end