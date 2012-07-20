module Graphene
  # A generic class for Graphene stat result sets, which includes Enumerable.
  # Calculations are performed lazily, so ResultSet objects are *cheap to create, but not necessarily cheap to use*.
  class ResultSet
    include Enumerable
    # The options Hash passed in the constructor
    attr_reader :options
    # The attribute(s) that are being statted, passed in the constructor
    attr_reader :attributes
    # The original array of objects from which the stats were generated
    attr_reader :resources

    # Accepts an array of objects, and an unlimited number of method symbols (which sould be methods in the objects).
    # Optionally accepts an options hash as a last argument.
    #
    # Implements Enumerable, so the results can be accessed by any of those methods, including each and to_a.
    def initialize(resources, *args)
      @options = args.last.is_a?(Hash) ? args.pop : {}
      @attributes = args
      @resources = resources
      @results = []
    end

    # Implements the "each" method required by Enumerable.
    def each(&block)
      lazy_calculate!
      @results.each &block
    end

    # Returns a string representation of the results
    def to_s
      to_a.to_s
    end

    # Tests equality between this and another set
    def ==(other)
      lazy_calculate!
      @results == other.to_a
    end

    # Tests equality between this and another set
    def ===(other)
      lazy_calculate!
      @results === other.to_a
    end

    private

    # Run the calculation if it hasn't already been
    def lazy_calculate!
      calculate! if @results.empty?
    end
  end
end
