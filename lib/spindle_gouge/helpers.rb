module SpindleGouge
  module Helpers
    PALETTE = YAML.load_file 'config/palette.yaml'
    DEFAULTS = YAML.load_file 'config/defaults.yaml'

    def fetch_colour name
      PALETTE[name] || name
    end

    def wrangle_colours params
      @colour = fetch_colour params.fetch('colour', DEFAULTS['colours']['primary'])
      @primary = fetch_colour params.fetch('primary', @colour)
      @secondary = fetch_colour params.fetch('secondary', DEFAULTS['colours']['secondary'])
      @tertiary = fetch_colour params.fetch('tertiary', DEFAULTS['colours']['tertiary'])

      [
        @primary,
        @secondary,
        @tertiary
      ]
    end

    def palette
      @palette ||= begin
        p = {}
        PALETTE.each_pair do |name, hex|
          p[name] = "##{pad hex}"
        end

        p
      end
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

    def gimme_scss
      s = ''
      palette.each_pair do |name, hex|
        s << "$#{name}: #{hex}"
        s << "\n"
      end
      s
    end

    private

    def pad s
      "#{'0' * (6 - s.to_s.length)}#{s}"
    end
  end
end
