require "spec_helper"

module FlickrImgParser
  describe RandomWordCreator, :vcr do
    it "returns a word" do
      response = described_class.get_word
      expect(response).to be_a(String)
    end
  end
end
