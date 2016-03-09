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

    def gimme_svg path
      headers 'Content-type' => 'image/svg+xml'
      erb path.to_sym
    end

    def gimme_png path
      headers 'Content-type' => 'image/png'
      path = File.join(
        settings.views,
        "#{path}.erb"
      )

      e = ERB.new File.read path
      image = Magick::Image.from_blob(e.result binding).first
      image.format = 'PNG'
      image.resize_to_fit! params[:width] if params[:width]
      response.write image.to_blob
    end
  end
end
