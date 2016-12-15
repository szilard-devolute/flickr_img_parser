require 'open-uri'
require 'tempfile'
require 'rmagick'

module FlickrImgParser
  class ImageComposer
    include Magick

    attr_reader :image_url_list, :tempfiles

    def initialize(image_url_list = [])
      @image_url_list = image_url_list
      @tempfiles = []
    end

    def compose
      save_images_to_tempfiles
      compose_montage
      delete_tempfiles
    end

    private

    def save_images_to_tempfiles
      image_url_list.each_with_index do |url, index|
        image_file = Tempfile.new(["tmp_image", '.jpg'])
        image_file.write open(url).read
        tempfiles << image_file
      end
      puts tempfiles
    end

    def compose_montage
      `montage #{tempfiles.map(&:path).join(" ")} #{montage_file_path}`
    end

    def delete_tempfiles
      tempfiles.each do |tempfile|
        tempfile.close
        tempfile.unlink
      end
    end

    def montage_file_path
      dir = ENV['FLICKR_IMAGE_PATH']
      file_number = Dir["#{dir}/**/*"].length + 1
      File.join("#{dir}/flickr_montage_#{file_number}.jpg")
    end
  end
end
