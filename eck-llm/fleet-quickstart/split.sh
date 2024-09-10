#!/bin/bash

# Input file
input_file="certmanager.yaml"

# Output file base name
output_base="certmanager"

# Counter for the file suffix
counter=1

# Create a temporary file to store the current content block
temp_file=$(mktemp)

# Function to write the current content block to a new file
write_block_to_file() {
  output_file="${output_base}-${counter}.yml"
  mv "$temp_file" "$output_file"
  echo "Created $output_file"
  counter=$((counter + 1))
}

# Read the input file line by line
while IFS= read -r line || [ -n "$line" ]; do
  # If the line is '---' and the temp file is not empty, write the block to a file
  if [[ "$line" == "---" ]]; then
    if [ -s "$temp_file" ]; then
      write_block_to_file
      temp_file=$(mktemp)  # Create a new temporary file for the next block
    fi
  fi
  # Append the current line to the temp file
  echo "$line" >> "$temp_file"
done < "$input_file"

# Write the final block to a file if the temp file is not empty
if [ -s "$temp_file" ]; then
  write_block_to_file
fi

# Clean up the last temporary file if it exists
[ -f "$temp_file" ] && rm "$temp_file"