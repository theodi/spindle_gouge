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

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from SpindleGouge</h1>'
          @title = 'SpindleGouge'
          erb :index, layout: :default
        end

        wants.json do
          {
            app: 'SpindleGouge'
          }.to_json
        end
      end
    end

    get '/logo' do
      respond_to do |wants|
        wants.svg do
          headers 'Content-type' => 'image/svg+xml'
          send_file File.join(settings.public_folder, 'svg', 'logo.svg')
        end

        wants.png do
          headers 'Content-type' => 'image/png'
          image = Magick::Image.read(File.join(settings.public_folder, 'svg', 'logo.svg')).first
          response.write image.to_blob { |attrs| attrs.format = 'PNG' }
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
