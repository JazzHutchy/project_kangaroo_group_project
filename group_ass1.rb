require_relative 'options'

list = Array.new
winner_list = Array.new
index = 1

# List building method
def build_list(list, index)
    loop do # Start loop
        system 'clear'
        print "Please enter an option or press the Enter key to proceed: "
        option = gets.strip # Get user input and set it as variable 'option'
        if option == "" # Check variable 'option' and if it is an enter key, break out from the loop 
            break # Gets out of the loop
        else
            list << Option.new(option) # Convert option into an Option instance
        end
    end
end

# 'Starts the program'
def generator_check(list, index)
    system 'clear'
    print "Are you having trouble deciding on something? "
    choice = gets.strip.downcase # Get user input and set it to variable 'choice'
    case choice
        when "yes"    
            build_list(list, index) # Call list builder method
        when "no"
            abort("Terminating program...") # Stops the whole program with a comment
        else
            puts "That is not a valid response, please enter yes or no."
            sleep 1
            generator_check(list, index) # Displays to user what is a valid option 
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

# Validates the users vote
def validate_vote(check_vote, list)
    if check_vote == false
        print "\nPlease input a number listed on the screen. "
        sleep 1
    elsif (check_vote > 0 && check_vote < list.length + 1)
        option = list[(check_vote - 1)] # Use 'check_vote' variable to access option instance from list array
        option.add_to_vote # Add a vote to option instance
    else
        print "\nThat is not a valid option, please input a number listed on the screen. "
        sleep 1
    end
end

# Collect votes method
def collect_votes(list, index)
    loop do
        print_list(list, index) # Prints a list of all options
        print "\nPlease vote for your preferred option or press the Enter key if you are done voting: "
        check_input = gets
        if check_input == "\n"
            break
        else
            check_vote = Integer(check_input) rescue false
            validate_vote(check_vote, list)
        end
    end
end

def sort_votes(list)
    list.sort_by! {|option| option.vote}
    list.reverse!
end

def build_winner_list(list, winner_list)
    loop do
        first = list[0]
        second = list[1]
        if first.vote == second.vote
            winner_list << second
            list.delete_at(1)
        else 
            winner_list << first
            break
        end
    end
end

def select_winner(winner_list)
    winner = winner_list.sample
    system 'clear'
    puts "And the winner is ... #{winner.name}!"
end


generator_check(list, index)
collect_votes(list, index)
sort_votes(list)
build_winner_list(list, winner_list)
select_winner(winner_list)