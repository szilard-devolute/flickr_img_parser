module Generators  
  class FlickrImgParserGenerator < Thor::Group
    include Thor::Actions

    def self.source_root
      File.expand_path('..', __FILE__)
    end

    def create_initializer_file
      template('flickr_img_parser_initializer.rb', 'config/initializers/flickr_img_parser.rb')
    end
  end
end
