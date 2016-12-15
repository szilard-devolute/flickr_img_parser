module FlickrImgParser
  class ImageDownloader
    attr_reader :image_id_list, :url_list

    def initialize(image_id_list = [], url_list = [])
      @image_id_list = image_id_list
      @url_list = url_list
    end

    def download
      images = image_id_list.map { |id| download_image(id) }
      images.each { |image| url_list << image_url(image) }
      # format_url_list
      url_list
    end

    private

    def download_image(id)
      FlickrImgParser::FlickrApi.fetch_image_url(id)
    end

    def image_url(image)
      # returning the last image version (largest)
      image['sizes']['size'][-1]['source']
    end

    def format_url_list
      url_list.each do |url|
        uri = URI.parse(url)
        uri.scheme = 'http'
        url = uri.to_s
      end
    end
  end
end
