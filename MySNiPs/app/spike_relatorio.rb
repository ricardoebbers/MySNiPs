require "set"

def normal_reversed(str)
  return [str.split("").join(";")] if str == str.reverse

  result = str.split("").join(";")
  [result, result.reverse]
end

gene = []
File.open("../../Iteracao_2/genes.txt", "r").each do |line|
  gene.push eval(line)
end

ids = {}
cromopos = {}
gene.each do |g|
  ids[g[:title].downcase] = g
  cromopos[[g[:chromosome], g[:position].to_s]] = g
end
gene = nil

geno = []
File.open("../../Iteracao_2/genos.txt", "r").each do |line|
  geno.push eval(line)
end

titles = {}
geno.each do |g|
  titles[g[:title].downcase] = g
end
geno = nil

result = Set[]
File.open("../../Iteracao_2/7829.23andme.6186", "r").each do |line|
  line = line.split("\t")
  gene = ids[line[0]]
  gene = cromopos[[line[1], line[2]]] if gene.nil?

  next if gene.nil?

  alleles = normal_reversed line[3].chomp.downcase
  alleles.each do |p|
    geno = titles["#{gene[:title].downcase}(#{p})"]
    unless geno.nil?
      result.add [gene, geno]
      break
    end
  end
end

f = File.open("../../Iteracao_2/card_spike.txt", "w")
result.each do |rest|
  case rest[1][:repute]
  when 0 then rep = "Neutral"
  when 1 then rep = "Good"
  when 2 then rep = "Bad"
  end

  f.puts "_________________________________________________________________"
  f.puts "\n" + rest[1][:title]
  f.puts rest[0][:summary] if rest[0].key? :summary
  f.puts rest[1][:summary] if rest[1].key? :summary
  f.puts "Magnitude: #{rest[1][:magnitude]}"
  f.puts "Repute: #{rep}" unless rep.nil?
  f.puts "\n" + rest[1][:page_content] unless rest[1][:page_content].empty?
  f.puts "_________________________________________________________________"
  f.puts "\n. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .\n"
end
f.close
