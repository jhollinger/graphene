# Required gems
require 'tablizer'
begin
  require 'gruff'
rescue LoadError
end

require 'graphene/version'
require 'graphene/graphene'

# Formatters and helpers
require 'graphene/tablizer'
require 'graphene/gruff'
require 'graphene/themes'

# Calculators
require 'lazy_enumerable'
require 'graphene/result_set'
require 'graphene/subtotals'
require 'graphene/percentages'
require 'graphene/over_x'
