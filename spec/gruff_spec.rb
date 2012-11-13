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
      @md5[@file_path].should == '3f5454834f257d859eccf3a0770cea3c'
    end

    it 'should write a complex pie chart' do
      Graphene.percentages($hits, :browser).pie_chart(@file_path) do |pie|
        pie.title = 'Browser Share'
      end
      @md5[@file_path].should == '3f5454834f257d859eccf3a0770cea3c'
    end

    it 'should write a simple multiline graph' do
      Graphene.percentages($hits, :browser).over(:date).line_graph(@file_path, 'Browser Share') { |chart, labeler| labeler.call(3) }
      @md5[@file_path].should == '5bba4eea614d30a0b02f829d005056a9'
    end

    it 'should write a simple multiline graph using subtotals instead of percentages' do
      Graphene.subtotals($hits, :browser).over(:date).line_graph(@file_path, 'Browser Share') { |chart, labeler| labeler.call(3) }
      @md5[@file_path].should == '0b75e8c42728d15471688e891d863a99'
    end

    it 'should write a formatted line graph' do
      Graphene.percentages($hits, :browser).over(:date).line_graph(@file_path, 'Browser Share') do |chart, labeler|
        chart.theme = chart.theme_odeo

        labeler.call(2) do |date|
          date.strftime('%m/%d/%Y')
        end
      end
      @md5[@file_path].should == '7b7b4f49064629654a7bee05e39984ef'
    end

    it 'should write a monthly line graph' do
      Graphene.percentages($hits, :browser).over(->(e) { e.date.strftime('%m/%Y') }).line_graph(@file_path, 'Browser Share') do |chart, labeler|
        chart.theme = chart.theme_odeo
      end
      @md5[@file_path].should == 'a5033b47cff43bc83541a04169ca0119'
    end

    it 'should write a net graph using percentages' do
      Graphene.percentages($hits, :browser).over(:date).net_graph(@file_path, 'Browser Shares')
      @md5[@file_path].should == 'feb1b25692c2fca82079fb68e1e433f7'
    end

    it 'should write a simple dot graph' do
      Graphene.percentages($hits, :browser).over(:date).dot_graph(@file_path, 'Browser Share')
      @md5[@file_path].should == '77cd2dd3497dcea075c33b5cd15364be'
    end

    it 'should write a accumulator bar graph' do
      Graphene.subtotals($hits.select { |h| h.browser == 'Firefox' }, :browser).over(:date).accumulator_bar_graph(@file_path, 'Firefox Share')
      @md5[@file_path].should == '8dcf7fd03ad3fb435d5e2a5b3fb0aaa2'
    end

    it 'should write a simple bar graph' do
      Graphene.subtotals($hits, :browser).bar_chart(@file_path, 'Browser Numbers')
      @md5[@file_path].should == 'e6fd73face551d7c19a559db4da7e343'
    end

    it 'should write a more complicated bar graph' do
      Graphene.subtotals($hits, :browser, :platform).bar_chart(@file_path) do |chart|
        chart.title = 'Browser / OS Numbers'
      end
      @md5[@file_path].should == 'aa1e86d65f1b1fefe0928789935b9e5e'
    end

    it 'should write a bar graph using percents' do
      Graphene.percentages($hits, :browser).bar_chart(@file_path, 'Browser % Shares')
      @md5[@file_path].should == '76437f287623a570f2bbe2055e4c959c'
    end

    it 'should write a stacked bar graph using percents' do
      Graphene.percentages($hits, :browser).stacked_bar_chart(@file_path, 'Browser % Shares')
      @md5[@file_path].should == 'af9863530863f5fb3c2ef1b4c40195da'
    end

    it 'should write a side bar graph using subtotals' do
      Graphene.subtotals($hits, :browser).side_bar_chart(@file_path, 'Browser Shares')
      @md5[@file_path].should == '00e3462cc2109a056397998ab13bf40c'
    end

    it 'should write a stacked side bar graph using subtotals' do
      Graphene.subtotals($hits, :browser).side_stacked_bar_chart(@file_path, 'Browser Shares')
      @md5[@file_path].should == '210251d6c13827ee101f00f56077c190'
    end

    it 'should write a spider chart using subtotals' do
      Graphene.subtotals($hits, :browser).spider_chart(@file_path, 'Browser Shares')
      @md5[@file_path].should == 'e7863db371373c1c6d7ad833492a70fd'
    end
  end
else
  $stderr.puts "Graphing cannot be tested because Gruff could not be loaded"
end
