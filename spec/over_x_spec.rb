require File.dirname(__FILE__) + '/spec_helper'

describe Graphene do
  it 'should calculate subtotals over dates' do
    stats = Graphene.subtotals($hits, :browser).over(:date)
    answer = {
      Date.parse('2012-05-04') => [["Internet Explorer", 20], ["Android", 19], ["Firefox", 5], ["Safari", 2]],
      Date.parse('2012-05-05') => [["Firefox", 2]],
      Date.parse('2012-07-15') => [["Chromium", 1]],
      Date.parse('2012-07-16') => [["Epiphany", 1]]
    }
    stats.should == answer
  end

  it 'should fill in missing X points using an array or range' do
    stats = Graphene.subtotals($hits, :browser).over(:date, (Date.new(2012, 5, 4)..Date.new(2012, 7, 16)))
    stats.should == FILLED_IN_ANSWER
  end

  it 'should fill in missing X points using a lambda' do
    stats = Graphene.subtotals($hits, :browser).over(:date, ->(date) { date + 1 })
    stats.should == FILLED_IN_ANSWER
  end

  it 'should fill in missing X points using a block' do
    stats = Graphene.subtotals($hits, :browser).over(:date) { |date| date + 1 }
    stats.should == FILLED_IN_ANSWER
  end
end

FILLED_IN_ANSWER = {
  Date.new(2012,5,04) => [["Internet Explorer", 20], ["Android", 19], ["Firefox", 5], ["Safari", 2]],
  Date.new(2012,5,05) => [["Firefox", 2]],
  Date.new(2012,5,06) => [],
  Date.new(2012,5,07) => [],
  Date.new(2012,5,8) => [],
  Date.new(2012,5,9) => [],
  Date.new(2012,5,10) => [],
  Date.new(2012,5,11) => [],
  Date.new(2012,5,12) => [],
  Date.new(2012,5,13) => [],
  Date.new(2012,5,14) => [],
  Date.new(2012,5,15) => [],
  Date.new(2012,5,16) => [],
  Date.new(2012,5,17) => [],
  Date.new(2012,5,18) => [],
  Date.new(2012,5,19) => [],
  Date.new(2012,5,20) => [],
  Date.new(2012,5,21) => [],
  Date.new(2012,5,22) => [],
  Date.new(2012,5,23) => [],
  Date.new(2012,5,24) => [],
  Date.new(2012,5,25) => [],
  Date.new(2012,5,26) => [],
  Date.new(2012,5,27) => [],
  Date.new(2012,5,28) => [],
  Date.new(2012,5,29) => [],
  Date.new(2012,5,30) => [],
  Date.new(2012,5,31) => [],
  Date.new(2012,6,01) => [],
  Date.new(2012,6,02) => [],
  Date.new(2012,6,03) => [],
  Date.new(2012,6,04) => [],
  Date.new(2012,6,05) => [],
  Date.new(2012,6,06) => [],
  Date.new(2012,6,07) => [],
  Date.new(2012,6,8) => [],
  Date.new(2012,6,9) => [],
  Date.new(2012,6,10) => [],
  Date.new(2012,6,11) => [],
  Date.new(2012,6,12) => [],
  Date.new(2012,6,13) => [],
  Date.new(2012,6,14) => [],
  Date.new(2012,6,15) => [],
  Date.new(2012,6,16) => [],
  Date.new(2012,6,17) => [],
  Date.new(2012,6,18) => [],
  Date.new(2012,6,19) => [],
  Date.new(2012,6,20) => [],
  Date.new(2012,6,21) => [],
  Date.new(2012,6,22) => [],
  Date.new(2012,6,23) => [],
  Date.new(2012,6,24) => [],
  Date.new(2012,6,25) => [],
  Date.new(2012,6,26) => [],
  Date.new(2012,6,27) => [],
  Date.new(2012,6,28) => [],
  Date.new(2012,6,29) => [],
  Date.new(2012,6,30) => [],
  Date.new(2012,7,01) => [],
  Date.new(2012,7,02) => [],
  Date.new(2012,7,03) => [],
  Date.new(2012,7,04) => [],
  Date.new(2012,7,05) => [],
  Date.new(2012,7,06) => [],
  Date.new(2012,7,07) => [],
  Date.new(2012,7,8) => [],
  Date.new(2012,7,9) => [],
  Date.new(2012,7,10) => [],
  Date.new(2012,7,11) => [],
  Date.new(2012,7,12) => [],
  Date.new(2012,7,13) => [],
  Date.new(2012,7,14) => [],
  Date.new(2012,7,15) => [["Chromium", 1]],
  Date.new(2012,7,16) => [["Epiphany", 1]]
}
