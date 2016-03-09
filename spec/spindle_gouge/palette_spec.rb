module SpindleGouge
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }
  TEXT_HEADERS = { 'HTTP_ACCEPT' => 'text/plain' }
  describe App do
    it 'serves the colour palette as JSON' do
      get '/palette', nil, JSON_HEADERS
      expect(JSON.parse last_response.body).to eq (
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

    context 'SCSS' do
      it 'serves the palette as SASS colours' do
        get '/palette', nil, TEXT_HEADERS
        expect(last_response.body).to eq (
        """$black: #000000;
$white: #ffffff;
$blue-1: #2254f4;
$blue-2: #00b7ff;
$blue-3: #08def9;
$green-1: #1dd3a7;
$green-2: #0dbc37;
$green-3: #67ef67;
$orange-1: #f9bc26;
$orange-2: #ff6700;
$red: #d60303;
$pink-1: #ef3aab;
$pink-2: #e6007c;
$purple: #b13198;
$grey-1: #333333;
$grey-2: #999999;
$alt-blue-1: #2f529f;
$alt-blue-2: #00ace8;
$alt-blue-3: #7dc5ea;
"""
        )
      end

      it 'serves the palette as a SASS map' do
        get '/palette?type=sass_map', nil, TEXT_HEADERS
        expect(last_response.body).to eq (
        """$odi-palette: (
  $black: #000000,
  $white: #ffffff,
  $blue-1: #2254f4,
  $blue-2: #00b7ff,
  $blue-3: #08def9,
  $green-1: #1dd3a7,
  $green-2: #0dbc37,
  $green-3: #67ef67,
  $orange-1: #f9bc26,
  $orange-2: #ff6700,
  $red: #d60303,
  $pink-1: #ef3aab,
  $pink-2: #e6007c,
  $purple: #b13198,
  $grey-1: #333333,
  $grey-2: #999999,
  $alt-blue-1: #2f529f,
  $alt-blue-2: #00ace8,
  $alt-blue-3: #7dc5ea,
);"""
        )
      end
    end
  end
end
