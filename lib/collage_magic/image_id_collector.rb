module CollageMagic
  class ImageIdCollector
    attr_reader :image_ids, :keywords

    def initialize(keywords = [])
      @image_ids = []
      @keywords = keywords
    end

    def collect_image_ids
      until image_id_list_size == CollageMagic.configuration.image_number
        keyword = next_keyword
        image = fetch_image(keyword)
        CollageMagic.logger.info "Fetching image for #{keyword}"
        next unless valid?(image)
        image_ids << image_id(image)
        CollageMagic.logger.info "Image for #{keyword} found"
      end
      image_ids
    end

    private

    def image_id_list_size
      image_ids.length
    end

    def next_keyword
      keywords.shift || random_keyword
    end

    def random_keyword
      CollageMagic::RandomWordApi.get_word
    end

    def fetch_image(keyword)
      handle_exceptions do
        retry_to_fetch_image do
          CollageMagic::FlickrApi.fetch_images_for(keyword)
        end
      end
    end

    def valid?(response)
      response && !error_response?(response) && exists?(response)
    end

    def handle_exceptions
      response = yield
    rescue => e
      CollageMagic.logger.fatal(e)
      raise
    end

    def retry_to_fetch_image
      retries = 0
      begin
        response = yield
      rescue Net::ReadTimeout => e
        raise if retries > 3
        retries += 1
        retry
      end
    end

    def error_response?(response)
      if response['stat']['fail']
        CollageMagic.logger.debug(response)
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
