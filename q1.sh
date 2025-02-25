#!/bin/bash

# function to check if number entered is valid
valid() {
    local num=$1

    # Check if input is a 4-digit number
    if ! [[ $num =~ ^[0-9]{4}$ ]]; then
        echo "Error: Input must be a 4-digit number."
        return 1
    fi

    # Check if all digits are the same
    if [[ "${num:0:1}${num:0:1}${num:0:1}${num:0:1}" == "$num" ]]; then
        echo "Error: Input should not have all identical digits."
        return 1
    fi

    return 0
}

# Function to perform Kaprekar's routine
kaprekar_routine() {
    local num=$1
    local count=0
    local target=6174

    while [[ $num -ne $target ]]; do
        # Sort digits in descending order
        num_desc=$(echo "$num" | grep -o . | sort -r | tr -d '\n')

        # Sort digits in ascending order
        num_asc=$(echo "$num" | grep -o . | sort | tr -d '\n')

        # Convert to integer and subtract
        num=$((10#$num_desc - 10#$num_asc))
        ((count++))

        echo "Iteration $count: $num"

        #to make the number 4 digits
        num=$(printf "%04d" "$num")

        if [[ $num -eq $target ]]; then
            break
        fi
    done

    echo "No. of iterations to reach 6174 : $count"
}

# Read user input
read -p "Enter a 4-digit number: " input

# Validate input
if valid "$input"; then
    kaprekar_routine "$input"
fi


