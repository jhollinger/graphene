module Graphene
  # Extends the calculators with chart/graph generators. Requires the Ruby "gruff" gem.
  module GruffHelpers
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
      chart(Gruff::Pie.new, path, title, &block)
    end

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
      chart(Gruff::Bar.new, path, title, false, &block)
    end

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
      chart(Gruff::StackedBar.new, path, title, true, &block)
    end

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
      chart(Gruff::SideBar.new, path, title, true, &block)
    end

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
      chart(Gruff::SideStackedBar.new, path, title, true, &block)
    end

    # Returns a Gruff::Line object with the stats set.  # 
    # "x_method" should be a method on "resources" a lambda that accepts a resource and returns a
    # value for the x axis.
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
    #  Graphene.percentages(logs, :browser).line_graph(:date, '/path/to/browser-share.png', 'Browser Share')
    #
    # Example 2:
    #
    #  Graphene.subtotals(logs, :browser).line_graph(:date, '/path/to/browser-share.png') do |chart, labeler|
    #    chart.title = 'Browser Share'
    #    chart.font = '/path/to/font.ttf'
    #    chart.theme = pie.theme_37signals
    #  end
    #
    # Example 3:
    #
    #  Graphene.subtotals(logs, :browser).line_graph(:date, '/path/to/browser-share.png') do |chart, labeler|
    #    chart.title = 'Browser Share'
    #
    #    # Both the 10 and the block are optional.
    #    #  - "10" means that only every 10'th label will be printed. Otherwise, each would be.
    #    #  - The block is passed each label (the return value of "x_method") and may return a formatted version.
    #    labeler.call(10) do |date|
    #      date.strftime('%m/%d/%Y')
    #    end
    #  end
    #
    # Example 4:
    #
    #  Graphene.percentages(logs, :platform, :browser).line_graph(->(l) { l.date.strftime('%m/%Y') }, '/path/to/os-browser-share.png', 'OS / Browser Share by Month')
    #
    def line_graph(x_method, path=nil, title=nil)
      chart = Gruff::Line.new
      chart.title = title unless title.nil?

      # Create an empty array for each group (e.g. {"Firefox" => [], "Safari" => []})
      data = resources.map { |r| attributes.map { |attr| attr.respond_to?(:call) ? attr.call(r) : r.send(attr) } }.uniq.inject({}) do |dat, attrs|
        dat[attrs] = []
        dat
      end

      # Group the data on the x axis
      resources_by_x = resources.group_by(&x_method)
      for group in resources_by_x.sort_by(&:first).map(&:last)
        stats = self.class.new(group, *attributes).group_by { |result| result[0..attributes.size-1] }
        # Record how many from each group (e.g. Firefox, Safari) fall on this point of the x axis (e.g. date)
        for attrs, dat in data
          dat << (stats[attrs] ? stats[attrs][0][1] : 0)
        end
      end

      # Build the labeling proc
      label_every_n, labeler = 1, :to_s.to_proc
      get_labeler = proc do |n=1, &block|
        label_every_n = n
        labeler = block if block
      end
      yield(chart, get_labeler) if block_given?
      # Build labels and add them to chart
      labels = resources_by_x.keys
      chart.labels = Hash[*labels.select { |x| labels.index(x) % label_every_n == 0 }.map { |x| [*labels.index(x), labeler[x]] }.flatten]

      # Add data to the chart
      data.each { |attrs, dat| chart.data attrs.join(' / '), dat }

      chart.write(path) unless path.nil?
      chart
    end

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
end
