require_relative "./gener"
require_relative "./genotyper"

module Gluttony
  class Harvester
    def initialize(pedia)
      @pedia = pedia
      @response = nil
    end

    # Returns a list of IDs
    def genos
      @response = @pedia.query.list.title("Category:Is a genotype").prop(:ids).limit(:max).response
      @response.to_h["categorymembers"].map(&:first).map(&:last)
    end

    # Returns a hash with important information or nil
    def geno_info(genoid)
      resp = @pedia.parse.pageid(genoid).prop(:wikitext, :revid, :displaytitle).response
      Gluttony::GenotypeBuilder.build(resp.to_h)
    end

    def continue?
      if @response.nil?
        true
      else
        @response.continue?
      end
    end
  end
end
