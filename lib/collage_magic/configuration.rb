module CollageMagic
  class Configuration
    attr_accessor :image_number, :flickr_api_key, :log_level, :collage_file_path

    def initialize
      @image_number = ENV['COLLAGE_MAGIC_IMAGE_NUMBER'] || 10
      @flickr_api_key = ENV['FLICKR_API_KEY']
      @log_level = ENV['COLLAGE_MAGIC_LOG_LEVEL'] || 'INFO'
      @collage_file_path = create_or_return_directory
    end

    def create_or_return_directory
      return ENV['COLLAGE_MAGIC_IMAGE_PATH'] if ENV['COLLAGE_MAGIC_IMAGE_PATH'] && FileUtils.mkdir_p(ENV['COLLAGE_MAGIC_IMAGE_PATH'])
    end
  end
end
