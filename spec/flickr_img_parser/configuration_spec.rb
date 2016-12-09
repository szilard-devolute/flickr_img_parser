require "spec_helper"

module FlickrImgParser
  describe Configuration do
    describe "api_key" do
      let(:configuration) { Configuration.new }

      it "default value is nil" do
        expect(configuration.flickr_api_key).to eq nil
      end

      it "value can be set" do
        configuration.flickr_api_key = "haha1"
        expect(configuration.flickr_api_key).to eq("haha1")
      end
    end
  end
end