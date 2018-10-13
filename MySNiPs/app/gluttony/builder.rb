module Gluttony
  class Builder
    # Class that will get informations about Genos or Genes from raw text
    class << Builder
      # This is a static class
      SHORT = 240
      def genotype(raw)
        geno = {}
        geno[:pageid] = raw["pageid"]
        geno[:title] = raw["title"]
        geno[:revid] = raw["revid"]

        wikitext = raw["wikitext"]["*"].delete("\n").delete("\t")
        rsendindex = text.index("}}") + 1
        geno[:page_content] = wikitext(rsendindex..(rsendindex + SHORT))

        rsendindex -= 2
        genolen = "{{Genotype".freeze.length + 1
        table = wikitext[genolen..rsendindex].split("|")

        # Repute can be neutral by not having any value
        geno[:repute] = 0
        geno[:magnitude] = 0
        table.each do |info|
          info = info.split("=")
          geno = Builder._genotype(info[0], info[1], geno)
        end

        geno if Builder.ok? geno
      end

      def _genotype(key, val, geno)
        case key
        when "summary" then geno[:summary] = val
        when "allele1" then geno[:allele1] = val
        when "allele2" then geno[:allele2] = val
        when "magnitude" then geno[:magnitude] = val.to_f
        when "repute" then geno[:repute] = 1 if val == "Good" else geno[:repute] = 2
        end
        geno
      end

      def ok?(geno)
        true if geno.key?(:summary) && (!geno[:magnitude].zero? || geno[:repute] == 2)
      end

      def gene(raw, genetitle)
        gene = {title: genetitle}
        return gene if raw.empty?

        gene[:revid] = raw["revid"]
        text = raw["wikitext"]["*"].delete("\n").delete("\t")

        rslen = if text.start_with?("{{Rsnum")
                  8
                elsif text.start_with?("{{23andMe SNP")
                  14
                else
                  # At least the {{
                  2
                end
        endindex = text.index("}}") - 1
        return gene if endindex.nil?

        text = text[rslen..endindex].split("|")

        gene[:orientation] = false
        gene[:stabilized] = false
        text.each do |info|
          info = info.split("=")
          gene = Builder._gene(info[0], info[1], gene)
        end
        gene if Builder.complete? gene
      end

      def _gene(key, val, gene)
        case key
        when "rsid" then gene[:rsid] = val
        when "iid" then gene[:iid] = val
        when "Summary" then gene[:summary] = val
        when "Gene" then gene[:name] = val
        when "Chromosome" then gene[:chromosome] = val
        when "position" then gene[:position] = val.to_i
        when "GMAF" then gene[:gmaf] = val.to_f
        when "Orientation" then gene[:orientation] = true if val == "plus"
        when "Stabilized" then gene[:stabilized] = true if val == "plus"
        end
        gene
      end

      def geno_to_allele(geno)
        [geno[1], geno[3]]
      end

      def allele_to_geno(allele1, allele2)
        "(" + allele1 + "," + allele2 + ")"
      end

      def complete?(gene)
        true if ((gene.key :chromosome) && (gene.key? :position)) || ((gene.key? :rsid) || (gene.key? :iid))
      end
    end
  end
end
