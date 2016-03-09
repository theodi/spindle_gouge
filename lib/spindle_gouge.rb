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
          @title = 'ODI Brand API'
          erb :index, layout: :default
        end
      end
    end

    get '/labs/:name' do
      @word_location = params.fetch('word', 'inside')
      path = File.join(
        'svg',
        'labs',
        "word-#{@word_location}",
        "#{params[:name]}.svg"
      )

      respond_to do |wants|
        wants.html do
          erb :labs, layout: :default
        end

        wants.svg do
          gimme_svg path
        end

        wants.png do
          gimme_png path
        end
      end
    end

    get '/:thing/:name' do
      @primary, @secondary, @tertiary = wrangle_colours(params)
      path = File.join(
        'svg',
        params[:thing],
        "#{params[:name]}.svg"
      )

      respond_to do |wants|
        wants.html do
          erb :logo, layout: :default
        end

        wants.svg do
          gimme_svg path
        end

        wants.png do
          gimme_png path
        end
      end
    end

    get '/palette' do
      respond_to do |wants|
        wants.json do
          palette.to_json
        end

        wants.txt do |wants|
          type = params.fetch('type', 'scss')
          case type
            when 'scss'
              gimme_scss
          end
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
