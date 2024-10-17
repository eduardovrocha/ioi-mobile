#!/bin/bash

# Function to display a message
function echo_message {
  echo "---------------------------------"
  echo $1
  echo "---------------------------------"
}

# Function to update the baseUrl in api_service.dart
function update_base_url {
  local new_url=$1
  local file="lib/services/api_service.dart"
  local backup_file="$file.bak"

  # Backup the original file
  cp $file $backup_file

  # Update the baseUrl line with the new URL
  sed -i '' "s|final String baseUrl = .*|final String baseUrl = '$new_url';|g" $file
}

# Function to restore the original api_service.dart
function restore_base_url {
  local file="lib/services/api_service.dart"
  local backup_file="$file.bak"

  # Restore the original baseUrl from the backup
  original_base_url=$(grep 'final String baseUrl =' $backup_file)

  # Restore the original baseUrl line
  sed -i '' "s|final String baseUrl = .*|$original_base_url|g" $file
}

# Parse version from pubspec.yaml
echo_message "Extracting version from pubspec.yaml"
version=$(grep 'version:' pubspec.yaml | sed 's/version: //g')
current_version=$(echo $version | cut -d "+" -f 1)  # Parte da versão principal (ex: 1.0.9)
build_number=$(echo $version | cut -d "+" -f 2)     # VersionCode (ex: 1)

# Split the version into major, minor, and patch
IFS='.' read -r major minor patch <<< "$current_version"

# Increment the patch version and the build number (versionCode)
patch=$((patch + 1))
build_number=$((build_number + 1))

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

# Update the baseUrl in api_service.dart before the build
echo_message "Updating baseUrl in api_service.dart"
update_base_url "https://octopus-app-sr6qw.ondigitalocean.app"

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
    bundle_version_info=$(java -jar /Users/eduardovrocha/Development/ioi-development/ioi-mobile/lib/script/bundle/bundletool-all-1.8.0.jar dump manifest --bundle "$output_dir/$new_file_name" | grep version)

    if [ $? -eq 0 ]; then
      echo_message "Version information extracted successfully!"
    else
      echo_message "Failed to extract version information from the AAB."
      restore_base_url
      exit 1
    fi

  else
    echo_message "Failed to rename the AAB file."
    restore_base_url
    exit 1
  fi
else
  echo_message "Build failed!"
  restore_base_url
  exit 1
fi

# Restore the original baseUrl after the build
echo_message "Restoring the original baseUrl in api_service.dart"
restore_base_url

# Append to the report instead of overwriting
report_file="build_report.txt"
{
  echo ""  # Add a blank line before appending new information
  echo "Build Report"
  echo "--------------------------"
  echo "App Version: $new_version"
  echo "App Bundle: $new_file_name"
  echo "Bundle Version Info: $bundle_version_info"
  echo "Build completed on: $(date)"
} >> $report_file

# Confirm report generation
if [ -f "$report_file" ]; then
  echo_message "Build report appended successfully to $report_file"
else
  echo_message "Failed to append build report."
fi
