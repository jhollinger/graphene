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
  # See LazyEnumerable, Graphene::Tablize and Graphene::TwoDGraphs for more documentation.
  # 
  # If your X objects can be put into a range, Graphene will attempt to fill in any gaps along the X axis.
  # But if they can't be ranged (e.g. formatted strings), you have several options to fill them in yourself:
  # 
  #  Graphene.percentages(logs, :browser).over(->(l) { l.date.strftime('%B %Y') }, [an array of all month/year in the logs])
  #  Graphene.percentages(logs, :browser).over(->(l) { l.date.strftime('%B %Y') }) { |str| somehow parse the month/year and return the next one }
  # 
  class OverX
    include LazyEnumerable
    include TwoDGraphs

    # The attribute that are being statted, passed in the constructor
    attr_reader :result_set

    # Accepts a ResultSet object (i.e. Graphene::Subtotals or Graphene::Percentages), and a
    # method symbol or proc/lambda to build the X axis
    def initialize(result_set, attr_or_lambda, filler=nil, &filler_block)
      @result_set = result_set
      @attribute = attr_or_lambda
      @filler = filler_block || filler
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
      # Group all the objects by X
      resources_by_x = result_set.resources.group_by(&@attribute).sort_by(&:first)
      # Attempt to retrieve or calculate all possible X points, so there are no gaps
      x_points_hash = Hash[x_points(resources_by_x).map { |x| [x, []] }]
      # Distribute the objects across the X points
      @results = resources_by_x.inject(x_points_hash) do |results, (x, group)|
        results[x] ||= []
        results[x] += result_set.class.new(group, *result_set.attributes).to_a
        results
      end
    end

    # Returns an array of all pre-calculated (or provided) X points. Attempts to fill in any gaps.
    def x_points(resources_by_x)
      first_x = resources_by_x.first ? resources_by_x.first.first : nil
      last_x = resources_by_x.last ? resources_by_x.last.first : nil

      # A range from the first to last point (multi-char strings are excluded, because a range of those is usually not what you want)
      if @filler.nil? and first_x.respond_to? :succ and first_x.respond_to? :"<=>" and (!first_x.is_a?(String) or first_x.size == 1)
        (first_x..last_x).to_a
      # An array
      elsif @filler.respond_to? :to_a
        @filler.to_a
      # A block
      elsif @filler.respond_to? :call
        keys = resources_by_x.map(&:first)
        keys.each_with_index.to_a.inject([]) do |points, (key, i)|
          points << key
          # Fill in any gaps between this point and the next
          if next_available_key = keys[i+1]
            next_calculated_key = key
            while next_calculated_key != next_available_key
              # Try to prevent an infinite loop if someone does something dumb
              if next_calculated_key.respond_to? :"<"
                break unless next_calculated_key < next_available_key
              end
              points << next_calculated_key
              next_calculated_key = @filler.call(next_calculated_key) 
            end
          end
          points
        end
      # Can't do it, so there may be gaps
      else
        []
      end
    end
  end
end
