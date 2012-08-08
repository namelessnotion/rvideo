require File.expand_path("../../spec_helper", __FILE__)
require File.expand_path("../../../lib/rvideo/frame_capturer", __FILE__)
describe RVideo::FrameCapturer do
  describe "#calculate_time" do
    context "percentage timecode" do
      it "should format time to 3 decimal places" do
        mock_inspector = mock("Mock inspector", :width => 500, :height => 500, :rotated? => false, :duration => 5102555.08)
        RVideo::Inspector.stub(:new).and_return(mock_inspector)
        fc = RVideo::FrameCapturer.new(:input => '/imaginary/file.avi')
        fc.calculate_time("10%").should eq(510.256)
      end
    end
  end
end
