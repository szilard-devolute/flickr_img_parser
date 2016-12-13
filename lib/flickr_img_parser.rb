require 'flickr_img_parser/version'
require 'flickr_img_parser/random_word_creator'
require 'flickr_img_parser/command'
require 'flickr_img_parser/configuration'
require 'flickr_img_parser/image_parser'
require 'flickr_img_parser/image_downloader'
require 'logger'
require 'dotenv'
Dotenv.load

module FlickrImgParser
  class << self
    attr_writer :configuration
    attr_writer :logger
  end

  def self.getting_images(keyword_array)
    puts FlickrImgParser.configuration.flickr_api_key
    image_id_list = FlickrImgParser::ImageParser.new(keyword_array).retrieve_images
    urls = FlickrImgParser::ImageDownloader.new(image_id_list).download
    FlickrImgParser.logger.info urls
    urls
  end

  def self.logger
    @logger ||= Logger.new($stdout).tap do |log|
      log.progname = self.name
    end
    @logger.level = Logger.const_get(FlickrImgParser.configuration.log_level)
    @logger
  end

  def self.root
    File.dirname(__dir__)
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
