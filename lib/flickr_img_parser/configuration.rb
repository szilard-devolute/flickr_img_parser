module FlickrImgParser
  class Configuration
    attr_accessor :image_number, :flickr_api_key, :log_level, :image_file_path

    def initialize
      @image_number = ENV['FLICKR_IMAGE_NUMBER'] || 10
      @flickr_api_key = ENV['FLICKR_API_KEY']
      @log_level = ENV['FLICKR_LOG_LEVEL'] || 'INFO'
      @image_file_path = create_or_return_directory
    end

    def create_or_return_directory
      return ENV['FLICKR_IMAGE_PATH'] if ENV['FLICKR_IMAGE_PATH'] && FileUtils.mkdir_p(ENV['FLICKR_IMAGE_PATH'])
    end
  end
end
