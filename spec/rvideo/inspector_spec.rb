require File.expand_path("../../spec_helper", __FILE__)


    "Stream #0:0[0x1c0]: Audio: mp2, 32000 Hz, mono, s16, 64 kb/s"
    "Stream #0:1[0x1e0]: Video: mpeg1video, yuv420p, 640x480 [SAR 1:1 DAR 4:3], 104857 kb/s, 25 fps, 25 tbr, 90k tbn, 25 tbc"


    "Stream #0:0: Video: flv1, yuv420p, 640x480, 2004 kb/s, 29.97 tbr, 1k tbn, 1k tbc"
    "Stream #0:1: Audio: mp3, 44100 Hz, mono, s16, 160 kb/s"


describe RVideo::Inspector do
  describe "parsing video metadata" do
    before(:each) do
      @inspector = RVideo::Inspector.new(:raw_response => "going to mock video_stream audio_stream")
      @inspector.stub(:valid?) { true }
    end
    context "mpeg video" do
      before(:each) do
        @inspector.stub(:video_stream) {"Stream #0:1[0x1e0]: Video: mpeg1video, yuv420p, 640x480 [SAR 1:1 DAR 4:3], 104857 kb/s, 25 fps, 25 tbr, 90k tbn, 25 tbc"}
      end
      specify { @inspector.width.should == 640 }
      specify { @inspector.height.should == 480 }
      specify { @inspector.fps.should == "25" }
      specify { @inspector.resolution.should == "640x480" }
      specify { @inspector.pixel_aspect_ratio.should == "1:1" }
      specify { @inspector.display_aspect_ratio.should == "4:3" }
      specify { @inspector.video_bit_rate.should == "104857" }
      specify { @inspector.video_bit_rate_units.should == "kb/s" }
      specify { @inspector.time_base.should == "90k" }
      specify { @inspector.codec_time_base.should == "25" }
      specify { @inspector.video_stream_id.should == "#0:1" }
      specify { @inspector.video_codec.should == "mpeg1video" }
      specify { @inspector.video_colorspace.should == "yuv420p" }
    end

    context "rotated mp4 video" do
      before(:each) do
        @inspector.stub(:raw_metadata) {
%q{Input #0, mov,mp4,m4a,3gp,3g2,mj2, from '/Users/anthony/Downloads/IMG_2325.MOV':  
   Metadata:
    major_brand     : qt
    minor_version   : 0
    compatible_brands: qt
    creation_time   : 2013-05-10 13:52:41
    make            : Apple
    make-eng        : Apple
    encoder         : 6.0.1
    encoder-eng     : 6.0.1
    date            : 2013-05-10T09:50:44-0400
    date-eng        : 2013-05-10T09:50:44-0400
    model           : iPhone 4S
    model-eng       : iPhone 4S
  Duration: 00:00:10.06, start: 0.000000, bitrate: 825 kb/s
    Stream #0:0(und): Audio: aac (mp4a / 0x6134706D), 44100 Hz, mono, fltp, 62 kb/s
    Metadata:
      creation_time   : 2013-05-10 13:52:41
      handler_name    : Core Media Data Handler
    Stream #0:1(und): Video: h264 (Main) (avc1 / 0x31637661), yuv420p, 480x272, 755 kb/s, 30 fps, 30 tbr, 600 tbn, 1200 tbc
    Metadata:
      rotate          : 90
      creation_time   : 2013-05-10 13:52:41
      handler_name    : Core Media Data Handler
}

        }
      end

      describe "#rotated?" do
        it "should return true" do
          @inspector.rotated?.should == true
        end
      end

      describe "#video_orientation" do
        it "should return 90" do
          @inspector.video_orientation.should == 90
        end
      end
    end

    context "flv video" do
      before(:each) do
        @inspector.stub(:video_stream) {"Stream #0:0: Video: flv1, yuv420p, 640x480, 2004 kb/s, 29.97 tbr, 2k tbn, 1k tbc"}
      end
      specify { @inspector.width.should == 640 }
      specify { @inspector.height.should == 480 }
      specify { @inspector.fps.should == "29.97" }
      specify { @inspector.resolution.should == "640x480" }
      specify { @inspector.pixel_aspect_ratio.should == nil }
      specify { @inspector.display_aspect_ratio.should == nil }
      specify { @inspector.video_bit_rate.should == "2004" }
      specify { @inspector.video_bit_rate_units.should == "kb/s" }
      specify { @inspector.time_base.should == "2k" }
      specify { @inspector.codec_time_base.should == "1k" }
      specify { @inspector.video_stream_id.should == "#0:0" }
      specify { @inspector.video_codec.should == "flv1" }
      specify { @inspector.video_colorspace.should == "yuv420p" }
    end
  end
end
