module SpindleGouge
  SVG_HEADERS = { 'HTTP_ACCEPT' => 'image/svg+xml' }
  PNG_HEADERS = { 'HTTP_ACCEPT' => 'image/png' }
  describe App do
    it 'says hello' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello from SpindleGouge/
    end

    context 'simple SVG' do
      it 'serves up an SVG' do
        get '/logo/basic', nil, SVG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/svg+xml'
        expect(last_response.body).to match /path fill="#000000"/
      end

      it 'colours an SVG' do
        get '/logo/basic?colour=fa8100', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#fa8100"/
      end

      it 'colours an SVG using a named colour' do
        get '/logo/basic?primary=blue-1', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#2254f4"/
      end

      it 'colours an SVG with primary and secondary colours' do
        get '/logo/partner?primary=123123&secondary=red', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#123123".*path fill="#d60303"/m
      end
    end

    context 'PNGs' do
      it 'serves up a PNG' do
        get '/logo/basic', nil, PNG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/png'
      end

      it 'scales a PNG' do
        get '/logo/basic?width=100', nil, PNG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/png'
      end
    end

    context 'labs' do
      it 'gets a logo' do
        get '/labs/bubbles', nil, SVG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/svg+xml'
        expect(Digest::SHA256.hexdigest last_response.body).to eq '4cce4045b174e7d1ef0010cb73474b6704d8a1b8f956e2300bd0a0af8feb6b99'
      end
    end
  end
end
