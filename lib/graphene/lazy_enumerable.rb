module Graphene
  # Includes Enumerable and xalculates @results lazily. An enumerate! method must be implemented.
  module LazyEnumerable
    def self.included(base)
      base.send(:include, Enumerable)
    end

    # Implements the "each" method required by Enumerable.
    def each(&block)
      lazily_enumerate!
      @results.each &block
    end

    # Tests equality between this and another set
    def ==(other)
      lazily_enumerate!
      to_a == other.to_a
    end

    # Tests equality between this and another set
    def ===(other)
      lazily_enumerate!
      to_a === other.to_a
    end

    private

    # Run the calculation if it hasn't already been
    def lazily_enumerate!
      enumerate! if @results.empty?
    end
  end
end
