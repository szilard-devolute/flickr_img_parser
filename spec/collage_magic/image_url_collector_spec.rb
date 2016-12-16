require 'spec_helper'

module CollageMagic
  describe ImageUrlCollector do
    context 'sends an API request to flickr', :vcr do
      let(:image_ids) { ['30836927024', '30836927024'] }
      subject { described_class.new(image_ids) }

      before do
        CollageMagic.configuration.flickr_api_key = ENV['FLICKR_API_KEY']
      end

      it 'returns an array of image urls' do
        expect(subject.collect_image_urls).to be_an(Array)
        expect(subject.collect_image_urls[0]).to start_with("https:\/\/farm")
      end
    end
  end
end
