require 'spec_helper'

describe FlickrImgParser do
  before do 
    FlickrImgParser.configure do |config|
      config.flickr_api_key = "my_api_key"
    end
  end

  describe "configure" do
    it "returns api key" do
      expect(FlickrImgParser.configuration.flickr_api_key).to eq("my_api_key")
    end
  end

  describe "getting images", :vcr do
    it "returns image url-s" do
      expect(FlickrImgParser.getting_images(["dog", "cat"])).to be_an(Array)
    end
  end
end
