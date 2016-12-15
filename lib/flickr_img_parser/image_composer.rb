require 'open-uri'
require 'tempfile'

module FlickrImgParser
  class ImageComposer

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
        image_file.rewind
        image_file.close
        puts image_file.path
        cropped_image_file = Tempfile.new(["tmp_cropped_image", '.jpg'])
        cropped_image_file.rewind
        cropped_image_file.close
        puts cropped_image_file.path
        `convert #{image_file.path} -resize '400x300^' -gravity center -crop 400x300+0+0 +repage #{cropped_image_file.path}`
        tempfiles << cropped_image_file
      end
      puts tempfiles.map(&:path)
    end

    def compose_montage
      `montage #{tempfiles.map(&:path).join(" ")} -geometry 400x300>-10-10 -tile 2x5 #{montage_file_path}`
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
