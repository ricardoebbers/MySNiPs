class JsonWebToken
  class << self
    def encode(payload, exp = 72.hours.from_now)
      puts "B"
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.credentials.key)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.credentials.key)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end
