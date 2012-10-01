require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PiecesHelper. For example:
#
# describe PiecesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe PiecesHelper do
  describe "times" do
    it "should return 'nie' if number is nil or 0" do
      times.should == 'nie'
      times(0).should == 'nie'
    end
    it "should return 'einmal' if number is 1" do
      times(1).should == 'einmal'
    end
    it "should return 'zwemal' if number is 2" do
      times(2).should == 'zweimal'
    end
    it "should return 'dreimal' if number is 3" do
      times(3).should == 'dreimal'
    end
    it "should return 'n mal' if number is n" do
      times(4).should == '4 mal'
      times(100).should == '100 mal'
    end
  end
end
