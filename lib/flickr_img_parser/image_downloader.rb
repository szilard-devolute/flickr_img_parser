module FlickrImgParser
  class ImageDownloader
    attr_reader :image_id_list

    def initialize(image_id_list = [])
      @image_id_list = image_id_list
    end

    def download
      images = image_id_list.map { |id| download_image(id) }
      urls = images.map { |image| image_url(image) }
      puts urls
      urls
    end

    private

    def download_image(id)
      FlickrImgParser::FlickrApi.fetch_image_url(id)
    end

    def image_url(image)
      # returning the last image version (largest)
      image['sizes']['size'][-1]['source']
    end
  end
end
