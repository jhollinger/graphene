require File.dirname(__FILE__) + '/spec_helper'
require 'digest/md5'

if defined? Gruff
  describe Graphene do
    before :each do
      @file_path = '/tmp/gruff_graph_test.png'
      @md5 = ->(path) { Digest::MD5.hexdigest(File.read(path)) }
    end

    after :each do
      File.unlink(@file_path) if File.exists? @file_path
    end

    it 'should write a simple pie chart' do
      Graphene.percentages($hits, :browser).pie_chart(@file_path, 'Browser Share')
      @md5[@file_path].should == 'c58e8724efe6f94e421e78a19fd51c6b'
    end

    it 'should write a complex pie chart' do
      Graphene.percentages($hits, :browser).pie_chart(@file_path) do |pie|
        pie.title = 'Browser Share'
      end
      @md5[@file_path].should == 'c58e8724efe6f94e421e78a19fd51c6b'
    end

    it 'should write a simple multiline graph' do
      Graphene.percentages($hits, :browser).over(:date).line_graph(@file_path, 'Browser Share') { |chart, labeler| labeler.call(3) }
      @md5[@file_path].should == 'e9566b380c011ed7c1bd5bebab0e0fa5'
    end

    it 'should write a simple multiline graph using subtotals instead of percentages' do
      Graphene.subtotals($hits, :browser).over(:date).line_graph(@file_path, 'Browser Share') { |chart, labeler| labeler.call(3) }
      @md5[@file_path].should == '4f09c132d4ce4bbd971dfc5e28a91a8d'
    end

    it 'should write a formatted line graph' do
      Graphene.percentages($hits, :browser).over(:date).line_graph(@file_path, 'Browser Share') do |chart, labeler|
        chart.theme = chart.theme_odeo

        labeler.call(2) do |date|
          date.strftime('%m/%d/%Y')
        end
      end
      @md5[@file_path].should == '6c8b2ebdd10830d647039c877b0b2ac6'
    end

    it 'should write a monthly line graph' do
      Graphene.percentages($hits, :browser).over(->(e) { e.date.strftime('%m/%Y') }).line_graph(@file_path, 'Browser Share') do |chart, labeler|
        chart.theme = chart.theme_odeo
      end
      @md5[@file_path].should == 'a79e0c98171f57cf555bf4be3ec07d19'
    end

    it 'should write a net graph using percentages' do
      Graphene.percentages($hits, :browser).over(:date).net_graph(@file_path, 'Browser Shares')
      @md5[@file_path].should == 'd3dabc7b1e01966b4246dcdec39fe4c4'
    end

    it 'should write a simple dot graph' do
      Graphene.percentages($hits, :browser).over(:date).dot_graph(@file_path, 'Browser Share')
      @md5[@file_path].should == 'b14815cdaf44bbda831fc536f5e92401'
    end

    it 'should write a simple dot graph' do
      Graphene.subtotals($hits.select { |h| h.browser == 'Firefox' }, :browser).over(:date).accumulator_bar_graph(@file_path, 'Firefox Share')
      @md5[@file_path].should == '99d6bf407c50cd237b22d77aee9da3a1'
    end

    it 'should write a simple bar graph' do
      Graphene.subtotals($hits, :browser).bar_chart(@file_path, 'Browser Numbers')
      @md5[@file_path].should == '9e7c663c9f4f19030508d415bc9a1b04'
    end

    it 'should write a more complicated bar graph' do
      Graphene.subtotals($hits, :browser, :platform).bar_chart(@file_path) do |chart|
        chart.title = 'Browser / OS Numbers'
      end
      @md5[@file_path].should == 'b40823b3b2e54a95057242d9ded34bee'
    end

    it 'should write a bar graph using percents' do
      Graphene.percentages($hits, :browser).bar_chart(@file_path, 'Browser % Shares')
      @md5[@file_path].should == '5dbee13f6b214043724e729de79de00f'
    end

    it 'should write a stacked bar graph using percents' do
      Graphene.percentages($hits, :browser).stacked_bar_chart(@file_path, 'Browser % Shares')
      @md5[@file_path].should == 'eae4eb2a780a0156a986099dbccf632c'
    end

    it 'should write a side bar graph using subtotals' do
      Graphene.subtotals($hits, :browser).side_bar_chart(@file_path, 'Browser Shares')
      @md5[@file_path].should == '0f06544c311cba1be66f705f052b8374'
    end

    it 'should write a stacked side bar graph using subtotals' do
      Graphene.subtotals($hits, :browser).side_stacked_bar_chart(@file_path, 'Browser Shares')
      @md5[@file_path].should == 'dcdc1d1c7938f0d6c4c93a70a9677f59'
    end

    it 'should write a spider chart using subtotals' do
      Graphene.subtotals($hits, :browser).spider_chart(@file_path, 'Browser Shares')
      @md5[@file_path].should == '9aaa22a4ac06b0932343aaf9151c75c2'
    end
  end
else
  $stderr.puts "Graphing cannot be tested because Gruff could not be loaded"
end
