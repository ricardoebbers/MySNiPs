require "json"

module SNaPi
  class Response
    Error = Class.new(RuntimeError)
    METADATA_KEYS = %w[error warnings batchcomplete continue success limits].freeze

    def self.parse(action, response_body)
      new(action, JSON.parse(response_body))
    end

    # Entire response "as is", including contents and metadata parts.
    # See {#to_h} for content part of the response and {#metadata} for metadata part.
    # @return [Hash]
    attr_reader :raw

    # Metadata part of the response, keys like "error", "warnings", "continue".
    # See {#to_h} for content part of the response and {#raw} for entire response.
    # @return [Hash]
    attr_reader :metadata

    def initialize(action, response_hash)
      @action = action
      @raw = response_hash.freeze
      @metadata, @data = response_hash.partition {|key, _| METADATA_KEYS.include?(key) }.map(&:to_h).map(&:freeze)
      error! if @metadata["error"]
    end

    # @return [Hash]
    def to_h
      @data.key?(@action.name) ? @data.fetch(@action.name) : @data
    end

    # @param key [String] Key name.
    def [](key)
      to_h[key]
    end

    # Returns `true` if there is next pages of response.
    def continue?
      @metadata.key?("continue")
    end

    # Continues current request and returns current & next pages merged.
    # @return [Response]
    def continue(cmcontinue = nil)
      raise "This is the last page" unless continue?

      cmcontinue = @metadata.fetch("continue") if cmcontinue.nil?

      action = @action.merge(cmcontinue)
      self.class.new(action, JSON.parse(action.perform))
    end

    # @return [String]
    def inspect
      "#<#{self.class.name}(#{@action.name}): #{to_h.keys.join(', ')}#{' (can continue)' if continue?}>"
    end

    def error!
      @metadata["error"]
    end

    def hash_dig(hash, *keys)
      keys.inject(hash) {|res, key| res[key] or return nil }
    end
  end
end
