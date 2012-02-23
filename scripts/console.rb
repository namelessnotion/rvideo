# utility console for debuging
# $ ruby script/console

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require File.expand_path("../../lib/rvideo", __FILE__)

include RVideo

class Inspector
  public :video_match
  public :audio_match
end

def inspector(filename)
  Inspector.new :file => filename
end

require 'irb'
require 'irb/completion'

IRB.start
