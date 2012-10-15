require 'spec_helper'

describe Sale do

  describe "#actual_price" do
    context "actual_price is set" do
      before do
        @piece = FactoryGirl.create(:piece, name: 'Testo', price: 1000)
        @sale = FactoryGirl.create(:sale, actual_price: 900, piece: @piece)
      end
      it "returns its actual_price " do
        @sale.actual_price.should == 900
      end
    end
    context "actual_price is not set in sale, but in piece" do
      before do
        @piece = FactoryGirl.create(:piece, name: 'Testo', price: 1000)
        @sale  = FactoryGirl.create(:sale, actual_price: nil, piece: @piece)
      end
      it "returns price of piece it belongs to" do
        @sale.actual_price.should == 1000
      end
    end
    context "actual_price is not set, and sale has no piece" do
      before do
        @sale  = Sale.new()
      end
      it "should be invalid" do
        @sale.should be_invalid
        @sale.errors[:actual_price].any?.should be_true
      end
    end

  end

  describe "#before_update: #copy piece.price if actual_price is empty" do
    before do
      @piece = FactoryGirl.create(:piece, name: 'Testo', price: 1000)
      @client = FactoryGirl.create(:client)
    end
    context "actual_price is present" do
      it "shouldn't overwrite the actual price with the piece's price" do
        sale = Sale.new(actual_price: 500, piece_id: @piece.id, client_id: @client.id)
        sale.save
        sale.actual_price.should == 500
      end
    end
    context "actual_price is not present" do
      it "should overwrite the actual price with the piece's price" do
        sale = Sale.new(actual_price: nil, piece_id: @piece.id, client_id: @client.id)
        sale.read_attribute(:actual_price).should be_nil
        sale.save
        sale.read_attribute(:actual_price).should == @piece.price
      end
    end
  end


end
