begin
  require 'gruff'
  require 'graphene/gruff_helpers'
rescue LoadError => e
  $stderr.puts "NOTICE Graphene cannot find Gruff; graphing will not be not available. Install the \"gruff\" gem in enable it."
end

module Graphene
  class ResultSet
    if defined? Gruff
      include GruffHelpers
    else
      def method_missing(method, *args) # :nodoc:
        if method.to_s =~ /_((chart)|(graph))$/
          raise GrapheneException, "#{self.class.name}##{method} is disabled because Gruff could not be loaded; install the \"gruff\" gem"
        else
          super
        end
      end
    end
  end
end
