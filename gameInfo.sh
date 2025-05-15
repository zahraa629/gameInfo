#!/bin/bash

# Define the path to the directory that contains game files
games_dir="./games"

# Function to display all available game files inside the directory
display_game_files() {
    # Check if the directory exists
    if [ ! -d "$games_dir" ]; then
        echo "Error: The games directory does not exist!"
        exit 1
    fi

    # Store the list of files in an array
    game_files=($(ls "$games_dir"))

    # Check if the directory is empty
    if [ ${#game_files[@]} -eq 0 ]; then
        echo "No games found in the directory."
        exit 1
    fi

    # Print the list of game files
    echo "Available games:"
    for game in "${game_files[@]}"; do
        echo "$game"
 done 
 }
  # Define the path to the game info file
file="gameInfo.txt"


# Function to check whether a game is Free or Paid
check_payment_status() {
    # Ask the user to enter the game name
    echo "Enter the name of the game:"
    read game_name

    # Search for the game in the file (case-insensitive)
    line=$(grep -i "$game_name" "$file")

    # If the game is not found
    if [ -z "$line" ]; then
        echo "Game not found."
    else
        # Extract the 4th field which represents payment status
        payment=$(echo "$line" | cut -d ":" -f4)
        
        # Display the result
        echo "The game '$game_name' is: $payment"
    fi
}


# Call the function to display all available game files in the folder
display_game_files

# Call the function to check if the game is Free or Paid
check_payment_status
