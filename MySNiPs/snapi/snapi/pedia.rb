require_relative "./client"
require_relative "./actions"

module SNaPi
  class Pedia
    URL = "https://bots.snpedia.com/api.php".freeze
    attr_reader :client

    def initialize
      @client = Client.new(URL)
    end

    def inspect
      "#<#{self.class.name}(#{@client.url})>"
    end

    def consume
      Consume.new
    end

    include SNaPi::Actions
  end
end
