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
      it 'serves up a SVG' do
        get '/logo/print/basic', nil, SVG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/svg+xml'
        expect(last_response.headers['Content-length']).to eq '28795'
      end
    end

    context 'PNGs' do
      it 'serves up a PNG' do
        get '/logo/print/basic', nil, PNG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/png'
        expect(last_response.headers['Content-length']).to be >= '2694'
      end

      it 'scales a PNG' do
        get '/logo/print/basic?width=100', nil, PNG_HEADERS
        expect(last_response.headers['Content-type']).to eq 'image/png'
        expect(last_response.headers['Content-length']).to be <= '1876'
      end
    end
  end
end
