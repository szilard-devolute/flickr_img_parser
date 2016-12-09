module FlickrImgParser
  class Configuration
    attr_accessor :image_number, :flickr_api_key, :image_file_path

    def initialize(image_number = 10, flickr_api_key = nil, _image_file_path = nil)
      @image_number = image_number
      @flickr_api_key = flickr_api_key
      @image_file_path = next_file_path
      FlickrImgParser.logger.debug @image_file_path
    end

    def next_file_path
      dir = File.expand_path('../../../saved_images/', __FILE__)
      file_number = Dir[dir].count { |file| File.file?(file) } + 1
      File.expand_path("../../../saved_images/#{file_number}.jpg", __FILE__)
    end
  end
end
