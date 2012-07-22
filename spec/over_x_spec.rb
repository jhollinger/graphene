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
end
