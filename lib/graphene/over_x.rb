module Graphene
  # Groups the stats of resources by the given method symbol or lambda.
  # 
  # Example by date
  # 
  #  Graphene.percentages(logs, :browser).over(:date)
  #  => {#<Date: 2012-07-22> => [["Firefox", 45], ["Chrome", 40], ["Internet Explorer", 15]],
  #      #<Date: 2012-07-23> => [["Firefox", 41], ["Chrome", 40], ["Internet Explorer", 19]],
  #      #<Date: 2012-07-24> => [["Chrome", 50], ["Firefox", 40], ["Internet Explorer", 10]]}
  #
  # See Graphene::LazyEnumerable, Graphene::Tablize and Graphene::TwoDGraphs for more documentation.
  class OverX
    include LazyEnumerable
    include TwoDGraphs

    # The attribute that are being statted, passed in the constructor
    attr_reader :result_set

    # Accepts a ResultSet object (i.e. Graphene::Subtotals or Graphene::Percentages), and a
    # method symbol or proc/lambda to build the X axis
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
