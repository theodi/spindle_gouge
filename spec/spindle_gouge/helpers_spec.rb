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

    context 'extract colours from params' do
      it 'returns a colour' do
        expect(helpers.wrangle_colours(
          {
            'colour' => 'red'
          }
        )).to eq [
          'd60303',
          '1dd3a7',
          '00b7ff'
        ]
      end

      it 'returns a primary' do
        expect(helpers.wrangle_colours(
          {
            'primary' => 'fa8100'
          }
        )).to eq [
          'fa8100',
          '1dd3a7',
          '00b7ff'
        ]
      end

      it 'returns a secondary' do
        expect(helpers.wrangle_colours(
          {
            'secondary' => 'alt-blue-1'
          }
        )).to eq [
          'd60303',
          '2f529f',
          '00b7ff'
        ]
      end

      it 'returns a primary and a secondary' do
        expect(helpers.wrangle_colours(
          {
            'colour' => 'eeeeee',
            'primary' => '123654',
            'secondary' => '191919'
          }
        )).to eq [
          '123654',
          '191919',
          '00b7ff'
        ]
      end
    end
  end
end
