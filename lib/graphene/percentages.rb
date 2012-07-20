require 'graphene/subtotals'

module Graphene
  # Calculates and contains the percent subtotals of each attr (or attr group). Inherits from Graphene::ResultSet.
  # 
  # If you passed an options Hash containing :threshold to the constructor, 
  # any results falling below it will be excluded.
  # 
  # Don't create instance manually. Instead, use the Graphene.percentages method, which will return
  # a properly instantiated object.
  class Percentages < Subtotals
    private

    # Perform the calculations
    def calculate!
      super
      calculate_percentages!
    end

    # Calculates the percentages
    def calculate_percentages!
      total = resources.size.to_f
      # Add in the percent
      @results.map! do |*args, count|
        percent = ((count * 100) / total).round(2)
        [*args, percent, count]
      end
      # Drop results that are too small
      if options.has_key? :threshold
        @results.reject! { |result| result[-2] < options[:threshold] }
      end
    end
  end
end
