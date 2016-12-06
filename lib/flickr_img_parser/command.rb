require "thor"

module FlickrImgParser
	class Command < Thor
		desc "words KEYWORDS", "You can add up to 10 space separated keyword for your flickr image collage. If you add less, we will fill it up with random images."

		def words(*keywords)
			puts "You added #{keywords.length} keyword(s)."
			FlickrImgParser.getting_images(keywords)
		end
	end
end
