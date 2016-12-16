require 'spec_helper'

module CollageMagic
  describe CollageComposer do
    before do
      dir = File.expand_path('../test_images', __dir__)
      CollageMagic.configuration.collage_file_path = dir
    end

    after do
      dir = File.expand_path('../test_images', __dir__)
      FileUtils.rm_rf Dir.glob("#{dir}/*")
    end

    let(:image_urls) {
      Array.new(12, 'https://farm9.staticflickr.com/8260/29470874805_bb43f58d12_h.jpg')
    }

    subject { described_class.new(image_urls) }

    it 'composes a collage of the images urls', :vcr do
      subject.compose_collage
      expect(Dir.glob(CollageMagic.configuration.collage_file_path).length).to eq(1)
    end

    describe '#compose_collage' do
      it 'invokes all the methods' do
        allow(subject).to receive(:save_images_to_tempfiles)
        allow(subject).to receive(:compose_montage)
        allow(subject).to receive(:delete_tempfiles)

        subject.compose_collage

        expect(subject).to have_received(:save_images_to_tempfiles)
        expect(subject).to have_received(:compose_montage)
        expect(subject).to have_received(:delete_tempfiles)
      end
    end
  end
end
