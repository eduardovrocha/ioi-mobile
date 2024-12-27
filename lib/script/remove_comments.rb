require 'fileutils'

# Exibe o path atual em que o script está sendo executado
current_path = Dir.pwd
puts "O script está sendo executado em: #{current_path}"

# Pergunta ao usuário qual path deseja verificar
puts "Informe o path que deseja verificar e remover os 'print(\"\")' dos arquivos .dart:"
folder_path = gets.chomp

# Verifica se o path informado é válido
unless Dir.exist?(folder_path)
  puts "O path informado não existe. Encerrando o script."
  exit
end

# Função para encontrar todos os arquivos .dart na pasta e subpastas
def find_all_dart_files(dir)
  Dir.glob(File.join(dir, '**', '*.dart')).select { |file| File.file?(file) }
end

# Função para remover `print` statements de um arquivo .dart
def remove_print_statements(file_path)
  # Lê o conteúdo do arquivo
  content = File.read(file_path)

  # Remove todos os `print("")` e `print('')` statements
  updated_content = content.gsub(/print\(['"].*?['"]\);?/, '')

  # Escreve o conteúdo atualizado de volta ao arquivo se houver mudanças
  if content != updated_content
    File.write(file_path, updated_content)
    puts "Atualizado: #{file_path}"
  end
end

# Função principal para processar todos os arquivos .dart no path especificado
def process_folder(folder_path)
  files = find_all_dart_files(folder_path)

  # Verifica se há arquivos .dart para processar
  if files.empty?
    puts "Nenhum arquivo .dart encontrado no path informado."
    return
  end

  # Processa cada arquivo .dart encontrado
  files.each do |file|
    remove_print_statements(file)
  end

  puts "Processamento concluído."
end

# Inicia o processamento dos arquivos no path especificado
process_folder(folder_path)
