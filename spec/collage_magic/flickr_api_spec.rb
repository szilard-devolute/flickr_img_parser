require 'spec_helper'

module CollageMagic
  describe FlickrApi do
    context 'sends a successful API request to flickr', :vcr do
      before do
        CollageMagic.configuration.flickr_api_key = ENV['FLICKR_API_KEY']
      end

      it 'returns the images sorted by interestingness' do
        response = described_class.fetch_images_for('cat')
        expect(response['photos']['photo']).to be_an(Array)
      end

      it 'returns the image urls' do
        response = described_class.fetch_image_urls_for('30670516674')
        expect(response['sizes']['size'][-1]['source']).to start_with("https:\/\/farm")
      end
    end
  end
end
