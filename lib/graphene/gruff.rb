module Graphene
  # Executes the given block if Gruff is available. Raises a GrapheneException if not.
  def self.gruff
    if defined? Gruff
      yield if block_given?
    else
      raise GrapheneException, "Gruff integration is disabled because Gruff could not be loaded; install the \"gruff\" gem"
    end
  end

  # Extends calculators with chart generators. Requires the Ruby "gruff" gem. 
  # A "chart" in this sense is collections of label:number pairs.
  module Charts
    # Returns a Gruff::Pie object with the stats set.
    #
    # Optionally you may pass a file path and graph title. If you pass a file path, the graph will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned graph object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::Pie object before it is
    # written to file (that is, if you also passed a file path).
    # 
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).pie_chart('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.percentages(logs, :browser).pie_chart('/path/to/browser-share.png') do |pie|
    #    pie.title = 'Browser Share'
    #    pie.font = '/path/to/font.ttf'
    #    pie.theme = pie.theme_37signals
    #  end
    # 
    # Example 3:
    # 
    #  blog = Graphene.percentages(logs, :browser).pie_chart.to_blob
    #
    def pie_chart(path=nil, title=nil, &block)
      Graphene.gruff do
        chart(Gruff::Pie.new, path, title, &block)
      end
    end
    alias_method :pie_graph, :pie_chart

    # Returns a Gruff::Bar object with the stats set.
    #
    # Optionally you may pass a file path and chart title. If you pass a file path, the chart will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned chart object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::Bar object before it is
    # written to file (that is, if you also passed a file path).
    # 
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).bar_chart('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.percentages(logs, :browser).bar_chart('/path/to/browser-share.png') do |chart|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = chart.theme_37signals
    #  end
    # 
    # Example 3:
    # 
    #  blog = Graphene.subtotals(logs, :browser).bar_chart.to_blob
    #
    def bar_chart(path=nil, title=nil, &block)
      Graphene.gruff do
        chart(Gruff::Bar.new, path, title, false, &block)
      end
    end
    alias_method :bar_graph, :bar_chart

    # Returns a Gruff::StackedBar object with the stats set.
    #
    # Optionally you may pass a file path and chart title. If you pass a file path, the chart will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned chart object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::StackedBar object before it is
    # written to file (that is, if you also passed a file path).
    # 
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).stacked_bar_chart('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.percentages(logs, :browser).stacked_bar_chart('/path/to/browser-share.png') do |chart|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = chart.theme_37signals
    #  end
    # 
    # Example 3:
    # 
    #  blog = Graphene.subtotals(logs, :browser).stacked_bar_chart.to_blob
    #
    def stacked_bar_chart(path=nil, title=nil, &block)
      Graphene.gruff do
        chart(Gruff::StackedBar.new, path, title, true, &block)
      end
    end
    alias_method :stacked_bar_graph, :stacked_bar_chart

    # Returns a Gruff::SideBar object with the stats set.
    #
    # Optionally you may pass a file path and chart title. If you pass a file path, the chart will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned chart object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::SideBar object before it is
    # written to file (that is, if you also passed a file path).
    # 
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).side_bar_chart('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.percentages(logs, :browser).side_bar_chart('/path/to/browser-share.png') do |chart|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = chart.theme_37signals
    #  end
    # 
    # Example 3:
    # 
    #  blog = Graphene.subtotals(logs, :browser).side_bar_chart.to_blob
    #
    def side_bar_chart(path=nil, title=nil, &block)
      Graphene.gruff do
        chart(Gruff::SideBar.new, path, title, true, &block)
      end
    end
    alias_method :side_bar_graph, :side_bar_chart

    # Returns a Gruff::StackedSideBar object with the stats set.
    #
    # Optionally you may pass a file path and chart title. If you pass a file path, the chart will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned chart object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::StackedSideBar object before it is
    # written to file (that is, if you also passed a file path).
    # 
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).side_stacked_bar_chart('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.percentages(logs, :browser).side_stacked_bar_chart('/path/to/browser-share.png') do |chart|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = chart.theme_37signals
    #  end
    # 
    # Example 3:
    # 
    #  blog = Graphene.subtotals(logs, :browser).side_stacked_bar_chart.to_blob
    #
    def side_stacked_bar_chart(path=nil, title=nil, &block)
      Graphene.gruff do
        chart(Gruff::SideStackedBar.new, path, title, true, &block)
      end
    end
    alias_method :side_stacked_bar_graph, :side_stacked_bar_chart

    # Returns a Gruff::Spider object with the stats set.
    #
    # Optionally you may pass a file path and chart title. If you pass a file path, the chart will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned chart object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::Spider object before it is
    # written to file (that is, if you also passed a file path).
    # 
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).spider_chart('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.percentages(logs, :browser).spider_chart('/path/to/browser-share.png') do |chart|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = chart.theme_37signals
    #  end
    # 
    # Example 3:
    # 
    #  blog = Graphene.subtotals(logs, :browser).spider_chart.to_blob
    #
    def spider_chart(path=nil, title=nil, &block)
      Graphene.gruff do
        chart(Gruff::Spider.new(max_result), path, title, false, &block)
      end
    end
    alias_method :spider_graph, :spider_chart

    private

    # Builds a chart
    def chart(chart, path=nil, title=nil, hack=false, &block)
      chart.title = title unless title.nil?
      block.call(chart) if block

      each do |result|
        name = result[0..attributes.size-1].join(' / ')
        n = result[attributes.size]
        chart.data name, n
      end
      # XXX Required by SideBar and SideStackedBar. Probably a bug.
      chart.labels = {0 => ' '} if hack

      chart.write(path) unless path.nil?
      chart
    end
  end

  # Extends the calculators with graph generators. Requires the Ruby "gruff" gem.
  # A "graph" in this sense a collection of label:number pairs spread out over an X axis.
  module Graphs
    # Returns a Gruff::Line object with the stats set.
    #
    # Optionally you may pass a file path and graph title. If you pass a file path, the graph will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned graph object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::Line object before it is
    # written to file (that is, if you also passed a file path). It will also give you access to a Proc
    # for labeling the X axis.
    #
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).over(:date).line_graph('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.subtotals(logs, :browser).over(:date).line_graph('/path/to/browser-share.png') do |chart, labeler|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = pie.theme_37signals
    #  end
    #
    # Example 3:
    #
    #  Graphene.subtotals(logs, :browser).over(:date).line_graph('/path/to/browser-share.png') do |chart, labeler|
    #    chart.title = 'Browser Share'
    #
    #    # Both the 10 and the block are optional.
    #    #  - "10" means that only every 10'th label will be printed. Otherwise, each would be.
    #    #  - The block is passed each label (the return value of the "over attribute") and may return a formatted version.
    #    labeler.call(10) do |date|
    #      date.strftime('%m/%d/%Y')
    #    end
    #  end
    #
    # Example 4:
    #
    #  Graphene.percentages(logs, :platform, :browser).over(->(l) { l.date.strftime('%m/%Y') }).line_graph('/path/to/os-browser-share.png', 'OS / Browser Share by Month')
    #
    def line_graph(path=nil, title=nil, &block)
      Graphene.gruff do
        graph(Gruff::Line.new, path, title, &block)
      end
    end
    alias_method :line_chart, :line_graph

    # Returns a Gruff::Net object with the stats set.
    #
    # Optionally you may pass a file path and graph title. If you pass a file path, the graph will
    # be written to file automatically. Otherwise, you would call "write('/path/to/graph.png')" on the
    # returned graph object.
    #
    # If you pass a block, it will be called, giving you access to the Gruff::Net object before it is
    # written to file (that is, if you also passed a file path). It will also give you access to a Proc
    # for labeling the X axis.
    #
    # Example 1:
    # 
    #  Graphene.percentages(logs, :browser).over(:date).net_graph('/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.subtotals(logs, :browser).over(:date).net_graph('/path/to/browser-share.png') do |chart, labeler|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = pie.theme_37signals
    #  end
    #
    # Example 3:
    #
    #  Graphene.subtotals(logs, :browser).over(:date).net_graph('/path/to/browser-share.png') do |chart, labeler|
    #    chart.title = 'Browser Share'
    #
    #    # Both the 10 and the block are optional.
    #    #  - "10" means that only every 10'th label will be printed. Otherwise, each would be.
    #    #  - The block is passed each label (the return value of the "over attribute") and may return a formatted version.
    #    labeler.call(10) do |date|
    #      date.strftime('%m/%d/%Y')
    #    end
    #  end
    #
    # Example 4:
    #
    #  Graphene.percentages(logs, :platform, :browser).over(->(l) { l.date.strftime('%m/%Y') }).net_graph('/path/to/os-browser-share.png', 'OS / Browser Share by Month')
    #
    def net_graph(path=nil, title=nil, &block)
      Graphene.gruff do
        graph(Gruff::Net.new, path, title, &block)
      end
    end
    alias_method :net_chart, :net_graph

    private

    # Builds a graph
    def graph(graph, path=nil, title=nil, &block)
      graph.title = title unless title.nil?

      # Create an empty array for each group (e.g. {["Firefox"] => [], ["Safari"] => []}), even if it's empty.
      data = inject({}) do |dat, (label, rows)|
        for row in rows
          attrs = row[0..-2]
          dat[attrs] ||= []
        end
        dat
      end

      # Group the data on the x axis
      to_a.each do |x_attr, rows|
        groups = rows.group_by { |row| row[0..-2] }
        for attrs, dat in data
          dat << (groups[attrs] ? groups[attrs].last.last : 0)
        end
      end

      # Build the labeling proc
      label_every_n, labeler = 1, :to_s.to_proc
      get_labeler = proc do |n=1, &block|
        label_every_n = n
        labeler = block if block
      end
      yield(graph, get_labeler) if block_given?
      # Build labels and add them to graph
      labels = @results.keys
      graph.labels = Hash[*labels.select { |x| labels.index(x) % label_every_n == 0 }.map { |x| [*labels.index(x), labeler[x]] }.flatten]

      # Add data to the graph
      data.each { |attrs, dat| graph.data(attrs.join(' / '), dat) }

      graph.write(path) unless path.nil?
      graph
    end
  end
end
