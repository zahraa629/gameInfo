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
    # Extract the payment status 4th field using cut
    status=$(echo "$1" | cut -d ":" -f4)
    
    #Use sed to replace "Paid" with "NotFree"
    status=$(echo "$status" | sed 's/Paid/NotFree/')
    
    echo "Payment status: $status"
}

