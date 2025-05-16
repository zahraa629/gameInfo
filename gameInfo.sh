#!/bin/bash
file="gameInfo.txt"
display_game_files() {
    if [ ! -f "$file" ]; then
        echo "Error: $file not found!"
        exit 1
    fi

    echo "Available games:"
    # Read each line, cut the game name (first field), and print it
    cut -d ":" -f1 "$file" | sort
   } 
# Function to check whether a game is Free or NotFree 
check_payment_status() {
    echo "Enter the name of the game:"
    read game_name

    line=$(grep -i "$game_name" "$file")

    if [ -z "$line" ]; then
        echo "Game not found."
    else
        # Extract the 4th field (payment status)
        payment=$(echo "$line" | cut -d ":" -f4)

        # Use sed to replace "Paid" with "NotFree"
        payment=$(echo "$payment" | sed 's/Paid/NotFree/')

        echo "The game '$game_name' is: $payment"
    fi
}

# Function to check platform (Android/iOS)
check_platform() {
    echo "Enter the name of the game:"
    read game_name

    # Search for the game in the file
    line=$(grep -i "$game_name" "$file")

    if [ -z "$line" ]; then
        echo "Game not found."
    else
        # Extract the platform 2nd field using awk
        platform=$(echo "$line" | awk -F ":" '{print $2}')
        echo "The game '$game_name' is available on: $platform"
    fi
}

# Function to check game type (Entertainment/Horror/Action)
check_game_type() {
    echo "Enter the name of the game:"
    read game_name

    # Search for the game in the file
    line=$(grep -i "$game_name" "$file")

    if [ -z "$line" ]; then
        echo "Game not found."
    else
        # Extract the game type 3rd field using cut
        game_type=$(echo "$line" | cut -d ":" -f3)
        echo "The game '$game_name' type is: $game_type"
    fi
}

# Call the function to display all available game files in the folder
display_game_files

# Call the function to check if the game is Free or Paid
check_payment_status

# Call the function to check the platform (Android/iOS)
check_platform

# Call the function to check the game type (Entertainment/Horror/Action)
check_game_type

# Function to check if game requires internt
check_internet_requirement() {
echo "Enter the name of the game:"
read game_name
#look for the line that containes the name of the game
line=$(grep -i "^$game_name:" "$file")
if [ -z "$line" ]; then
echo "Game not found"
  else
# Extract The fifth filed whether the game requires internt
       requires_net=$(echo "$line" | cut -d ":" -f5)
        echo "The game '$game_name' requires internet: $requires_net"
    fi
}
# Function to check if game is suitable for kids
check_kids_suitability() {
    echo "Enter the name of the game:"
    read game_name

    # Search for the line containing the game name
    line=$(grep -i "^$game_name:" "$file")

    if [ -z "$line" ]; then
        echo "Game not found."
    else
        # Extract the 6th field: whether the game is suitable for kids
        suitable=$(echo "$line" | cut -d ":" -f6)
        echo "The game '$game_name' is suitable for kids: $suitable"
    fi
}


#calling the function to check if the game requires internt
check_internet_requirement
#calling the function to check if the game is suitable for kids
check_kids_suitability

