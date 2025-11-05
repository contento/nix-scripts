#!/usr/bin/env bash
# Ensure the script exits if any command fails
set -euo pipefail

# Initialize variables
dry_run=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      dry_run=true
      shift
      ;;
    *)
      if [ -z "${folder:-}" ]; then
        folder="$1"
      else
        echo "Unexpected argument: $1"
        exit 1
      fi
      shift
      ;;
  esac
done

# Check if the folder variable is set
if [ -z "${folder:-}" ]; then
  echo "Usage: $0 [--dry-run] <folder>"
  exit 1
fi

# Process the folder with exiftool
if [ "$dry_run" = true ]; then
  echo "Dry run: exiftool -r -d \"%Y/%m/%d\" \"-Directory<FileModifyDate\" \"-Directory<CreateDate\" \"-Directory<DateTimeOriginal\" \"$folder\""
else
  exiftool -r -d "%Y/%m/%d" "-Directory<FileModifyDate" "-Directory<CreateDate" "-Directory<DateTimeOriginal" "$folder"
fi
