require File.dirname(__FILE__) + '/spec_helper'

describe Graphene do
  it 'should calculate subtotals over dates, automatically filling in missing X points' do
    stats = Graphene.subtotals($hits, :browser).over(:date)
    stats.should == FILLED_IN_ANSWER
  end

  it 'should fill in missing X points using an array or range' do
    stats = Graphene.subtotals($hits, :browser).over(:date, (Date.new(2012, 6, 30)..Date.new(2012, 7, 12)))
    stats.should == FILLED_IN_ANSWER
  end

  it 'should fill in missing X points using a lambda' do
    stats = Graphene.subtotals($hits, :browser).over(->(hit) { hit.date }, ->(date) { date + 1 })
    stats.should == FILLED_IN_ANSWER
  end

  it 'should fill in missing X points using a block' do
    stats = Graphene.subtotals($hits, :browser).over(:date) { |date| date + 1 }
    stats.should == FILLED_IN_ANSWER
  end

  it 'should fill in missing months using an array' do
    stats = Graphene.subtotals($hits, :browser).over(->(hit) { hit.date.strftime('%B %Y') }, ['May 2012', 'June 2012', 'July 2012'])
    stats.should == {
      'May 2012' => [],
      'June 2012' => [["Internet Explorer", 20], ["Android", 19], ["Firefox", 5], ["Safari", 2]],
      'July 2012' => [["Firefox", 2],["Chromium", 1], ["Epiphany", 1]]
    }
  end
end

FILLED_IN_ANSWER = {
  Date.new(2012,6,30) => [["Internet Explorer", 20], ["Android", 19], ["Firefox", 5], ["Safari", 2]],
  Date.new(2012,7,1) => [],
  Date.new(2012,7,2) => [["Firefox", 2]],
  Date.new(2012,7,3) => [],
  Date.new(2012,7,4) => [],
  Date.new(2012,7,5) => [],
  Date.new(2012,7,6) => [],
  Date.new(2012,7,7) => [],
  Date.new(2012,7,8) => [],
  Date.new(2012,7,9) => [],
  Date.new(2012,7,10) => [["Chromium", 1]],
  Date.new(2012,7,11) => [],
  Date.new(2012,7,12) => [["Epiphany", 1]]
}
