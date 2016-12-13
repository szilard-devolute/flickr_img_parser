# Configuration details:
FlickrImgParser.configure do |c|
  # You must set the Flickr API key. Get one here: https://www.flickr.com/services/api/

  c.flickr_api_key = ENV['FLICKR_API_KEY']

  # You can change the number of images that are parsed from Flickr, BUT the collage will include only 10 images.
  # Default is set to 10
  # c.image_number = 10

  # You can change the root directory. The default is the gem root. If you are using rails it could be Rails.root
  # c.root_path = FlickrImgParser.root

  # You can also change the target directory. The default is root_directory/saved_images/1.jpg
  # c.target_directory = 

  # To see more elaborated messages change it to DEBUG. See more here: http://ruby-doc.org/stdlib-2.1.0/libdoc/logger/rdoc/Logger.html
  # Default is set to INFO
  # c.log_level = INFO
end
