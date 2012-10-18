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

  describe "#client_name_and_city" do
    context "with client" do
      before do
        @client = FactoryGirl.create(:client)
      end
      it "returns client.name_and_city" do
        sale = Sale.new(client_id: @client.id)
        sale.client_name_and_city.should == @client.name_and_city
      end
    end
    context "without client" do
      it "returns nil" do
        sale = Sale.new
        sale.client_name_and_city.should be_nil
      end
    end
  end

  describe "#client_name_and_city=" do
      it "sets @tmp_client_name_and_city" do
        sale = Sale.new
        sale.client_name_and_city = 'Something'
        sale.instance_variable_get(:@tmp_client_name_and_city).should == 'Something'
      end
  end

  describe "#piece_info" do
    context "with piece" do
      before do
        @piece = FactoryGirl.create(:piece)
      end
      it "returns piece.info" do
        sale = Sale.new(piece_id: @piece.id)
        sale.piece_info.should == @piece.info
      end
    end
    context "without piece" do
      it "returns nil" do
        sale = Sale.new
        sale.piece_info.should be_nil
      end
    end
  end

  describe "#piece_info=" do
    it "sets @tmp_piece_info" do
      sale = Sale.new
      sale.piece_info = 'something'
      sale.instance_variable_get(:@tmp_piece_info).should == 'something'
    end
  end

  describe "#save" do
    context "client_name_and_city matches with client specified by client_id" do
      before do
        @piece = FactoryGirl.create(:piece, name: 'Testo')
        @client = FactoryGirl.create(:client)
      end
      it "is valid" do
        sale = Sale.new(piece_id: @piece.id, client_id: @client.id)
        sale.client_name_and_city = @client.name_and_city
        sale.valid?.should be_true
      end
    end
    context "client_name_and_city doesn't match with client specified by client_id" do
      before do
        @piece = FactoryGirl.create(:piece, name: 'Testo')
        @client = FactoryGirl.create(:client)
      end
      it "is not valid" do
        sale = Sale.new(piece_id: @piece.id, client_id: @client.id)
        sale.client_name_and_city = 'wrong'
        sale.valid?.should be_false
      end
    end
    context "piece_info matches with piece specified by piece_id" do
      before do
        @piece = FactoryGirl.create(:piece, name: 'Testo')
        @client = FactoryGirl.create(:client)
      end
      it "is valid" do
        sale = Sale.new(piece_id: @piece.id, client_id: @client.id)
        sale.piece_info = @piece.info
        sale.valid?.should be_true
      end
    end
    context "piece_info doesn't match with piece specified by piece_id" do
      before do
        @piece = FactoryGirl.create(:piece, name: 'Testo')
        @client = FactoryGirl.create(:client)
      end
      it "is not valid" do
        sale = Sale.new(piece_id: @piece.id, client_id: @client.id)
        sale.piece_info = 'wrong'
        sale.valid?.should be_false
      end
    end

  end
end
