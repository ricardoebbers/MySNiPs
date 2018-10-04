require_relative "./actions/base"

module SNaPi
  module Actions
    def query
      Query.new(client)
    end

    def cargoquery
      Cargoquery.new(client)
    end

    def parse
      Parse.new(client)
    end
  end
end
Dir[File.expand_path("{actions,modules}/*.rb", __dir__)].each {|f| require f }
