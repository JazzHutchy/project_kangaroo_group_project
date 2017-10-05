# We are building a program/app to help a group of people make a decision

# Process:

# Individuals contribute their ideas through free-form text:
# Specify the number of people involved
# Requests user input for each person
# Run a loop for every user to provide input

# The program tallies the votes on each idea:
# Ruby gem for voting (preferential gem)
# Assume that the votes will be entered into an array or hash (unless the gem works differently)
# Going to use ruby gem 'sortable'

# If there is a clear majority, then program chooses the popular idea

# If there is a tie between 2 or more ideas, then revote between the 2+ ideas that were popular

# If there is a second tie, then system randomly picks the idea

#=======================================================================

#idea = gets.idea

=begin
The process:
the program collects a pool of ideas from each user
each user then gets to vote in preference of 1, 2, 3, 4, etc on what their preferred option is
add the sum totals of each idea that was voted for
the lowest total number will be the selected as the final result: (i.e if a=5, b=9 & c=3, then c wins)

In the event of a tie:
if there is a tie in the final score (i.e. a=5 & b=5), then the program needs to take the ideas in question and run a random number generator against the ideas in question, the higher number wins 

After a winner is decided:
the program displays a confirmation message about the idea that won (maybe include victory gif/picture)
=end



#loop.do
 #use gem to sort 
 #the program sort numerically based on preferences
 #
 #takes the no.1 preferred idea and ranks it at the top followed by no.2, no.3, etc
 #
 #take the vote objects and sort and rank them by preference numbers

#========================================================================

######Code######

require 'naturally'

class Person # Need as many people as there are idea creators/voters
    
    attr_accessor :name

    def initialize(name, idea)
        @name = name
        # @people_array = []
        @idea = idea
        # @ideas = ideas
    end

    # def add_person(name) # Add people to the pool of users
    #     @name = name
    #     # @people << name
    # end
end


class Idea # Created by each person during input phase
    
    attr_accessor :suggestion

    def initialize
        @idea_array = []
    end
    
    def add_idea(suggestion) #Add idea to pool of ideas
        @suggestion = suggestion
        @idea_array << suggestion
    end
end

class Vote # Each person casts a vote on each idea created (sortable gem)
    
    attr_accessor :vote

    def initialize
        @vote_array = []
    end

    def add_vote(vote) # Each person takes a preference vote
        @vote = vote
        @vote_array << vote
    end

    def sort_vote # Votes are organised
        #naturally.sort []
    end
end

#the program determines how many people there are, their names and collects an idea from each user

puts 'How many people are making a decision?:'


@people = gets.strip
puts "#{@people} people are making a decision"


# #loop.do
# puts 'Person #, please enter your name:'

# begin
#     name = gets.strip
#     person1 = Person.new
#     person1.add_person(name)
#     puts "#{@person_name} is going to participate"
# end
# #end
people = []



bob = Person.new("Bob")
susan = Person.new("Susan")

def add_person(people)
    loop do 
        if main_menu
        puts "What's the person's name?"
        name = gets.strip 
        person = Person.new(name)
        Person.people << person
        people << person
    end
    return people
end


#method 
    # 1. does stuff
    # 2. does stuff brought in from the outer scope

#loop.do
puts "#{@person_name}, please share your idea:"

idea = Idea.new
idea.add_idea = gets.strip

puts '#{name}, would like to do #{idea}, is this correct?'
response = gets.strip

    # if response == yes
    # puts
    # elsif response == no
    # puts 
    # else
    # puts "Invalid response, please answer 'yes' or 'no'"
    # end

#end


# each user then gets to vote in preference of 1, 2, 3, 4, etc on what their preferred option is

#naturally.sort []


# add the sum totals of each idea that was voted for





# the lowest total number will be the selected as the final result: (i.e if a=5, b=9 & c=3, then c wins)





#In the event of a tie:
# if there is a tie in the final score (i.e. a=5 & b=5), then the program needs to take the ideas in question and run a random number generator against the ideas in question, the higher number wins 

#rand



# After a winner is decided:
# the program displays a confirmation message about the idea that won (maybe include victory gif/picture)

