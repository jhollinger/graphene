require File.dirname(__FILE__) + '/spec_helper'
require 'digest/md5'

if defined? Gruff
  describe Graphene do
    before :each do
      @file_path = '/tmp/double_agent_graph_test.png'
      @md5 = ->(path) { Digest::MD5.hexdigest(File.read(path)) }
    end

    after :each do
      File.unlink(@file_path) if File.exists? @file_path
    end

    it 'should write a simple pie chart' do
      Graphene.percentages(HITS, :browser).pie_chart(@file_path, 'Browser Share')
      @md5[@file_path].should == 'c58e8724efe6f94e421e78a19fd51c6b'
    end

    it 'should write a complex pie chart' do
      Graphene.percentages(HITS, :browser).pie_chart(@file_path) do |pie|
        pie.title = 'Browser Share'
      end
      @md5[@file_path].should == 'c58e8724efe6f94e421e78a19fd51c6b'
    end

    it 'should write a simple multiline graph' do
      Graphene.percentages(HITS, :browser).line_graph(:date, @file_path, 'Browser Share')
      @md5[@file_path].should == '4eddcafdbdd6b2936bfaade1b72990a6'
    end

    it 'should write a simple multiline graph using subtotals instead of percentages' do
      Graphene.subtotals(HITS, :browser).line_graph(:date, @file_path, 'Browser Share')
      @md5[@file_path].should == 'b895e0427199791db53667d3465f28ca'
    end

    it 'should write a formatted line graph' do
      Graphene.percentages(HITS, :browser).line_graph(:date, @file_path, 'Browser Share') do |chart, labeler|
        chart.theme = chart.theme_odeo

        labeler.call(2) do |date|
          date.strftime('%m/%d/%Y')
        end
      end
      @md5[@file_path].should == '9e05efd35cb8ff361dfc20ee6a0d62e0'
    end

    it 'should write a monthly line graph' do
      Graphene.percentages(HITS, :browser).line_graph(->(e) { e.date.strftime('%m/%Y') }, @file_path, 'Browser Share') do |chart, labeler|
        chart.theme = chart.theme_odeo
      end
      @md5[@file_path].should == '263562b4e4eacbe283958116c7072c0d'
    end

    it 'should write a simple bar graph' do
      Graphene.subtotals(HITS, :browser).bar_chart(@file_path, 'Browser Numbers')
      @md5[@file_path].should == '9e7c663c9f4f19030508d415bc9a1b04'
    end

    it 'should write a more complicated bar graph' do
      Graphene.subtotals(HITS, :browser, :platform).bar_chart(@file_path) do |chart|
        chart.title = 'Browser / OS Numbers'
      end
      @md5[@file_path].should == 'b40823b3b2e54a95057242d9ded34bee'
    end

    it 'should write a bar graph using percents' do
      Graphene.percentages(HITS, :browser).bar_chart(@file_path, 'Browser % Shares')
      @md5[@file_path].should == '5dbee13f6b214043724e729de79de00f'
    end
  end
else
  $stderr.puts "Graphing cannot be tested because Gruff could not be loaded"
end
