require 'spec_helper'

module FlickrImgParser
  describe RandomWordApi, :vcr do
    it 'returns a word' do
      response = described_class.get_word
      expect(response).to be_a(String)
    end
  end
end
