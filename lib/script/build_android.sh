#!/bin/bash

# Function to display a message
function echo_message {
  echo "---------------------------------"
  echo $1
  echo "---------------------------------"
}

# Parse version from pubspec.yaml
echo_message "Extracting version from pubspec.yaml"
version=$(grep 'version:' pubspec.yaml | sed 's/version: //g')
current_version=$(echo $version | cut -d "+" -f 1)
build_number=$(echo $version | cut -d "+" -f 2)

# Split the version into major, minor, and patch
IFS='.' read -r major minor patch <<< "$current_version"

# Increment the patch version
patch=$((patch + 1))

# Update the version number in pubspec.yaml
new_version="$major.$minor.$patch+$build_number"
echo_message "Updating version to $new_version in pubspec.yaml"

# Use sed to replace the old version with the new version in pubspec.yaml
sed -i '' "s/version: .*/version: $new_version/g" pubspec.yaml

# Verify that the version was updated successfully
if grep -q "version: $new_version" pubspec.yaml; then
  echo_message "Version updated successfully to $new_version"
else
  echo_message "Failed to update version in pubspec.yaml"
  exit 1
fi

# Run the Flutter build
echo_message "Building the appbundle with Flutter"
flutter build appbundle

# Check if the build succeeded
if [ $? -eq 0 ]; then
  echo_message "Build completed successfully!"

  # Define the custom output directory and filename
  output_dir="build/app/outputs/bundle/release"
  new_file_name="app-release-v$major.$minor.$patch.aab"

  # Rename the generated AAB file
  echo_message "Renaming app-release.aab to $new_file_name"
  mv "$output_dir/app-release.aab" "$output_dir/$new_file_name"

  if [ $? -eq 0 ]; then
    echo "The AAB file has been renamed to '$new_file_name' in the '$output_dir' directory."

    # Run the bundletool command to extract the version info
    echo_message "Running bundletool to extract version information from the AAB"
    java -jar /Users/eduardovrocha/Development/ioi-development/ioi-mobile/lib/script/bundle/bundletool-all-1.8.0.jar dump manifest --bundle "$output_dir/$new_file_name" | grep version

    if [ $? -eq 0 ]; then
      echo_message "Version information extracted successfully!"
    else
      echo_message "Failed to extract version information from the AAB."
      exit 1
    fi

  else
    echo_message "Failed to rename the AAB file."
    exit 1
  fi
else
  echo_message "Build failed!"
  exit 1
fi
