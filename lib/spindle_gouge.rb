require 'sinatra/base'
require 'tilt/erubis'
require 'json'
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

    get '/:thing/:format/:name' do
      path = File.join(
        settings.public_folder,
        'svg',
        params[:thing],
        params[:format],
        "#{params[:name]}.svg"
      )

      respond_to do |wants|
        wants.svg do
          headers 'Content-type' => 'image/svg+xml'
          send_file path
        end

        wants.png do
          headers 'Content-type' => 'image/png'
          image = Magick::Image.read(path).first
          response.write image.to_blob { |attrs| attrs.format = 'PNG' }
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
