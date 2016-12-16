require 'spec_helper'

describe CollageMagic do
  before do
    CollageMagic.configure do |config|
      config.flickr_api_key = ENV['FLICKR_API_KEY']
    end
  end

  describe 'configure' do
    it 'returns Flickr API key' do
      expect(CollageMagic.configuration.flickr_api_key).to eq(ENV['FLICKR_API_KEY'])
    end
  end

  describe '#compose_collage', :vcr do
    it 'returns image url-s' do
      expect(CollageMagic.create_collage(['dog', 'cat'])).to be_an(Array)
    end
  end
end
