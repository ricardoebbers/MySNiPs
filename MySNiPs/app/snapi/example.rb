require_relative "./pedia"

api = SNaPi::Pedia.new

# Change limit to :max later
response = api.query.list.title("Category:Is a genotype").prop(:ids).limit(500).response

genos_ids = response.to_h["categorymembers"].map(&:first).map(&:last)
i = 0
puts "Genotypes:"
puts genos_ids.size
while response.continue? && i < 5
  response = response.continue
  genos_ids += response.to_h["categorymembers"].map(&:first).map(&:last)
  puts genos_ids.size
  i += 1
end
puts "Last id: ", genos_ids[-1]

response = api.parse.pageid(genos_ids[-1]).prop(:displaytitle, :wikitext).response
wikitext = response.to_h["wikitext"]["*"]
puts "\nPage content:"
puts wikitext

# Rustic manual interpretation of the text
start = wikitext.index("{{Genotype\n")
final = wikitext.index("}}")
if !start.nil? && !final.nil?
  # Gets the start of the text, that's kind of a hash with some useful information
  # It is in the format {{Genotype | key=value | key=value}}
  # Logo, há vários splits numa tentativa de fazer um parse manual em um hash
  geno_list = wikitext[start + 12, final - 10].split("|")
  geno = {}
  geno_list.length.times do |i|
    part = geno_list[i].split("=")
    geno[part[0]] = part[1].chomp
  end
end

if geno.include? "rsid"
  response = api.cargoquery.rsnum.where_rsid(geno["rsid"])
else
  response = api.cargoquery.rsnum.where_iid(geno[":iid"])
end

response = response.fields(
  :Gene, :Chromosome, :position, :Orientation,
  :StabilizedOrientation, :GMAF, :Gene_s, :geno1, :geno2, :geno3
).response.to_h[0]["title"]

puts "\nInformations about the gene of the last genotype"
puts "Gene: " + response["Gene"]
puts "Chromosome: " + response["Chromosome"]
puts "position: " + response["position"]
