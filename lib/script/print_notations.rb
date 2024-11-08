require 'yaml'

# Função para contar o total de funções em um arquivo .dart
def count_functions(content)
  function_count = 0

  # Expressão regular para detectar funções em Dart
  function_regex = /^\s*(?:[\w<>,\[\]]+\s+)?[\w]+\s*\([\w\s,]*\)\s*({|=>)/

  content.each_line do |line|
    function_count += 1 if line.match?(function_regex)
  end

  function_count
end

def read_dart_files(directory)
  results = { 'files' => [] }

  Dir.glob("#{directory}/**/*.dart").each do |file|
    # Conta o número de linhas do arquivo
    line_count = File.readlines(file).size

    # Cria o hash para o arquivo com o nome e contagem de linhas
    file_data = { 'name' => "#{File.basename(file)} - #{line_count} lines", 'notations' => [], 'functions' => [] }
    content = File.read(file)

    # Conta o número de funções no conteúdo do arquivo
    file_data['function_count'] = count_functions(content)

    # Processa notations
    content.scan(/\/\*([\s\S]*?)\*\//).each do |match|
      lines = match.first.lines
      line_count = lines.size

      if line_count == 1
        file_data['notations'] << { 'content' => lines.first.strip }
      else
        file_data['notations'] << { 'content' => line_count }
      end
    end

    # Processa definições de função com o novo padrão
    content.scan(/\/\*\s*function definition\s*([\s\S]*?)\*\//m).each do |match|
      function_block = match.first
      function_data = {}

      # Extrai os dados de cada linha da definição da função
      function_block.scan(/^\s*(\w+):\s*['"]?(.*?)['"]?$/).each do |key, value|
        case key
        when 'name', 'description', 'return'
          # Adiciona o valor diretamente se a chave não estiver vazia
          function_data[key] = value unless value.empty?
        when 'signature'
          # Extrai os parâmetros de assinatura
          params = function_block.scan(/^\s*-\s*(\w+):\s*['"]?(.*?)['"]?$/)
          function_data['signature'] = params.map { |param_key, param_desc| { param_key => param_desc } }
        end
      end

      # Adiciona a função somente se contiver dados válidos
      file_data['functions'] << function_data unless function_data.empty?
    end

    results['files'] << file_data unless file_data['notations'].empty? && file_data['functions'].empty?
  end

  results
end

def write_to_yaml(data, output_file)
  File.open(output_file, 'w') { |f| f.write(data.to_yaml) }
end

# Imprime o diretório de trabalho atual
puts "Current working directory: #{Dir.pwd}"

# Solicita ao usuário o caminho do diretório
print "Enter the path to the directory containing .dart files: "
directory = gets.chomp

# Verifica se o diretório existe
unless Dir.exist?(directory)
  puts "The directory does not exist. Exiting."
  exit
end

output_file = 'output.yaml'

data = read_dart_files(directory)
write_to_yaml(data, output_file)

puts "YAML file generated: #{output_file}"
