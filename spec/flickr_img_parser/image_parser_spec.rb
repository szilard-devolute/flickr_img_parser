require 'spec_helper'

module FlickrImgParser
  describe ImageParser, :vcr do
    subject { ImageParser.new(keywords) }

    context 'with any number of keywords' do
      let(:keywords) { ['dog', 'cat'] }

      it 'returns 10 images' do
        array = subject.retrieve_images
        expect(array[9]).to be_a(String)
        expect(array[10]).to be nil
      end
    end

    context 'with more than 10 images' do
      let(:keywords) { Array.new(12, 'cat') }

      it 'does not call the random word API' do
        subject.retrieve_images
        expect(keywords).to_not eq([])
      end
    end

    context 'with less than 10 images' do
      let(:keywords) { ['cat'] }

      it 'calls the random word API' do
        subject.retrieve_images
        expect(keywords).to eq([])
      end
    end

    describe 'handling exceptions' do
      let(:keywords) { [] }

      context 'with a timeout' do

        it 'retries 3 times and then re-raises the exception' do

          expect(FlickrImgParser::FlickrApi).to receive(:fetch_interesting_images).exactly(5).times.and_raise(Net::ReadTimeout)
          expect{ subject.retrieve_images }.to raise_error(Net::ReadTimeout)
        end

      end

      # context "with a StandardError" do
      #   before do
      #     allow(FlickrImgParser::FlickrApi).to receive(:fetch_interesting_images).and_raise(StandardError)
      #   end

      #   it "does not die" do
      #     expect{subject.retrieve_images}.to_not raise_error
      #   end
      # end

      # context "with an error message" do
      #   before do
      #     allow(FlickrImgParser::FlickrApi).to receive(:fetch_interesting_images).and_return({"stat"=>"fail", "code"=>100, "message"=>"Invalid API Key (Key has invalid format)"})
      #   end

      #   it "does not throw an exception" do
      #     expect{subject.retrieve_images}.to_not raise_error
      #   end

      # end

    end

  end
end
