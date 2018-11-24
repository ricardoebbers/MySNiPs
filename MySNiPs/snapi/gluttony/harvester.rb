require_relative "./builder"

module Gluttony
  class Harvester
    attr_reader :response
    attr_reader :last_response
    def initialize(pedia)
      @pedia = pedia
      @response = nil
      @last_response = nil
    end

    # Returns a list of IDs
    def genotypes
      tries = 0
      begin
        @last_response = @response
        @response = if @response.nil?
                      @pedia.query.list.title("Category:Is a genotype").prop(:ids).limit(:max).response
                    else
                      @response.continue
                    end
        @response.to_h["categorymembers"].map(&:first).map(&:last)
      rescue JSON::ParserError
        puts "JSON Parser Error while gathering Genotypes"
        puts @response.metadata
        @response = @last_response
        return nil
      end
    end

    # Needed only when gathering genotype IDs
    def continue?
      if @response.nil?
        true
      else
        @response.continue?
      end
    end

    # Returns a hash with important information or nil
    def genotype_info(genoid)
      resp = @pedia.parse.pageid(genoid).prop(:wikitext, :revid, :displaytitle).response
      Gluttony::Builder.genotype(resp.to_h)
    end

    def gene_info(genetitle)
      tries = 0
      begin
        resp = @pedia.parse.page(genetitle).prop(:wikitext, :revid).response
        Gluttony::Builder.gene(resp.to_h, genetitle)
      rescue JSON::ParserError
        if tries == 5
          puts "Limit retries achieved"
          puts @response.metadata
          raise
        end

        tries += 1
        puts "JSON Parser Error while gathering Genotypes, retrying - ", tries.to_s
        sleep(20)
        retry
      end
    end
  end
end
