require 'flickr_img_parser/version'
require 'flickr_img_parser/random_word_api'
require 'flickr_img_parser/command'
require 'flickr_img_parser/configuration'
require 'flickr_img_parser/image_parser'
require 'flickr_img_parser/image_downloader'
require 'flickr_img_parser/image_composer'
require 'logger'

module FlickrImgParser
  class << self
    attr_writer :configuration
    attr_writer :logger
  end

  def self.getting_images(keyword_array)
    image_id_list = FlickrImgParser::ImageParser.new(keyword_array).retrieve_images
    urls = FlickrImgParser::ImageDownloader.new(image_id_list).download
    FlickrImgParser.logger.info "Image URL-s:"
    urls.each { |url| FlickrImgParser.logger.info url }
    FlickrImgParser::ImageComposer.new(urls).compose
  end

  def self.logger
    @logger ||= Logger.new($stdout)
    @logger.formatter = proc do |severity, time, progname, msg|
      puts ("#{time} #{msg}")
    end
    @logger.level = Logger.const_get(FlickrImgParser.configuration.log_level)
    @logger
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
