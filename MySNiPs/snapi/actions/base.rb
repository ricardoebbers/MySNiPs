require_relative "../response"

module SNaPi
  module Actions
    class Base
      attr_reader :client
      def initialize(client, options={})
        @client = client
        @params = stringify_hash(options)
        @submodules = []
      end

      # Make new action, with additional params passed as `hash`. No params validations are made.
      # @param hash [Hash] Params to merge. All keys and values would be stringified.
      # @return [Action] Produced action of the same type as current action was, with all passed
      #   params applied.
      def merge(hash, separator="|")
        replace = hash.fetch(:replace, true)
        hash.delete(:replace)
        self.class
            .new(@client, @params.merge(stringify_hash(hash)) {|_, o, n| replace ? n : [o, n].compact.uniq.join(separator) })
            .tap {|action| @submodules.each {|sm| action.submodule(sm) } }
      end

      # Temporary cheap solution because of lack of patience for strange bug
      # Please ignore :)
      def mergec(hash, separator=",")
        replace = hash.fetch(:replace, true)
        hash.delete(:replace)
        self.class
            .new(@client, @params.merge(stringify_hash(hash)) {|_, o, n| replace ? n : [o, n].compact.uniq.join(separator) })
            .tap {|action| @submodules.each {|sm| action.submodule(sm) } }
      end

      # All action's params in a ready to passing to URL form (string keys & string values).
      # @return [Hash{String => String}]
      def to_h
        @params.dup
      end

      # Action's name on MediaWiki API ("query" for `Query` action)
      # @return [String]
      def name
        self.class.name.split("::").last.gsub(/([a-z])([A-Z])/, '\1-\2').downcase or
          raise ArgumentError, "#{self.class.name} is an invalid name"
      end

      # All action's params in a ready to passing to URL form (string keys & string values).
      # Unlike {#to_h}, includes also action name.
      # @example
      #    api.query.titles('Rs53576').to_param
      #    # => {"titles"=>"Rs53576", "format"=>"json", "action"=>"query"}
      # @return [Hash{String => String}]
      def to_param
        to_h.merge("action" => name)
      end

      # Performs action and returns an instance of {Response}. It is a wrapper around parsed
      # action's JSON response, which separates "content" and "meta" (paging, warnings/errors) fields.
      # @return [Response]
      def response
        jsonable = merge(format: "json").submodule(Modules::Json)
        Response.parse(jsonable, jsonable.perform)
      end

      private

      # Not in indepented module to decrease generated files/modules list
      def stringify_hash(hash, recursive: false)
        hash.map {|k, v|
          [k.to_s, v.is_a?(Hash) && recursive ? stringify_hash(v, recursive: true) : v.to_s]
        }.to_h
      end

      protected

      def submodule(mod)
        extend(mod)
        @submodules << mod
        self
      end
    end

    class Get < Base
      def perform
        client.get(to_param)
      end
    end
  end
end
