# encoding: utf-8
require File.join(File.dirname(__FILE__), 'lib', 'graphene', 'version')

Gem::Specification.new do |spec|
  spec.name = 'graphene'
  spec.version = Graphene::VERSION
  spec.summary = "Easily create stats and graphs from collections of Ruby objects"
  spec.description = "Library for calculating subtotals, percentages, tables and graphs from collections of Ruby objects"
  spec.authors = ['Jordan Hollinger']
  spec.date = '2012-11-13'
  spec.email = 'jordan@jordanhollinger.com'
  spec.homepage = 'http://github.com/jhollinger/graphene'

  spec.require_paths = ['lib']
  spec.files = [Dir.glob('lib/**/*'), 'README.rdoc', 'LICENSE'].flatten

  spec.add_dependency 'tablizer', '~> 1.0'

  spec.specification_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION if spec.respond_to? :specification_version
end
