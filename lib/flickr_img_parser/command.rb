require 'thor'

module FlickrImgParser
  class Command < Thor
    desc 'start KEYWORDS', 'You can add up to 10 space separated keyword for your flickr image collage. If you add less, we will fill it up with random images.'

    def start(*keywords)
      say('
        Welcome! This programme will let you create an image collage from random keywords.
        You can choose up to ten keywords, and I will search images on Flickr associated to them.
        If you enter less than ten keywords, I will generate as many as I need to have ten keywords.
        If you enter more than ten, any extra one will be disregarded.

        To start, you need to:
        1) enter your Flickr API key. Please type:
           $export FLICKR_API_KEY=your_api_key
        2) give me a path where you would like to have your collage saved. Please type:
           $export FLICKR_IMAGE_PATH=/your/desired/path/
      ')

      unless FlickrImgParser.configuration.flickr_api_key
        say('
          You cannot run this programme without a Flickr API key.
          Please type $export FLICKR_API_KEY=your_api_key
        ')
        exit
      end

      unless FlickrImgParser.configuration.image_file_path
        say('
          You cannot run this programme without giving a path for your collage image.
          Please type $export FLICKR_IMAGE_PATH=/your/desired/path/
        ')
        exit
      end

      say("
        Ok, awesome! You entered #{keywords.length} keyword(s).
      ")

      if keywords.length < 10
        say("
          I will now search for #{10 - keywords.length} additional keywords, and then fetch
          associated images to compose a collage.
        ")
      else
        say("
          I will fetch images to compose a collage. Get ready....
        ")
      end

      FlickrImgParser.getting_images(keywords)

      say("
        I am done! Thanks for playing! You can check out your collage under: #{FlickrImgParser.configuration.image_file_path}
      ")
    end
  end
end
