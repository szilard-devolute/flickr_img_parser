require 'open-uri'
require 'tempfile'

module CollageMagic
  class CollageComposer
    attr_reader :image_url_list, :tempfiles

    def initialize(image_url_list = [])
      @image_url_list = image_url_list
      @tempfiles = []
    end

    def compose_collage
      save_images_to_tempfiles
      compose_montage
      delete_tempfiles
    end

    private

    def save_images_to_tempfiles
      CollageMagic.logger.info 'Saving image for collage... please be patient!'
      image_url_list.each_with_index do |url, _index|
        image_file = Tempfile.new(['tmp_image', '.jpg'])
        image_file.write open(url).read
        image_file.rewind
        image_file.close
        `convert #{image_file.path} -resize 400x300^ -gravity center -crop 400x300+0+0 +repage #{image_file.path}`
        tempfiles << image_file
      end
    end

    def compose_montage
      `montage #{tempfiles.map(&:path).join(' ')} -geometry 400x300>-10-10 -tile 2x5 #{montage_file_path}`
    end

    def delete_tempfiles
      tempfiles.each do |tempfile|
        tempfile.close
        tempfile.unlink
      end
    end

    def montage_file_path
      dir = CollageMagic.configuration.collage_file_path
      file_number = Dir["#{dir}/**/*"].length + 1
      File.join("#{dir}/flickr_montage_#{file_number}.jpg")
    end
  end
end
