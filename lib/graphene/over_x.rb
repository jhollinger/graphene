module Graphene
  # Groups the stats of resources by the given attribute.
  #
  # See Graphene::LazyEnumerable, Graphene::Tablize and Graphene::Graphs for more documentation.
  class OverX
    include LazyEnumerable
    include Graphs

    # The attribute that are being statted, passed in the constructor
    attr_reader :result_set

    def initialize(result_set, attr_or_lambda)
      @result_set = result_set
      @attribute = attr_or_lambda
      @results = {}
    end

    # Returns a string representation of the results
    def to_s
      to_hash.to_s
    end

    # Returns a Hash representation of the results
    def to_hash
      @results.clone
    end

    private

    # Run the calculation
    def enumerate!
      resources_by_x = result_set.resources.group_by(&@attribute).sort_by(&:first)
      @results = resources_by_x.inject({}) do |results, (x, group)|
        results[x] ||= []
        results[x] += result_set.class.new(group, *result_set.attributes).to_a
        results
      end
    end
  end
end
