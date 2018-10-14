require "set"

def normal_reversed(str)
  return [str.split("").join(";")] if str == str.reverse

  result = str.split("").join(";")
  [result, result.reverse]
end

begin
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

  puts result.size

rescue StandardError => e
  puts e.message
end
