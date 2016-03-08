class TestHelper
  include SpindleGouge::Helpers
end

module SpindleGouge
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'knows about ODI colours' do
      expect(helpers.fetch_colour 'red').to eq 'd60303'
      expect(helpers.fetch_colour 'alt-blue-1').to eq '2f529f'
    end
  end
end
