require File.dirname(__FILE__) + '/spec_helper'

describe Graphene do
  it 'should calculate subtotals' do
    stats = Graphene.subtotals(HITS, :browser)
    answer = [["Internet Explorer", 20],
              ["Android", 19],
              ["Firefox", 7],
              ["Safari", 2],
              ["Chromium", 1],
              ["Epiphany", 1]]
    stats.should == answer
  end

  it 'should calculate percentages' do
    stats = Graphene.percentages(HITS, :browser, :platform)
    answer = [["Internet Explorer", "Windows", 40.0],
              ["Android", "Android", 38.0],
              ["Firefox", "GNU/Linux", 10.0],
              ["Safari", "iOS", 4.0],
              ["Firefox", "OS X", 4.0],
              ["Chromium", "GNU/Linux", 2.0],
              ["Epiphany", "GNU/Linux", 2.0]]
    stats.should == answer
  end

  it 'should calculate percentages' do
    stats = Graphene.percentages(HITS, ->(h) { h.browser }, :platform)
    answer = [["Internet Explorer", "Windows", 40.0],
              ["Android", "Android", 38.0],
              ["Firefox", "GNU/Linux", 10.0],
              ["Safari", "iOS", 4.0],
              ["Firefox", "OS X", 4.0],
              ["Chromium", "GNU/Linux", 2.0],
              ["Epiphany", "GNU/Linux", 2.0]]
    stats.should == answer
  end

  it 'should ignore stats below the threshold' do
    stats = Graphene.percentages(HITS, :browser, :platform, :threshold => 3.0)
    answer = [["Internet Explorer", "Windows", 40.0],
            ["Android", "Android", 38.0],
            ["Firefox", "GNU/Linux", 10.0],
            ["Safari", "iOS", 4.0],
            ["Firefox", "OS X", 4.0]]
    stats.should == answer
  end
end
