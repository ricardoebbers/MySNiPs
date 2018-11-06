class JsonWebToken
  class << self
    def encode(payload, exp = 720.hours.from_now)
      puts "B"
      payload[:exp] = exp.to_i
      JWT.encode(payload, "masterkey")
    end

    def decode(token)
      body = JWT.decode(token, "masterkey")[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end
