require 'tty-prompt'
require 'tty-spinner'

class Option
    attr_accessor :name, :vote

    def initialize(name)
        @name = name
        @vote = 0
    end

    def add_to_vote
        @vote += 1
    end

    def add_preference_value(number)
        @vote += number
    end
end

class User
  attr_accessor :user_name, :votes

  def initialize(user_name)
    @user_name = user_name
    @votes = []
  end
end

list = []
user_list = []

# 'Starts the program'
def generator_check(list, user_list)
    loop do
        system 'clear'
        # Create a new prompt
        first_question = TTY::Prompt.new
        # Prompt for input and store
        yesno = first_question.select(("Are you having trouble deciding on something? "), %w(Yes No))
        case yesno
            when "Yes"
                break # Break out of the loop if user input 'yes'
            else 
                spinner = TTY::Spinner.new #Creates a new spinner
                puts 'Terminating program...'
                spinner.auto_spin # Automatic animation with default interval
                sleep(2) # Perform task
                spinner.stop # Stop animation
                abort() # Stops the whole program with a comment
        end
    end
    print "\nLet's create a list of options. "
    sleep 1
    build_list(list, user_list) # Call list builder method
end

# List building method
def build_list(list, user_list)
    loop do # Loop through the list building method.
      # If there are less than two options entered in the list, do not allow the user to continue
        if list.length < 2 
            system 'clear'
            print "Please enter an option: "
            # Get user input and set it as variable
            choice = gets.strip 
            # If 'choice' is an enter key, inform the user that they must enter at least two options
            if choice == "" # Blank check because of strip
                print "\nYou must enter at least two options. "
                sleep 1
            else
              # Convert user input into an Option instance
                list << Option.new(choice) 
            end
            # If there are at least two options in the array, allow the user to either add more options or proceed
        else 
            system 'clear'
            print "Please enter an option or press the Enter key to proceed: "
            choice = gets.strip # Get user input and set it as variable
            if choice == "" # Check user input and if it is an enter key, break out from the loop 
                break # Gets out of the loop
            else
                list << Option.new(choice) # Convert user input into an Option instance
                puts Option.name 
            end
        end
    end
    vote_or_random(list, user_list)
end

# Asks if people want to vote on the list of options or have the app randomly pick a winner.
def vote_or_random (list, user_list)
    system 'clear'
    # Create a new prompt
    voterandom = TTY::Prompt.new 
    selection = voterandom.select("Would you like to vote or have the program randomly pick an option for you? ", %w(Vote Random))
    # Check which method to run based on valid user input
    if selection == "Vote" 
        list_of_users(list, user_list)
    else
        random_winner(list)
    end
end

# Establish users
def list_of_users(list, user_list)
    index = 0
    loop do
        number_of_users = TTY::Prompt.new 
        how_many = number_of_users.ask("How many people want to vote? ")
        number = how_many.to_i
        puts " "
        # Validate the entry
        if number > 0
            while index < number do 
                puts "Create user account no.#{index + 1}"
                puts "Enter your user name: "
                user_name = gets.chomp
                puts " "
                new_user = User.new(user_name)
                user_list << new_user
                index += 1
            end
            break
        else
            puts "That is not a valid entry. Please enter a number."
        end
    end 
    collect_votes(list, user_list)
end 

# Collect votes method
def collect_votes(list, user_list)
    # Loop over each user in the list
    user_list.each do |user|
        system 'clear'
        puts "Hi #{user.user_name}, it's your turn to vote."
        # Keep track of how many times they have voted
        vote_number = 1
        # Sets the variable outside the loop so it is accessible by the method
        check_vote = nil
        # Create an array of option names to use in the prompt
        list_of_options = []
        list.each do |item|
            list_of_options << item.name 
        end 
        
        loop do
            # Removes already voted for options from the list when users making additional votes
            list_of_options.delete(check_vote)            
            # Checks to see if there are any options left
            if list_of_options.length < 1
                puts "You've already voted for everything!"
                puts " "
                break
            end
            # Create new prompt
            voting_question = TTY::Prompt.new
            check_vote = voting_question.select("Please vote for your preferred option: ", *list_of_options)
            # Compare the vote to the list of options and add a vote to the relevant option
            list.each do |item|
                if check_vote == item.name
                    item.add_to_vote
                end
            end
            # Store each vote in an array belonging to the user object
            user.votes << check_vote
            # Create a prompt for re-voting
            more_voting = TTY::Prompt.new 
            # Let the user know how many times they have voted. 
            if vote_number == 1
                number = "once"
            elsif vote_number ==2
                number = "twice"
            else 
                number = "#{vote_number} times"
            end
            user_input = more_voting.select("You've voted #{number}. Do you want to vote again?", %w(yes no))
            puts " "
            if user_input == "no"
                break  
            end 
            vote_number += 1
        end
    end
    select_winner(list, user_list) # Call select_winner method
end

# Decides which option wins
def select_winner(list, user_list)
    find_highest_votes(list) # Rebuilds the array so that it only has the option(s) with highest votes
    if list.length > 1
        check_revote(list, user_list)
    else
        random_winner(list)
    end
end

# Deletes all options which are not at least equal to first item on the array which will have the highest votes
def find_highest_votes(list)
    sort_votes(list) # Sorts array of options based on votes in descending order
    loop do
        first = list[0] # Pulls the first option out of the array
        last = list[-1] # Pulls the last option out of the array
        if first.vote != last.vote # Compares the first option and the last option based on their votes
            list.delete_at(-1) # If they are not equal delete the last option as it does not tie with the winner
        else 
            break # Break out of the loop if the first option and the last option have the same number of votes, if in a single item array index 0 is the same as index -1 so it will always return true
        end
    end
end

# Exact mirror of the vote_or_random method it just has a different question
def check_revote (list, user_list)
    system 'clear'
    check_revote = TTY::Prompt.new 
    revotewinner = check_revote.select("There are multiple winners, would you like to revote with the tied options or have the program randomly pick an option for you?", %w(Revote Random))
    if revotewinner == "Revote" 
        collect_votes(list, user_list)
    else
        random_winner(list)
    end
end

# Randomly selects a winner from the list
def random_winner(list)
    winner = list.sample # Randomly picks a winner from the array, and also works if there is only a single object in the array (Possibly have a method where the user can choose to re-vote between winning options?)
    system 'clear'
    spinner = TTY::Spinner.new(format: :arrow_pulse)
    puts "And the winner is ..." 
    spinner.auto_spin # Automatic animation with default interval
    sleep(1) # Perform task
    spinner.stop("#{winner.name.capitalize}!") # Stop animation
    puts " "
end

# Sorts the list of options
def sort_votes(list)
    list.sort_by! { |option| option.vote } # Sorts the list by the vote attribute of each option
    list.reverse! # Reverses the list because it naturally sorts ascending order
end

generator_check(list, user_list)