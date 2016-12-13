module FlickrImgParser
  class ImageParser
    attr_reader :image_id_list, :keyword_list

    def initialize(keyword_list = [])
      @image_id_list = []
      @keyword_list = keyword_list
    end

    def retrieve_images
      until image_id_list_size == FlickrImgParser.configuration.image_number
        keyword = next_keyword
        image = load_image(keyword)
        FlickrImgParser.logger.info 'Parsing image'
        next unless valid?(image)
        image_id_list << image_id(image)
        FlickrImgParser.logger.debug image
        FlickrImgParser.logger.info 'Image found'
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
      handling_exceptions do
        retrying do
          FlickrImgParser::FlickrApi.fetch_interesting_images(keyword)
        end
      end
    end

    def valid?(response)
      response && !error_response?(response) && exists?(response)
    end

    def handling_exceptions(&block)
      begin
        response = block.call
      rescue => e
        FlickrImgParser.logger.fatal(e)
        raise
      end
    end

    def retrying(&block)
      retries = 0
      begin
        response = block.call
      rescue Net::ReadTimeout => e
        raise if retries > 3
        retries += 1
        retry
      end
    end

    def error_response?(response)
      if response["stat"]["fail"]
        FlickrImgParser.logger.debug(response)
        true
      else
        false
      end
    end

    def exists?(image)
      image['photos']['photo'].length > 0
    end

    def image_id(image)
      image['photos']['photo'][0]['id']
    end
  end
end
