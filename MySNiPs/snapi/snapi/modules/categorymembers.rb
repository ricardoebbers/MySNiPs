module SNaPi
  module Modules
    module Categorymembers
      # Which category to enumerate (required). Must include the Category: prefix.
      # @param value [String]
      # @return [self]
      def title(value)
        merge(cmtitle: value.to_s)
      end

      # Which pieces of information to include:
      # Default is "ids", "title"
      # @param values [Array<String>] Allowed values: "ids" (Adds the page ID),
      # "title" (Adds the title and namespace ID of the page)
      # @return [self]
      def prop(*values)
        values.inject(self) {|res, val| res._prop(val) or raise ArgumentError, "Unknown value for prop: #{val}" }
      end

      # @private
      def _prop(value)
        defined?(super) && super || %w[ids title].include?(value.to_s) && merge(cmprop: value.to_s, replace: false)
      end

      # When more results are available, use this to continue.
      # @param value [String]
      # @return [self]
      def continue(value)
        merge(cmcontinue: value.to_s)
      end

      # The maximum number of pages to return.
      # @param value [Integer, "max"]
      # @return [self]
      def limit(value)
        merge(cmlimit: value.to_s)
      end
    end
  end
end
