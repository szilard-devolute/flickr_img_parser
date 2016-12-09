require 'httparty'

module FlickrImgParser
  module RandomWordCreator
    include HTTParty

    base_uri 'http://www.setgetgo.com/randomword/get.php'

    def self.get_word
      get('/').parsed_response
    end
  end
end
