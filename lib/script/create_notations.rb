require 'yaml'

def parse_yaml_with_lines(file_path)
  data = YAML.load_file(file_path)
  notations_with_lines = {}

  # Lê o arquivo linha por linha e armazena as linhas das notations
  File.foreach(file_path).with_index(1) do |line, line_num|
    if line.strip.start_with?("- content:")
      content_value = line.split(": ", 2)[1]&.strip || "null"
      notations_with_lines[line_num] = content_value
    end
  end

  # Atualiza o hash de arquivos com as informações de linha para cada notation
  data['files'].each do |file_data|
    file_data['notations'].each do |notation|
      line_number = notations_with_lines.key(notation['content'])
      notation['line'] = line_number if line_number
    end
  end

  data
end

def generate_markdown(data, output_file)
  total_lines = 0

  File.open(output_file, 'w') do |file|
    # Título principal com a contagem total de arquivos
    file.puts "# files total: #{data['files'].size}\n\n"

    # Calcula a somatória das linhas de todos os arquivos
    data['files'].each do |file_data|
      # Extrai a quantidade de linhas do campo `name`
      line_count = file_data['name'].match(/(\d+) lines/)[1].to_i
      total_lines += line_count
    end

    # Exibe a somatória das linhas de todos os arquivos
    file.puts "Total lines across all files: #{total_lines}\n\n"

    data['files'].each do |file_data|
      # Exibe o título do arquivo com a contagem de linhas
      name_with_lines = file_data['name']
      file.puts "<details>\n<summary style=\"margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #b3ddba; padding-left: 10px\">#{name_with_lines}</summary>\n\n"

      # Exibe a contagem de funções
      file.puts "- **Functions Count**: #{file_data['function_count'] || 'N/A'}\n\n"

      # Processa os conteúdos de 'notations', incluindo a linha
      if file_data['notations']
        file.puts "<details>\n<summary style=\"margin-bottom: 10px; font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: #fdfbe6; padding-left: 10px\">notations #{file_data['notations'].size}</summary>\n\n"
        file_data['notations'].each do |notation|
          content = notation['content']
          line_info = notation['line'] ? " (Line: #{notation['line']})" : ""
          if content.is_a?(Integer)
            file.puts "- Content: #{content} lines#{line_info}\n"
          else
            file.puts "- Content: #{content.nil? || (content.is_a?(String) && content.empty?) ? 'null' : content}#{line_info}\n"
          end
        end
        file.puts "</details>\n\n"
        file.puts "\n"
      end

      # Processa as funções, transformando cada uma em um accordion
      if file_data['functions']
        file.puts "<details style=\"margin-bottom: 10px;\">\n<summary style=\"font-size: 1.3em; font-weight: bold; line-height: 1.5; background-color: lightblue; padding-left: 10px; margin-bottom: 10px\">documented #{file_data['functions'].size}</summary>\n\n"
        file_data['functions'].each do |function|
          # Extrai 'name', 'description', e 'return' diretamente do arquivo YAML
          function_name = function['name']
          function_description = function['description']
          function_return = function['return']
          function_signature = function['signature']

          # Envolve cada função em um <details> para o accordion
          file.puts "<details style=\"font-weight: normal; line-height: 1.5; padding-left: 20px; padding-top: 5px\">\n<summary>name: #{function_name}</summary>\n\n"
          file.puts "- **Name**: #{function_name}\n"
          file.puts "- **Description**: #{function_description}\n"

          # Processa a assinatura da função
          if function_signature
            file.puts "- **Signature**:\n"
            function_signature.each do |param|
              param_type = param['type'] || 'null'
              param_text = param['textTest'] || 'null'
              param_value = param['valueTest'] || 'null'

              file.puts "  - **Type**: #{param_type}\n"
              file.puts "  - **TextTest**: #{param_text}\n"
              file.puts "  - **ValueTest**: #{param_value}\n"
            end
          end

          file.puts "- **Return**: #{function_return}\n\n"
          # Fecha o bloco <details> da função
          file.puts "</details>\n\n"
        end
        file.puts "</details>\n\n"
        file.puts "\n"
      end

      file.puts "</details>\n\n"
      file.puts "\n"
    end
  end
end

# Imprime o diretório de trabalho atual
puts "Current working directory: #{Dir.pwd}"

# Solicita ao usuário o diretório para salvar o arquivo output.md
print "Enter the directory where you want to save the output.md file: "
output_directory = gets.chomp

# Verifica se o diretório existe, senão encerra o script
unless Dir.exist?(output_directory)
  puts "The specified directory does not exist. Exiting."
  exit
end

# Caminho completo do arquivo de saída
output_file = File.join(output_directory, 'output.md')

# Carrega o arquivo YAML com as linhas de notations
input_file = 'output.yaml'
data = parse_yaml_with_lines(input_file)

# Gera o Markdown
generate_markdown(data, output_file)

puts "Markdown file generated: #{output_file}"
