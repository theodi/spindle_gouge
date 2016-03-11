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
        )).to include 'd60303'
      end

      it 'returns a primary' do
        expect(helpers.wrangle_colours(
          {
            'primary' => 'fa8100'
          }
        )).to include 'fa8100'
      end

      it 'returns a secondary' do
        expect(helpers.wrangle_colours(
          {
            'secondary' => 'alt-blue-1'
          }
        )[1]).to eq '2f529f'
      end

      it 'returns a primary and a secondary' do
        [
          '123654',
          '191919'
        ].each do |colour|
          expect(helpers.wrangle_colours(
            {
              'colour' => 'eeeeee',
              'primary' => '123654',
            'secondary' => '191919'
            }
          )).to include colour
        end
      end
    end

    it 'formats the palette' do
      expect(helpers.palette).to eq (
        {
          'black' => '#000000',
          'white' => '#ffffff',
          'blue-1' => '#2254f4',
          'blue-2' => '#00b7ff',
          'blue-3' => '#08def9',
          'green-1' => '#1dd3a7',
          'green-2' => '#0dbc37',
          'green-3' => '#67ef67',
          'orange-1' => '#f9bc26',
          'orange-2' => '#ff6700',
          'red' => '#d60303',
          'pink-1' => '#ef3aab',
          'pink-2' => '#e6007c',
          'purple' => '#b13198',
          'grey-1' => '#333333',
          'grey-2' => '#999999',
          'alt-blue-1' => '#2f529f',
          'alt-blue-2' => '#00ace8',
          'alt-blue-3' => '#7dc5ea'
        }
      )
    end
  end
end
