module Graphene
  # Some themes for Gruff graphs.
  # 
  # To set a default theme for all graphs, do:
  # 
  #  Graphene.theme = Graphene::Themes.rainy_day
  # 
  # To set a theme for just one chart, do:
  # 
  #  Graphene.percentages(logs, :browser).pie_chart('/path/to/chart.png') do |chart|
  #    chart.theme = Graphene::Themes.rainy_day
  #  end
  # 
  module Themes
    class << self
      # A theme for a rainy day
      def rainy_day
        {
          colors: %w(#030C22 #E5D25F #20293F #352111 #404749 #A9B0B3),
          marker_color: '#2c2c2c',
          font_color: '#2c2c2c',
          background_colors: %w(#fff6f6 #efe6e6)
        }
      end

      # A theme for graphing eggplants
      def eggplant
        {
          colors: %w(#4d4656 #6594b2 #2f607f #2f503b #748e8d #1b3438),
          marker_color: '#444',
          font_color: '#444',
          background_colors: %w(#ccc #cdc)
        }
      end

      # Primary and secondary colors
      def primary
        {
          colors: %w(#b33 #f4e000 #33b #e16a00 #3b3 #521e8e),
          marker_color: '#aea9a9',
          font_color: '#2c2c2c',
          background_colors: %w(#e6e6e6 #d6d6d6)
        }
      end

      # A slightly muted, pastel rainbow
      def rainbow
        {
          colors: %w(#82c9cf #aec253 #fce43c #ff6922 #d4232d #8f5ccf),
          marker_color: '#f6f6f6',
          font_color: '#f6f6f6',
          background_colors: %w(#333 #444)
        }
      end

      # Grey colours
      def greyscale
        {
          colors: %w(#181818 #3c3c3c #686868 #989898 #c8c8c8 #e8e8e8),
          marker_color: '#aea9a9',
          font_color: 'black',
          background_colors: 'white'
        }
      end
    end
  end
end
