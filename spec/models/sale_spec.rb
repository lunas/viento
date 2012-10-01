require 'spec_helper'

describe Sale do

  describe "#actual_price" do
    context "actual_price is set" do
      before do
        @sale = FactoryGirl.create(:sale, actual_price: 900, piece: @piece)
      end
      it "returns its actual_price " do
        @sale.actual_price.should == 900
      end
    end
  end
  context "actual_price is not set" do
    before do
      @piece = FactoryGirl.create(:piece, name: 'Testo', price: 1000)
      @sale  = FactoryGirl.create(:sale, actual_price: nil, piece: @piece)
    end
    it "returns price of piece it belongs to" do
      @sale.actual_price.should == 1000
    end
  end

end
