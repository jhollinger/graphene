require 'graphene/subtotals'

module Graphene
  # Calculates and contains the percent subtotals of each attr (or attr group). Inherits from Graphene::ResultSet.
  # See Graphene::LazyEnumerable, Graphene::Tablize and Graphene::OneDGraphs for more documentation.
  # 
  # If you passed an options Hash containing :threshold to the constructor, 
  # any results falling below it will be excluded.
  # 
  # Don't create instance manually. Instead, use the Graphene.percentages method, which will return
  # a properly instantiated object.
  class Percentages < ResultSet
    # Convert the percentages to subtotals
    def subtotals(opts=nil)
      @subtotals ||= transmogrify(Subtotals, opts)
    end

    private

    # Perform the calculations
    def enumerate!
      # Now replace them with the percentages
      total = resources.size.to_f
      # Replace the subtotal with the percent
      @results = subtotals.map do |*args, count|
        percent = ((count * 100) / total).round(2)
        [*args, percent]
      end

      # Drop results that are too small
      if options.has_key? :threshold
        @results.reject! { |result| result[-1] < options[:threshold] }
      end
    end
  end
end
