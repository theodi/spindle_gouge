module SpindleGouge
  SVG_HEADERS = { 'HTTP_ACCEPT' => 'image/svg+xml' }
  PNG_HEADERS = { 'HTTP_ACCEPT' => 'image/png' }
  describe App do
    it 'says hello' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /ODI Brand API/
    end

    context 'simple SVG' do
      it 'serves up an SVG' do
        get '/logo/basic', nil, SVG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/svg+xml'
        expect(last_response.body).to match /fill="#000000"/
        expect(Digest::SHA256.hexdigest last_response.body).to eq '1b0abd6a4bf9eb82bd80b9bc2785296d9199a190376ffe3f37239b2f109c4988'
      end

      it 'colours an SVG' do
        get '/logo/basic?colour=fa8100', nil, SVG_HEADERS
        expect(last_response.body).to match /fill="#fa8100"/
        expect(Digest::SHA256.hexdigest last_response.body).to eq 'c9f97ce388c722d98c78df57621aeee706c7b6c29521c2463880a4fef67dee7a'
      end

      it 'colours an SVG using a named colour' do
        get '/logo/basic?primary=blue-1', nil, SVG_HEADERS
        expect(last_response.body).to match /fill="#2254f4"/
        expect(Digest::SHA256.hexdigest last_response.body).to eq '5c3c8fef9c53c3d7d775a8729d67e1fafb575a5a7cfcf7673719a7ab27fe35ed'
      end

      it 'colours an SVG with primary and secondary colours' do
        get '/logo/partner?primary=123123&secondary=red', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#123123".*path fill="#d60303"/m
        expect(Digest::SHA256.hexdigest last_response.body).to eq 'e3355e691e9cd486fe0baf3221cb8c383c112f696ef72f6b0dba2dcb429992b2'
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

      it 'gets one with the word on the outside' do
        get '/labs/bubbles?word=outside', nil, SVG_HEADERS
        expect(Digest::SHA256.hexdigest last_response.body).to eq '4cce4045b174e7d1ef0010cb73474b6704d8a1b8f956e2300bd0a0af8feb6b99'
      end
    end
  end
end
