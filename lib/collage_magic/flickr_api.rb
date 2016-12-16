require 'httparty'

module CollageMagic
  module FlickrApi
    include HTTParty

    base_uri 'https://api.flickr.com/services/rest/?'

    def self.fetch_images_for(keyword)
      params = URI.encode_www_form(
        'method' => 'flickr.photos.search',
        'api_key' => CollageMagic.configuration.flickr_api_key,
        'tags' => keyword.to_s,
        'sort' => 'interestingness_desc',
        'per_page' => '1',
        'format' => 'json',
        'nojsoncallback' => '1'
      )
      get(params)
    end

    def self.fetch_image_urls_for(image_id)
      params = URI.encode_www_form(
        'method' => 'flickr.photos.getSizes',
        'api_key' => CollageMagic.configuration.flickr_api_key,
        'photo_id' => image_id.to_s,
        'format' => 'json',
        'nojsoncallback' => '1'
      )
      get(params)
    end
  end
end
