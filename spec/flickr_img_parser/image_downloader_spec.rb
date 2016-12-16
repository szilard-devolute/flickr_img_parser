require 'spec_helper'

module FlickrImgParser
  describe ImageDownloader do
    context 'sends a new API request to flickr to get the url-s', :vcr do
      let(:image_id_list) { ['30836927024', '30836927024'] }
      subject { described_class.new(image_id_list) }

      before do
        FlickrImgParser.configuration.flickr_api_key = ENV['FLICKR_API_KEY']
      end


      it 'returns an array' do
        expect(subject.download).to be_an(Array)
      end

      it 'returned array contains url-s' do
        expect(subject.download[0]).to start_with("https:\/\/farm")
      end
    end
  end
end
