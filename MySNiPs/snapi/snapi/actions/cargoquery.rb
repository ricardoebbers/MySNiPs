module SNaPi
  module Actions
    class Cargoquery < SNaPi::Actions::Get
      # @return [self]
      def where_rsid(value)
        merge(where: "rsid=" + value.to_s, replace: true)
      end

      def where_iid(value)
        merge(where: "iid=" + value.to_s, replace: true)
      end

      # @return [self]
      def rsnum
        merge(tables: "Rsnum")
      end

      # Which pieces of information to include
      # It is necessary to have at least one
      # @return [self]
      def fields(*values)
        values.inject(self) {|res, val| res._fields(val) or raise ArgumentError, "Unknown value for field: #{val}" }
      end

      def _fields(value)
        defined?(super) && super || %w[
          Gene Chromosome position Orientation
          StabilizedOrientation GMAF Gene_s geno1 geno2 geno3
        ].include?(value.to_s) && mergec(fields: value.to_s, separator: ",", replace: false)
      end
    end
  end
end
