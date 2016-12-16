require 'collage_magic/version'
require 'collage_magic/configuration'
require 'logger'
require 'collage_magic/cli'
require 'collage_magic/image_id_collector'
require 'collage_magic/image_url_collector'
require 'collage_magic/collage_composer'
require 'collage_magic/flickr_api'
require 'collage_magic/random_word_api'

module CollageMagic
  class << self
    attr_writer :configuration
    attr_writer :logger
  end

  def self.create_collage(keywords)
    image_ids = CollageMagic::ImageIdCollector.new(keywords).collect_image_ids
    image_urls = CollageMagic::ImageUrlCollector.new(image_ids).collect_image_urls
    CollageMagic.logger.info 'Image urls saved!'
    CollageMagic::CollageComposer.new(image_urls).compose_collage
  end

  def self.logger
    @logger ||= Logger.new($stdout)
    @logger.formatter = proc do |_severity, time, _progname, msg|
      puts "#{time} #{msg}"
    end
    @logger.level = Logger.const_get(CollageMagic.configuration.log_level)
    @logger
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= CollageMagic::Configuration.new
  end
end
