#!/bin/bash

file="gameInfo.txt"

#Display
display_game_files() {
    if [ ! -f "$file" ]; then
        echo "Error: $file not found!"
        exit 1
    fi
    
#Display Available Games
    echo "Available Games:"
    cut -d ":" -f1 "$file" | sort
}

#Function to show the platform (Android/IOS)
show_platform() {
    # Extract the platform 2nd field using cut
    echo "Platform: $(echo "$1" | cut -d ":" -f2)"
}

#Function to show the game type (Entertainment/Horror/Action)
show_game_type() {
    #Extract the game type 3rd field using cut
    echo "Type: $(echo "$1" | cut -d ":" -f3)"
}

#Function to show whether a game is Free or NotFree
show_payment_status() {
    #Extract the payment status 4th field using cut
    status=$(echo "$1" | cut -d ":" -f4)
    
    #Use sed to replace "Paid" with "NotFree"
    status=$(echo "$status" | sed 's/Paid/NotFree/')
    
    echo "Payment status: $status"
}

# Function to show whether the game requires internet
show_internet_requirement() {
    echo "Requires internet: $(echo "$1" | cut -d ":" -f5)"
}

# Function to show whether the game is suitable for kids
show_kids_suitability() {
    echo "Suitable for kids: $(echo "$1" | cut -d ":" -f6)"
}

# Function to retrieve the full line of game data from the file
get_game_line() {
    grep -i "^$1:" "$file"
}

# Display the list of available game files
display_game_files

# Prompt the user to enter a game name and check if it exists
while true; do
    echo -n "Enter the name of the game: "
    read game_name

    # Search for the game line in the file
    line=$(get_game_line "$game_name")

    if [ -z "$line" ]; then
        echo "Game not found. Please try again."
    else
        echo "Game '$game_name' found!"
        break
    fi
done
# Display the menu using echo + read + case
while true; do
    echo "Menu:"
    echo "1. Platform"
    echo "2. Type"
    echo "3. Payment Status"
    echo "4. Internet Requirement"
    echo "5. Kids Suitability"
    echo "6. All Info"
    echo "7. Exit"
    echo -n "Enter your choice: "
    read ch

    case $ch in
        1) show_platform "$line" ;;  # Display platform (Android/iOS)
        2) show_game_type "$line" ;; # Display game type (Entertainment/Horror/Action)
        3) show_payment_status "$line" ;; # Display if the game is Free or NotFree
        4) show_internet_requirement "$line" ;; # Display if the game requires internet
        5) show_kids_suitability "$line" ;; # Display if the game is suitable for kids
        6)
            show_platform "$line"
            show_game_type "$line"
            show_payment_status "$line"
            show_internet_requirement "$line"
            show_kids_suitability "$line"
            break ;; # Display all information
        7) echo "Goodbye"; exit 0 ;; # Exit the program
        *) echo "Invalid choice. Please try again." ;; # Handle invalid input
    esac
    echo
done

