require 'spec_helper'

module CollageMagic
  describe ImageIdCollector, :vcr do
    subject { ImageIdCollector.new(keywords) }

    context 'with any number of keywords' do
      let(:keywords) { ['dog', 'cat'] }

      it 'returns 10 images' do
        array = subject.collect_image_ids
        expect(array[9]).to be_a(String)
        expect(array[10]).to be nil
      end
    end

    context 'with 10 or more keywords' do
      let(:keywords) { Array.new(12, 'cat') }

      it 'does not call the random word API' do
        subject.collect_image_ids
        expect(keywords).to_not eq([])
      end
    end

    context 'with less than 10 keywords' do
      let(:keywords) { ['cat'] }

      it 'calls the random word API' do
        subject.collect_image_ids
        expect(keywords).to eq([])
      end
    end

    # describe 'handle exceptions' do
    #   let(:keywords) { [] }
    #
    #   context 'with a timeout' do
    #     it 'retries 3 times and then re-raises the exception' do
    #       expect(CollageMagic::FlickrApi).to receive(:fetch_interesting_images).exactly(5).times.and_raise(Net::ReadTimeout)
    #       expect { subject.collect_image_ids }.to raise_error(Net::ReadTimeout)
    #     end
    #   end
    #
    #   context "with a StandardError" do
    #     before do
    #       allow(CollageMagic::FlickrApi).to receive(:fetch_interesting_images).and_raise(StandardError)
    #     end
    #
    #     it "does not die" do
    #       expect{subject.collect_image_ids}.to_not raise_error
    #     end
    #   end
    #
    #   context "with an error message" do
    #     before do
    #       allow(CollageMagic::FlickrApi).to receive(:fetch_interesting_images).and_return({"stat"=>"fail", "code"=>100, "message"=>"Invalid API Key (Key has invalid format)"})
    #     end
    #
    #     it "does not throw an exception" do
    #       expect{subject.collect_image_ids}.to_not raise_error
    #     end
    #
    #   end
    # end
  end
end
