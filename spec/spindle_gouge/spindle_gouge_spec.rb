module SpindleGouge
  describe App do
    it 'says hello' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello from SpindleGouge/
    end

    context 'simple SVG' do
      it 'serves up a SVG' do
        get '/logo/print/basic', nil, { 'HTTP_ACCEPT' => 'image/svg+xml' }
        expect(last_response.headers['Content-type']).to eq 'image/svg+xml'
        expect(last_response.headers['Content-length']).to eq '28795'
      end
    end

    context 'simple PNG' do
      it 'serves up a PNG' do
        get '/logo/print/basic', nil, { 'HTTP_ACCEPT' => 'image/png' }
        expect(last_response.headers['Content-type']).to eq 'image/png'
        expect(last_response.headers['Content-length']).to eq '5109'
      end
    end
  end
end
