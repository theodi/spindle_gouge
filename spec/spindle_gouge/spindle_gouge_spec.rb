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
        expect(last_response.body).to match /path fill="#000000"/
        expect(Digest::SHA256.hexdigest last_response.body).to eq '24421830ca4b6427b06989e34bbb7772606d007e2d27679b25c1c728efb1f8bf'
      end

      it 'colours an SVG' do
        get '/logo/basic?colour=fa8100', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#fa8100"/
        expect(Digest::SHA256.hexdigest last_response.body).to eq '196bcab675d535c6de8517dac6a7f5bc375afcd3e889050fbb4c9d6606d1a480'
      end

      it 'colours an SVG using a named colour' do
        get '/logo/basic?primary=blue-1', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#2254f4"/
        expect(Digest::SHA256.hexdigest last_response.body).to eq 'c8b2c8bfa25aac44b2f46f487000f7ec96af7bc49312921dcd26c3c8d8f1339d'
      end

      it 'colours an SVG with primary and secondary colours' do
        get '/logo/partner?primary=123123&secondary=red', nil, SVG_HEADERS
        expect(last_response.body).to match /path fill="#123123".*path fill="#d60303"/m
        expect(Digest::SHA256.hexdigest last_response.body).to eq '433487aa5da83c12023639261e9a67fd075830a481a7117b76fd389d06c9429a'
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
        expect(Digest::SHA256.hexdigest last_response.body).to eq '7fb407bcc44f51ad01dd182942cdb139563f14b9633126f1aae2281a3ef37682'
      end
    end
  end
end
