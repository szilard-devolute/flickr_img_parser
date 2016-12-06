module FlickrImgParser
	class ImageParser
		IMAGE_NUMBER = 10

		attr_reader :image_list, :keyword_list

		def initialize(keyword_list = [])
			@image_list = []
			@keyword_list = keyword_list
		end

		def retrieve_images
			until image_list_size == IMAGE_NUMBER
				keyword = next_keyword
				image = load_image(keyword)
				puts "Parsing image"
				image_list << image if exists?(image)
			end
			puts "Your image list: #{image_list}"
		end

		private

			def image_list_size
				image_list.length
			end

			def next_keyword
				keyword_list.shift || random_keyword
			end

			def random_keyword
				FlickrImgParser::RandomWordCreator.get_word
			end

			def load_image(keyword)
				FlickrImgParser::FlickrApi.call(keyword)
			end

			def exists?(image)
				image["photos"]["photo"].length > 0
			end
	end
end
