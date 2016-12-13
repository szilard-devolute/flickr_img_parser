module FlickrImgParser
  class Configuration
    attr_accessor :image_number, :flickr_api_key, :log_level, :root_path, :image_file_path

    def initialize(flickr_api_key = nil)
      @image_number = 10
      @flickr_api_key = flickr_api_key
      @log_level = 'INFO'
      @root_path = FlickrImgParser.root
      @image_file_path = next_file_path
    end

    private

    def next_file_path
      dir = File.join(original_path, 'saved_images')
      file_number = Dir[dir].count { |file| File.file?(file) } + 1
      File.expand_path("../../../saved_images/#{file_number}.jpg", __FILE__)
    end

    def original_path
      root_path
    end
  end
end
