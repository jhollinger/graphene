begin
  require 'gruff'
  require 'graphene/gruff_helpers'

  module Graphene
    class ResultSet
      include GruffHelpers
    end
  end
rescue LoadError => e
  $stderr.puts "ERROR You must install \"gruff\" to use the gruff graphing helpers!"
  raise e.class.name, e.message
end
