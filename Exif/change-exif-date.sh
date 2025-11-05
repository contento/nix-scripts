#!/usr/bin/env bash
# Ensure the script exits if any command fails
set -euo pipefail

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <filepath(s)> <date: yyyy/mm/dd>"
  exit 1
fi

# Extract the date argument (last argument)
new_date="${!#}"

# Validate the date format
if ! [[ "$new_date" =~ ^[0-9]{4}/[0-9]{2}/[0-9]{2}$ ]]; then
  echo "Error: Date must be in yyyy/mm/dd format."
  exit 1
fi

# Convert the date format to yyyy:mm:dd
converted_date="${new_date//\//:}"

# Process all file paths (all arguments except the last one)
for filepath in "${@:1:$(($#-1))}"; do
  # Change the EXIF dates using exiftool without creating copies
  exiftool -overwrite_original -AllDates="$converted_date 00:00:00" "$filepath"

  # Notify the user about each file
  if [ $? -eq 0 ]; then
    echo "Successfully updated EXIF dates for $filepath to $converted_date."
  else
    echo "Failed to update EXIF dates for $filepath."
  fi
done
