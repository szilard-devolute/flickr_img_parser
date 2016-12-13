require 'thor'

module FlickrImgParser
  class Command < Thor
    desc 'words KEYWORDS', 'You can add up to 10 space separated keyword for your flickr image collage. If you add less, we will fill it up with random images.'

    def words(*keywords)
      unless FlickrImgParser.configuration.flickr_api_key
        say('We need your Flickr API key first.')
        FlickrImgParser.configuration.flickr_api_key = ask('Flickr API key: ')
      end
      FlickrImgParser.logger.info "You added #{keywords.length} keyword(s)."
      FlickrImgParser.getting_images(keywords)

      FlickrImgParser.logger.info "Next montage path #{FlickrImgParser.configuration.image_file_path}"
    end
  end
end
