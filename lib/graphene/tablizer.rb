require 'tablizer'
require 'graphene/result_set'
require 'graphene/subtotals'
require 'graphene/percentages'

module Graphene
  class ResultSet
    # Return the results formatted by the tablizer gem. Do disable headers, pass :header => false. Set alignment with :align.
    def tablize(options={})
      rows = to_a
      # Default to including headers
      unless options[:header] == false
        rows.unshift(tablizer_headers)
        options[:header] = true
      end
      Tablizer::Table.new(rows, options)
    end

    private

    # The headers for tablizer
    def tablizer_headers
      attributes.map(&:to_s)
    end
  end

  class Subtotals < ResultSet
    private

    # The headers for tablizer
    def tablizer_headers
      super << 'Subtotal'
    end
  end

  class Percentages < Subtotals
    private

    # The headers for tablizer
    def tablizer_headers
      super.insert(-2, 'Percentage')
    end
  end
end
