require File.dirname(__FILE__) + '/spec_helper'

describe Graphene do
  it 'should create a pretty table' do
    table = Graphene.subtotals($hits, :browser).tablize
    answer = Tablizer::Table.new([["Browser", "Subtotal"], ["Internet Explorer", "20"], ["Android", "19"], ["Firefox", "7"], ["Safari", "2"], ["Chromium", "1"], ["Epiphany", "1"]], :header => true)
    table.to_s.should == answer.to_s
  end
end
