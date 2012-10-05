require 'date'
require 'rspec'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib/'
require 'graphene'

RSpec.configure do |c|
  c.mock_with :rspec
end

# Build test data
Struct.new('Browser', :browser, :platform, :date)
$hits = []
hit = ->(browser, platform, date) { $hits << Struct::Browser.new(browser, platform, Date.parse(date)) }

20.times { hit['Internet Explorer', 'Windows', '2012-06-30'] }
19.times { hit['Android', 'Android', '2012-06-30'] }
5.times  { hit['Firefox', 'GNU/Linux', '2012-06-30'] }
2.times  { hit['Firefox', 'OS X', '2012-07-02'] }
2.times  { hit['Safari', 'iOS', '2012-06-30'] }
1.times  { hit['Chromium', 'GNU/Linux', '2012-07-10'] }
1.times  { hit['Epiphany', 'GNU/Linux', '2012-07-12'] }
