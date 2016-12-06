require "httparty"

module FlickrImgParser
  module FlickrApi
    include HTTParty
    API_KEY = "44f36a01101a6c77bd111c23e7de414a"

    base_uri "https://api.flickr.com/services/rest/?"
  
    def self.call(word)
      image = get("method=flickr.photos.search&api_key=#{API_KEY}&tags=#{word}&sort=interestingness_desc&per_page=1&format=json&nojsoncallback=1")
    end
  end
end
