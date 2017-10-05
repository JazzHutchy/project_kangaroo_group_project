require 'testing_environment'

# require_relative 'options'
# require 'rainbow'

list = []
index = 1

# List building method
def build_list(list, index)
    loop do # Loop through the list building method.
        if list.length < 2 # If there are less than two options entered in the list, do not allow the user to continue
            system 'clear'
            print "Please enter an option: "
            user_input = gets.strip # Get user input and set it as variable
            if user_input == "" # Check user input and if it is an enter key, inform the user that they must enter at least two options
                print "\nYou must enter at least two options. "
                sleep 2
            else
                list << Option.new(user_input) # Convert user input into an Option instance
            end
        else 
            system 'clear'
            print "Please enter an option or press the Enter key to proceed: "
            user_input = gets.strip # Get user input and set it as variable
            if user_input == "" # Check user input and if it is an enter key, break out from the loop 
                break # Gets out of the loop
            else
                list << Option.new(user_input) # Convert user input into an Option instance
            end
        end
    end
    vote_or_random(list, index)
end


# 'Starts the program'
def generator_check(list, index)
    loop do
        system 'clear'
        print "Are you having trouble deciding on something? "
        user_input = gets.strip.downcase # Get user input and set it to variable
        case user_input
            when "yes"    
                break # Break out of the loop if user input 'yes'
            when "no"
                abort("Terminating program...") # Stops the whole program with a comment
            else
                print "\nThat is not a valid response, please enter yes or no. " # Displays to user what is a valid option 
                sleep 2
        end
    end
    print "\nLet's create a list of options. "
    sleep 1
    build_list(list, index) # Call list builder method
end

# Asks if people want to vote on the list of options or have the app randomly pick a winner.
def vote_or_random (list, index)
    user_input = nil # Set variable outside the loop so it is accessible within the method
    loop do
        system 'clear'
        print "Would you like to vote or have the program randomly pick an option for you?\n\n1. Vote\n2. Random\n\nPlease enter an option: "
        user_input = gets.to_i # Converts user input into an Integer, if user input is not a number or does not contain a number at the start it will return 0
        if user_input == 1 || user_input == 2 # Check if the user input a valid option
            break # If the user selected an valid option break out of the loop
        else
            print "\nThat is not a valid option please enter 1 to vote or 2 to randomly pick an option. "
            sleep 2
        end
    end
    if user_input == 1 # Check which method to run based on valid user input
        collect_votes(list, index)
    else
        select_winner(list)
    end
end

# Print a list of all available options for the user
def print_list(list, index) 
    system 'clear'
    list.each do |option| # Loop through each item in the list array
        puts "#{index}. #{option.name}"
        index += 1
    end
end

# Collect votes method
def collect_votes(list, index)
    loop do
        print_list(list, index) # Calls the print_list method, the method exists outside the loop so that the correct number is displayed each iteration of the loop otherwise the index will continually increase within the loop until it is over.
        print "\nPlease vote for your preferred option or press the Enter key if you are done voting: "
        user_input = gets # Grabs input from user
        if user_input == "\n" # Checks if user_input is an empty line
            break # If the user_input is an empty line break out of loop
        else
            check_vote = user_input.to_i # Converts user_input into an Integer, if user input is not a number or does not contain a number at the start it will return 0
            if (check_vote > 0 && check_vote < list.length + 1) # Checks if the number entered is greater than 0 and within the length of array
                option = list[(check_vote - 1)] # Use 'check_vote' variable and correct it to access the correct option from list array
                option.add_to_vote # Call add_a_vote method to the option
            else
                print "\nThat is not a valid option, please input a number listed on the screen. "
                sleep 1
            end
        end
    end
    select_winner(list) # Call select_winner method
end

# Sorts the list of options
def sort_votes(list)
    list.sort_by! {|option| option.vote} # Sorts the array by the vote attribute of each item
    list.reverse! # Reverses the array because it naturally sorts ascending order
end

# Deletes all options which are not atleast equal to first item on the array which will have the highest votes
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

# Decides what option wins
def select_winner(list)
    find_highest_votes(list) # Rebuilds the array so that it only has the option(s) with highest votes
    winner = list.sample # Randomly picks a winner from the array, and also works if there is only a single object in the array (Possibly have a method where the user can choose to re-vote between winning options?)
    system 'clear'
    puts "And the winner is...#{winner.name}!"
end

generator_check(list, index)