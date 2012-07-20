require 'date'
require 'rspec'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib/'
require 'graphene'

RSpec.configure do |c|
  c.mock_with :rspec
end

# Build test data
Struct.new('Browser', :browser, :platform, :date)
HITS = []
HIT = ->(browser, platform, date) { HITS << Struct::Browser.new(browser, platform, Date.parse(date)) }

20.times { HIT['Internet Explorer', 'Windows', '2011-05-04'] }
19.times { HIT['Android', 'Android', '2011-05-04'] }
5.times  { HIT['Firefox', 'GNU/Linux', '2011-05-04'] }
2.times  { HIT['Firefox', 'OS X', '2011-05-05'] }
2.times  { HIT['Safari', 'iOS', '2011-05-04'] }
1.times  { HIT['Chromium', 'GNU/Linux', '2012-07-15'] }
1.times  { HIT['Epiphany', 'GNU/Linux', '2012-07-16'] }
