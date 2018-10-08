module SNaPi
  module Actions
    class Parse < SNaPi::Actions::Get
      # Parse the content of this page.
      # @param value [String]
      # @return [self]
      def page(value)
        merge(page: value.to_s)
      end

      # Parse the content of this page. Overrides page.
      # @param value [Integer]
      # @return [self]
      def pageid(value)
        merge(pageid: value.to_s)
      end

      # Which pieces of information to get:
      # @return [self]
      def prop(*values)
        values.inject(self) {|res, val| res._prop(val) or raise ArgumentError, "Unknown value for prop: #{val}" }
      end

      def _prop(value)
        defined?(super) && super || %w[revid displaytitle wikitext].include?(value.to_s) &&
        merge(prop: value.to_s, replace: false)
      end
    end
  end
end
