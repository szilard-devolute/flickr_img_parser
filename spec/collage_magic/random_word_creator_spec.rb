require 'spec_helper'

module CollageMagic
  describe RandomWordApi, :vcr do
    it 'returns a random word' do
      response = described_class.get_word
      expect(response).to be_a(String)
    end
  end
end
