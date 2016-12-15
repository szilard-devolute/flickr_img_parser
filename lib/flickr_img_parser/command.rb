require 'thor'

module FlickrImgParser
  class Command < Thor
    desc 'words KEYWORDS', 'You can add up to 10 space separated keyword for your flickr image collage. If you add less, we will fill it up with random images.'

    def words(*keywords)
      unless FlickrImgParser.configuration.flickr_api_key
        say('Before you run the code you have to save your Flickr API key first. Pls type $export FLICKR_API_KEY=your_api_key')
        exit
      end
      unless FlickrImgParser.configuration.image_file_path
        say('Before you run the code you have to provide a path with filename where you wanna save your image. Pls type $export FLICKR_IMAGE_PATH=/home/username/desktop/flickr_images')
        exit
      end
      FlickrImgParser.logger.info "You added #{keywords.length} keyword(s)."
      FlickrImgParser.getting_images(keywords)

      FlickrImgParser.logger.info "Next montage path #{FlickrImgParser.configuration.image_file_path}"
    end
  end
end
