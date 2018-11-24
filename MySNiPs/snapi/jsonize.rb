require "json/pure"

gene = []
File.open("../Iteracao_2/genes.txt", "r").each do |line|
  l = eval(line)
  gene.push l unless l.empty?
end

f = File.open("../Iteracao_2/genes.json", "w")
f.puts JSON.generate gene
f.close

geno = []
File.open("../Iteracao_2/genos.txt", "r").each do |line|
  l = eval(line)
  geno.push l unless l.empty?
end

f = File.open("../Iteracao_2/genos.json", "w")
f.puts JSON.generate geno
f.close
