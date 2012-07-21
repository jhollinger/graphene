module Graphene
  module Tablize
    # Return the results formatted by the tablizer gem. Do disable headers, pass :header => false. Set alignment with :align.
    def tablize(options={})
      rows = to_a
      # Default to including headers
      unless options[:header] == false
        headers = attributes.map(&:to_s) << self.class.name.scan(/\w+$/).last.to_s.gsub(/s$/, '').capitalize
        rows.unshift(headers)
        options[:header] = true
      end
      Tablizer::Table.new(rows, options)
    end
  end
end
