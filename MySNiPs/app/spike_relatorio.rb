require "set"

class Relation
  include Comparable
  attr_accessor :gene
  attr_accessor :genotype
  attr_reader :magnitude
  def initialize(gene, genotype)
    @gene = gene
    @genotype = genotype
    @magnitude = genotype[:magnitude].to_f
  end

  def <=>(other)
    other.magnitude <=> @magnitude
  end
end

# .

# .

# .

def normal_reversed(str)
  return [str.split("").join(";")] if str == str.reverse

  result = str.split("").join(";")
  [result, result.reverse]
end

# .

# .

# .

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

# .

# .

# .
result = SortedSet[]
File.open("../../Iteracao_2/7829.23andme.6186", "r").each do |line|
  line = line.split("\t")
  gene = ids[line[0]]
  gene = cromopos[[line[1], line[2]]] if gene.nil?

  next if gene.nil?

  alleles = normal_reversed line[3].chomp.downcase
  alleles.each do |p|
    geno = titles["#{gene[:title].downcase}(#{p})"]
    unless geno.nil?
      result.add Relation.new gene, geno
      break
    end
  end
end

# .

# .

# .
f = File.open("../../Iteracao_2/card_spike.txt", "w")
result.each do |rel|
  case rel.genotype[:repute]
  when 0 then
    rep = "Neutral"
    appearance = ["- ", "- "]
  when 1 then
    rep = "Good"
    appearance = ["+-", "+-"]
  when 2 then
    rep = "Bad"
    appearance = ["! ", "! "]
  end

  f.puts "\n" + (appearance[0] * 60)
  f.puts rel.genotype[:title]
  f.puts rel.gene[:summary] if rel.gene.key? :summary
  f.puts rel.genotype[:summary] if rel.genotype.key? :summary
  f.puts "Magnitude: #{rel.genotype[:magnitude]}"
  f.puts "Repute: #{rep}" unless rep.nil?
  f.puts "\n" + rel.genotype[:page_content] unless rel.genotype[:page_content].empty?
  f.puts appearance[1] * 60
  f.puts "\n\n\n"
end
f.close
