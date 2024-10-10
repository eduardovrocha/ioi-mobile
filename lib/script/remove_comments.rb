require 'fileutils'

# Function to recursively find all files in the directory and its subdirectories
def find_all_files(dir)
  Dir.glob(File.join(dir, '**', '*')).select { |file| File.file?(file) }
end


def remove_print_statements(file_path)
  # Read the file content
  content = File.read(file_path)


  updated_content = content.gsub(/print\(['"].*?['"]\);?/, '')

  # Write the updated content back to the file if changes were made
  if content != updated_content
    File.write(file_path, updated_content)
    puts "Updated: #{file_path}"
  else
    puts "No changes: #{file_path}"
  end
end

# Main function to process all files in the specified folder and subfolders
def process_folder(folder_path)
  files = find_all_files(folder_path)

  files.each do |file|
    remove_print_statements(file)
  end
end

# Automatically set folder_path to the current working directory
folder_path = Dir.pwd

# Call the function to start processing
process_folder(folder_path)
