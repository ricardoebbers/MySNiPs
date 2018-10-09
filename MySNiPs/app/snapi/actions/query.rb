module SNaPi
  module Actions
    class Query < SNaPi::Actions::Get
      # It was supposed to have a lot of commands...
      # But it turned out that we are only going to use list categorymembers
      def list
        merge(list: "categorymembers", replace: false).submodule(Modules::Categorymembers)
      end
    end
  end
end
