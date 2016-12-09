require "httparty"
require "byebug"

module FlickrImgParser
  module FlickrApi
    include HTTParty

    base_uri "https://api.flickr.com/services/rest/?"
  
    def self.fetch_interesting_images(word)
      get("method=flickr.photos.search&api_key=#{FlickrImgParser.configuration.flickr_api_key}&tags=#{word}&sort=interestingness_desc&per_page=1&format=json&nojsoncallback=1")
    end

    def self.fetch_image_url(image_id)
      get("method=flickr.photos.getSizes&api_key=#{FlickrImgParser.configuration.flickr_api_key}&photo_id=#{image_id}&format=json&nojsoncallback=1")
    end
  end
end
