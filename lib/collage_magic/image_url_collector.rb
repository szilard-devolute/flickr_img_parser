module CollageMagic
  class ImageUrlCollector
    attr_reader :image_ids, :image_urls

    def initialize(image_ids = [], image_urls = [])
      @image_ids = image_ids
      @image_urls = image_urls
    end

    def collect_image_urls
      images = image_ids.map { |id| fetch_image(id) }
      images.each { |image| image_urls << image_url(image) }
      image_urls
    end

    private

    def fetch_image(image_id)
      CollageMagic::FlickrApi.fetch_image_urls_for(image_id)
    end

    def image_url(image)
      # Returns the largest image
      image['sizes']['size'][-1]['source']
    end
  end
end
