module Gluttony
  class Builder
    # Class that will get informations about Genos or Genes from raw text
    class << Builder
      # This is a static class
      def Builder.genotype(raw)
        geno = {}
        geno[:pageid] = raw["pageid"]
        geno[:title] = raw["title"]
        geno[:revid] = raw["revid"]

        text = raw["wikitext"]["*"].delete("\n")
        genolen = "{{Genotype".freeze.length + 1
        endindex = text.index("}}") - 1
        text = text.delete("\n")[genolen..endindex].split("|")

        # Repute can be neutral by not having any value
        geno[:repute] = 0
        text.each do |info|
          info = info.split("=")
          geno = Builder._genotype(info[0], info[1], geno)
        end
        geno
      end

      def _genotype(key, val, geno)
        case key
        when "rsid", "iid" then geno[:id] = val
        when "summary" then geno[:summary] = val
        when "allele1" then geno[:allele1] = val
        when "allele2" then geno[:allele2] = val
        when "magnitude" then geno[:magnitude] = val.to_f
        when "repute" then geno[:repute] = 1 if val == "Good" else geno[:repute] = 2
        end
        geno
      end
    end
  end
end
