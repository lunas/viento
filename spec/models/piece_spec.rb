require 'spec_helper'

describe Piece do

  before :each do
    @piece = FactoryGirl.create(:piece, name: 'Ghana', price: 400, count_produced: 10, color: 'blue', fabric: 'silk')
  end

  describe "#stock" do
    context "Piece with no sales" do
      it "returns the produced count" do
        @piece.stock.should == @piece.count_produced
      end
    end

    context "Piece with 1 sale" do
      before :each do
        @piece.sales << Sale.new
      end
      it "returns the produced count minus the number of its sales" do
        @piece.stock.should == @piece.count_produced - 1
      end
    end
  end

  describe "#sold" do
    context "Piece with no sales" do
      it "returns 0" do
        @piece.sold.should == 0
      end
    end

    context "Piece with 1 sale" do
      before :each do
        @piece.sales << Sale.new
      end
      it "returns the number of its sales" do
        @piece.sold.should == 1
      end
    end
  end
end
