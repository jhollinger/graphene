require 'graphene/result_set'

module Graphene
  # Calculates and contains the subtotals of each attr (or attr group). Inherits from Graphene::ResultSet.
  # See LazyEnumerable, Graphene::Tablize and Graphene::OneDGraphs for more documentation.
  # 
  # Don't create instance manually. Instead, use the Graphene.subtotals method, which will return
  # a properly instantiated object.
  class Subtotals < ResultSet
    # Convert the percentages to subtotals
    def percentages(opts=nil)
      transmogrify(Percentages, opts)
    end

    private

    # Calculates the subtotals
    def enumerate!
      # Count the occurrence of each
      results = resources.inject({}) do |res, resource|
        attrs = attributes.map { |attr| attr.respond_to?(:call) ? attr.call(resource) : resource.send(attr) }
        res[attrs] ||= 0
        res[attrs] += 1
        res
      end.to_a
      results.each(&:flatten!)
      # Sort in ascending order
      results.sort! { |a,b| b.last <=> a.last }
      @results = results
    end
  end
end
