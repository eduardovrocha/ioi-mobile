#!/bin/bash

# Function to check if Homebrew is installed
check_homebrew() {
    if command -v brew &> /dev/null; then
        echo "Homebrew is installed."
        return 0
    else
        echo "Homebrew is not installed."
        return 1
    fi
}

# Function to check if SDKMAN is installed
check_sdkman() {
    if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        echo "SDKMAN is installed."
        return 0
    else
        echo "SDKMAN is not installed."
        return 1
    fi
}

# Function to update Kotlin using Homebrew
update_kotlin_homebrew() {
    echo "Updating Kotlin using Homebrew..."
    brew update
    brew upgrade kotlin
    echo "Kotlin updated successfully using Homebrew."
}

# Function to update Kotlin using SDKMAN
update_kotlin_sdkman() {
    echo "Updating Kotlin using SDKMAN..."
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk update kotlin
    echo "Kotlin updated successfully using SDKMAN."
}

# Check if Homebrew or SDKMAN is installed and update Kotlin accordingly
if check_homebrew; then
    update_kotlin_homebrew
elif check_sdkman; then
    update_kotlin_sdkman
else
    echo "Neither Homebrew nor SDKMAN is installed. Please install one of them to manage Kotlin."
    exit 1
fi

# Reload Bash shell by sourcing the profile
if [ -f "$HOME/.bash_profile" ]; then
    echo "Reloading Bash profile..."
    source "$HOME/.bash_profile"
elif [ -f "$HOME/.bashrc" ]; then
    echo "Reloading Bash configuration..."
    source "$HOME/.bashrc"
else
    echo "No Bash configuration file found to reload."
fi

echo "Kotlin update script completed and Bash shell reloaded."
