module SpindleGouge
  module Helpers
    COLOURS = YAML.load_file 'config/colours.yaml'

    def fetch_colour name
      COLOURS[name]
    end
  end
end
