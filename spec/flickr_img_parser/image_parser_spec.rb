require 'spec_helper'

module FlickrImgParser
  describe ImageParser, :vcr do
    context 'with any number of keywords' do
      let(:keywords) { ['dog', 'cat'] }
      subject { ImageParser.new(keywords) }

      it 'returns 10 images' do
        array = subject.retrieve_images
        expect(array[9]).to be_a(String)
        expect(array[10]).to be nil
      end
    end

    context 'with more than 10 images' do
      let(:keywords) { Array.new(12, 'cat') }
      subject { ImageParser.new(keywords) }

      it "doesn't call the random word API" do
        subject.retrieve_images
        expect(subject).to_not receive(:random_keyword)
        expect(keywords).to_not eq([])
      end
    end

    context 'with less than 10 images' do
      let(:keywords) { [] }
      subject { ImageParser.new(keywords) }

      it 'calls the random words API' do
        subject.retrieve_images
        expect(subject).to receive(:random_keyword)
        expect(keywords).to eq([])
      end
    end
  end
end
