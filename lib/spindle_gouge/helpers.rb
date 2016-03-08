module SpindleGouge
  module Helpers
    COLOURS = YAML.load_file 'config/colours.yaml'

    def fetch_colour name
      COLOURS[name] || name
    end

    def wrangle_colours params
      @colour = fetch_colour params.fetch('colour', '000000')
      @primary = fetch_colour params.fetch('primary', @colour)
      @secondary = fetch_colour params.fetch('secondary', 'ffffff')

      [
        @primary,
        @secondary
      ]
    end
  end
end
