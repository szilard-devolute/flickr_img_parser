require "spec_helper"

module FlickrImgParser
  describe FlickrApi do
    context "sends a successfull API request to flickr", :vcr do
      before do
        FlickrImgParser.configuration.flickr_api_key = "44f36a01101a6c77bd111c23e7de414a"
      end

      it "returns the proper data when it hits the search API" do
        response = described_class.fetch_interesting_images("cat")
        expect(response["photos"]["photo"]).to be_an(Array)
      end

      it "returns the proper data when it hits the photo API" do
        response = described_class.fetch_image_url("30670516674")
        expect(response["sizes"]["size"][-1]["source"]).to start_with("https:\/\/farm")
      end
    end
  end
end
