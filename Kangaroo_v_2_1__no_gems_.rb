require_relative 'options'

list = []
index = 1

# 'Starts the program'
def generator_check(list, index)
    loop do
        system 'clear'
        print "Are you having trouble deciding on something? Please enter yes or no: "
        yesno = gets.strip.downcase # Check user input for yes or no
        case yesno
            when "yes"
                # Break out of the loop if user input 'yes' 
                break
            when "no"
                # Stops the whole program with a comment
                abort("Terminating program...")
            else
                # Displays to user what is a valid option if they input anything else
                print "\nThat is not a valid response, please enter yes or no. "
                sleep 1
        end
    end
    print "\nLet's create a list of options. "
    sleep 1
    build_list(list, index)
end

# List building method
def build_list(list, index)
    loop do
        # If there are less than two options entered in the list, do not allow the user to continue
        if list.length < 2
            system 'clear'
            print "Please enter an option: "
            # Get user input and set it as variable 'choice'
            choice = gets.strip
            # If 'choice' is an enter key, inform the user that they must enter at least two options
            if choice == "" # Blank check because of .strip
                print "\nYou must enter at least two options. "
                sleep 1
            else # Convert 'choice' into an Option instance
                list << Option.new(choice)
            end
        # If there are at least two options in the array, allow the user to either add more options or proceed
        else
            system 'clear'
            print "Please enter an option or press the Enter key to proceed: "
            choice = gets.strip
            if choice == "" # Check 'choice' and if it is an enter key
                break # Gets out of the loop
            else
                list << Option.new(choice)
            end
        end
    end
    vote_or_random(list, index)
end

# Asks if people want to vote on the list of options or have the app randomly pick a winner.
def vote_or_random (list, index)
     # Set variable outside the loop so it is accessible within the method
    voterandom = nil
    loop do
        system 'clear'
        print "Would you like to vote or have the program randomly pick an option for you?\n\n1. Vote\n2. Random\n\nPlease enter 1 to vote or 2 to have the program randomly select a winner: "
        
        # Converts user input into an Integer, 
        # if user input is not a number or does not contain a number at the start it will return 0
        voterandom = gets.to_i 
        if voterandom == 1 || voterandom == 2 # Check if the user input a valid option
            break # If the user selected an valid option break out of the loop
        else
            print "\nThat is not a valid option please enter 1 to vote or 2 to randomly pick an option. "
            sleep 1
        end
    end

    # Check which method to run based on valid user input
    if voterandom == 1 
        collect_votes(list, index)
    else
        random_winner(list)
    end

end

# Collect votes method
def collect_votes(list, index)
    vote_number = 0
    loop do
        # Method is made outside the loop so that the correct number is displayed each iteration of the loop
        print_list(list, index)
        print "\nTimes voted: #{vote_number}\n\nPlease vote for your preferred option or press the Enter key if you are done voting: "
        vote = gets # Grabs 'vote' from user
        if vote == "\n" # Checks if 'vote' is an empty line
            break # If the 'vote' is an empty line break out of loop
        else
            # Converts 'vote' into an Integer, if it does not contain a number at the start it will return 0
            check_vote = vote.to_i
            # Checks if the number entered is greater than 0 and within the length of array
            if (check_vote > 0 && check_vote < list.length + 1)
                # Use 'check_vote' variable and correct it to access the correct corresponding option from the list
                option = list[(check_vote - 1)]
                option.add_to_vote
                vote_number += 1
            else
                print "\nThat is not a valid option, please input a number listed on the screen. "
                sleep 1
            end
        end
    end
    select_winner(list, index)
end

# Print a list of all available options for the user
def print_list(list, index) 
    system 'clear'
    list.each do |option| # Loop through each item in the list array
        puts "#{index}. #{option.name}"
        index += 1
    end
end

# Decides what option wins
def select_winner(list, index)
    find_highest_votes(list) # Rebuilds the array so that it only has the option(s) with highest votes
    if list.length > 1
        check_revote(list, index)
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
def check_revote (list, index)
    revotewinner = nil
    loop do
        system 'clear'
        print "There options are tied\n" "would you like to revote with the tied options or have the program randomly pick an option for you?\n\n1. Revote\n2. Random\n\nPlease enter 1 to revote or 2 have the program randomly select a winner: "
        revotewinner = gets.to_i
        if revotewinner == 1 || revotewinner == 2
            break
        else
            print "\nThat is not a valid option please enter 1 to vote or 2 to randomly pick an option. "
            sleep 1
        end
    end
    if revotewinner == 1
        collect_votes(list, index)
    else
        random_winner(list)
    end
end

# Randomly selects a winner from the list
def random_winner(list)
    winner = list.sample # Randomly picks a winner from the array, and also works if there is only a single object in the array (Possibly have a method where the user can choose to re-vote between winning options?)
    system 'clear'
    puts "And the winner is ... #{winner.name}!"
end

# Sorts the list of options
def sort_votes(list)
    list.sort_by! { |option| option.vote } # Sorts the list by the vote attribute of each option
    list.reverse! # Reverses the list because it naturally sorts ascending order
end

generator_check(list, index)