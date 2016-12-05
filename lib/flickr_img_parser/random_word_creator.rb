require "httparty"

module FlickImgParser
	class RandomWordCreator
		include HTTParty

		base_uri = "http://www.setgetgo.com/randomword/get.php"

		def self.get_word
			res = get("")
			word = res.parsed_response
		end
	end
end
