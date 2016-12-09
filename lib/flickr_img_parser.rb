require 'flickr_img_parser/version'
require 'flickr_img_parser/random_word_creator'
require 'flickr_img_parser/command'
require 'flickr_img_parser/configuration'
require 'flickr_img_parser/image_parser'
require 'flickr_img_parser/image_downloader'

module FlickrImgParser
  class << self
    attr_writer :configuration
  end

  def self.getting_images(keyword_array)
    image_id_list = FlickrImgParser::ImageParser.new(keyword_array).retrieve_images
    FlickrImgParser::ImageDownloader.new(image_id_list).download
  end

  def self.configure
    yield(configuration)
  end

  private

  def self.configuration
    @configuration ||= FlickrImgParser::Configuration.new
  end
end

require 'flickr_img_parser/flickr_api'
