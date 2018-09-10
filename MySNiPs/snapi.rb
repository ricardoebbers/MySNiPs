require 'mediawiktory'

snp = ARGV[0]
if snp.nil?
  puts 'Use um argumento para indicar a página a ser acessada'
  puts 'Enter para usar Rs1815739 como exemplo ou insira algo para sair'
  abort if gets.chomp != ''
  snp = 'Rs1815739'
end

# API usada é https://www.rubydoc.info/gems/mediawiktory/MediaWiktory
api = MediaWiktory::Wikipedia::Api.new 'https://bots.snpedia.com/api.php'

# Response é um objeto principal da API e é bem completo
# É importante checar https://www.rubydoc.info/gems/mediawiktory/MediaWiktory/Wikipedia/Response
response = api.query.titles(snp).prop(:info, :revisions).prop(:url, :content).limit(10).response

# Abortar caso nulo
if response.nil?
  puts 'Erro, response nula'
  abort
end

# Joga fora informações de Continue
# Continue são versões da página
pagina = response.to_h['pages'].values.first
puts response.to_h['pages'].keys

# Quando a página não existe, é retornado um template vazio com um Missing
if pagina.key?('missing')
  puts 'A página não existe'
  abort
end

# As informações são salvas em um arquivo para revisar melhor
File.open('raw.txt', 'w') { |file| file.write(pagina) }
puts 'Página encontrada, resposta salva em raw.txt'

# Algumas informações da página ficam disponíveis no pages
puts "Título da página: #{pagina['title']}"
puts "URL da página: #{pagina['fullurl']}"

# revisions é onde tem o conteúdo revisado da página
# É uma string enorme
conteudo = pagina['revisions'].first['*']

# A partir daqui é uma interpretação manual de um pedaço do revisions
comeco = conteudo.index('{{Rsnum')
fim = conteudo.index('}}')
if !comeco.nil? && !fim.nil?
  # Pega o começo do texto, um tipo de dicionário com informações importantes
  # Todas elas estão no formato {{Rsnum | chave=valor | chave=valor}}
  # Logo, há vários splits numa tentativa de fazer um parse manual em um hash
  rsnum_lista = conteudo[comeco + 9, fim - 10].split('|')
  rsnum = {}
  rsnum_lista.length.times do |i|
    parte = rsnum_lista[i].split('=')
    rsnum[parte[0]] = parte[1].chomp
  end

  # Utiliza o hash para pegar os genótipos, que podem ir de 0 a n
  # Vão ser usados como SNP(?,?) para pegar as descrições de cada um
  # Mas por enquanto não, visto que teria que haver um tratamento
  # Para acessar cada uma é só fazer um array com title + genos
  # Graças ao titles, vai ser possível acessar várias de uma vez
  g = 1
  loop do
    geno = 'geno' + g.to_s
    break unless rsnum.include?(geno)
    puts geno + ": #{rsnum[geno]}"
    g += 1
  end
end

# Finalmente, pergunta se quer mostrar o conteúdo
puts "\nPressione Enter para ver o conteúdo ou insira algo para sair"
abort if gets.chomp != ''
puts conteudo
