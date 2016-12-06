require "flickr_img_parser/version"
require "flickr_img_parser/flickr_api"
require "flickr_img_parser/random_word_creator"
require "flickr_img_parser/command"
require "flickr_img_parser/image_parser"

module FlickrImgParser
  def self.getting_images(keyword_array)
    FlickrImgParser::ImageParser.new(keyword_array).retrieve_images
  end
end
