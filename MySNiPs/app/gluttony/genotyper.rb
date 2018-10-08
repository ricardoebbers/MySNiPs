module Gluttony
  class GenotypeBuilder
    # Class that will get informations about a Geno from raw text
    # It also judges if the Geno is valid and returns nil if it isn't
    class << GenotypeBuilder
      #This is a static class
      def GenotypeBuilder.build(raw)
        geno = {}
        geno[:pageid] = raw["pageid"]
        geno[:title] = raw["title"]
        geno[:revid] = raw["revid"]
        text = raw["wikitext"]["*"]
        puts text

        # Returns a hash with important info or nil
      end
    end
  end
end
