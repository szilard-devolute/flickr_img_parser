module FlickrImgParser
  class ImageParser
    IMAGE_NUMBER = 10

    attr_reader :image_id_list, :keyword_list

    def initialize(keyword_list = [])
      @image_id_list = []
      @keyword_list = keyword_list
    end

    def retrieve_images
      until image_id_list_size == IMAGE_NUMBER
        keyword = next_keyword
        image = load_image(keyword)
        puts "Parsing image"
        if exists?(image)
          image_id_list << image_id(image)
          puts image
          puts "Image found"
        end
      end
      image_id_list
    end

    private

      def image_id_list_size
        image_id_list.length
      end

      def next_keyword
        keyword_list.shift || random_keyword
      end

      def random_keyword
        FlickrImgParser::RandomWordCreator.get_word
      end

      def load_image(keyword)
        FlickrImgParser::FlickrApi.fetch_interesting_images(keyword)
      end

      def exists?(image)
        image["photos"]["photo"].length > 0
      end

      def image_id(image)
        image["photos"]["photo"][0]["id"]
      end
  end
end
