require "flickr_img_parser/version"
require "flickr_img_parser/random_word_creator"
require "httparty"

module FlickrImgParser
	include HTTParty
	API_KEY = "44f36a01101a6c77bd111c23e7de414a"

	base_uri "https://api.flickr.com/services/rest/?"

  
  def self.api_call(image_keyword_array)
  	image_list = []
  	image_keyword_array.each do |word|
  		image = get("method=flickr.photos.search&api_key=#{API_KEY}&tags=#{word}&sort=interestingness_desc&per_page=1&format=json")
  		image_list << image
  	end
  	image_list
  end

  def self.keyword_list(*args)
  	key_words = []
  	if args.length == 10
  	elsif args.length > 10
  		STDERR.puts "You added more than 10 keywords, extras will be ignored"
  		key_words << args[0..9]
  	else
  		key_words << args
  		(10 - key_words.length).times do
  			keywords << FlickrImgParser::RandomWordCreator.get_word
  		end
  	end
  end
end



