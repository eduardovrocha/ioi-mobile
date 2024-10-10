#!/bin/bash

# Navigate to the project root directory (assuming the script is in '/lib/scripts')
cd "$(dirname "$0")/../.."

# Ensure we're in the root of the Flutter project
if [[ ! -d ".git" ]]; then
  echo "This script must be run from within a Git repository."
  exit 1
fi

# Fetch all remote branches first
git fetch --all

# Loop over each local branch
for branch in $(git branch | sed 's/^..//'); do
  echo "Switching to branch: $branch"

  # Checkout the branch
  git checkout $branch

  # Pull the latest changes
  git pull origin $branch
done
