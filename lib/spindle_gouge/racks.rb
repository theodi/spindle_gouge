require 'rack/conneg'

module SpindleGouge
  class App < Sinatra::Base
    set :public_folder, 'public'
    set :views, 'views'

    use Rack::Conneg do |conneg|
      conneg.set :accept_all_extensions, false
      conneg.set :fallback, :html
      conneg.ignore_contents_of 'public'
      conneg.provide [
        :html,
        :json,
        :svg,
        :png,
        :txt
      ]
    end

    before do
      if negotiated?
        content_type negotiated_type
      end
    end
  end
end
