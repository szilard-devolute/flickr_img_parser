require 'flickr_img_parser/version'
require 'flickr_img_parser/random_word_creator'
require 'flickr_img_parser/command'
require 'flickr_img_parser/configuration'
require 'flickr_img_parser/image_parser'
require 'flickr_img_parser/image_downloader'
require 'logger'

module FlickrImgParser
  class << self
    attr_writer :configuration
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.progname = self.name
      end
      @logger.level = ENV["LOG_LEVEL"] || Logger::INFO
      @logger
    end
  end

  def self.getting_images(keyword_array)
    image_id_list = FlickrImgParser::ImageParser.new(keyword_array).retrieve_images
    urls = FlickrImgParser::ImageDownloader.new(image_id_list).download
    FlickrImgParser.logger.info urls
    urls
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
