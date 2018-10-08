module Gluttony
  class Harvester
    def initialize(pedia)
      @pedia = pedia
      @response = nil
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
