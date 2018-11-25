require "addressable/uri"
require "addressable/template"
require "faraday"
require "faraday_middleware"

module SNaPi
  class Client
    AGENT = "MySNiPs/0.0.2; jrsc2@cin.ufpe.br)".freeze
    attr_reader :url

    def initialize(url)
      @url = Addressable::URI.parse(url)
      @faraday = Faraday.new(url, headers: headers) do |f|
        f.request :url_encoded
        f.use FaradayMiddleware::FollowRedirects
        f.use FaradayMiddleware::Gzip
        f.adapter Faraday.default_adapter
      end
    end

    def headers
      {"Accept-Encoding" => "gzip", "User-Agent" => AGENT}
    end

    def get(params)
      @faraday.get("", params).body
    end

    def post(params)
      @faraday.post("", params).body
    end
  end
end
