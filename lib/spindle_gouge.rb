require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'rmagick'

require_relative 'spindle_gouge/racks'
require_relative 'spindle_gouge/helpers'

module SpindleGouge
  class App < Sinatra::Base
    helpers do
      include SpindleGouge::Helpers
    end

    before do
      headers 'Vary' => 'Accept'
    end

    get '/' do
      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from SpindleGouge</h1>'
          @title = 'SpindleGouge'
          erb :index, layout: :default
        end
      end
    end

    get '/:thing/:name' do
      @primary, @secondary = wrangle_colours(params)
      path = File.join(
        'svg',
        params[:thing],
        "#{params[:name]}.svg"
      )

      respond_to do |wants|
        wants.svg do
          headers 'Content-type' => 'image/svg+xml'
          erb path.to_sym
        end

        wants.png do
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

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
