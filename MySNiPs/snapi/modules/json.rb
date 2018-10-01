module SNaPi
  module Modules
    module Json
      # If specified, encodes non-ASCII characters as UTF-8. Default when formatversion is not 1.
      #
      # @return [self]
      def utf8
        merge(utf8: "true")
      end

      # If specified, encodes all non-ASCII using hexadecimal escape sequences. Default when formatversion is 1.
      # @return [self]
      def ascii
        merge(ascii: "true")
      end

      # Output formatting:
      # @param value [String] One of "1" (Backwards-compatible format),
      # "2" (Experimental modern format. Details may change!),
      # "latest" (Use the latest format (currently 2), may change without warning).
      # @return [self]
      def formatversion(value)
        _formatversion(value) or raise ArgumentError, "Unknown value for formatversion: #{value}"
      end

      # @private
      def _formatversion(value)
        defined?(super) && super || %w[1 2 latest].include?(value.to_s) && merge(formatversion: value.to_s)
      end
    end
  end
end
