require 'spec_helper'

describe Piece do

  before :each do
    @piece = FactoryGirl.create(:piece, name: 'Ghana', price: 400, count_produced: 10, color: 'blue', fabric: 'silk')
    @piece2 = FactoryGirl.create(:piece, name: 'Niro', price: 600, count_produced: 10, color: 'green', fabric: 'jeans')
  end

  describe "#count_stock" do
    context "Piece with no sales" do
      it "returns the produced count" do
        @piece.count_stock.should == @piece.count_produced
      end
    end

    context "Piece with 1 sale" do
      before :each do
        @piece.sales << Sale.new
      end
      it "returns the produced count minus the number of its sales" do
        @piece.count_stock.should == @piece.count_produced - 1
      end
    end
  end

  describe "#count_sold" do
    context "Piece with no sales" do
      it "returns 0" do
        @piece.count_sold.should == 0
      end
    end

    context "Piece with 2 sales" do
      before :each do
        @piece.sales << Sale.new(actual_price: 300)
        @piece.sales << Sale.new(actual_price: 400)
        @piece2.sales << Sale.new(actual_price: 1000)
      end

      describe "count_sold" do
        it "returns the number of its sales" do
          @piece.count_sold.should == 2
        end
      end
      describe "revenue" do
        it "returns the sum of the actual_prices of its sales" do
          @piece.revenue.should == 700
          @piece2.revenue.should == 1000
        end
        context "piece with no sales" do
          before do
            @piece_without_sales = FactoryGirl.create(:piece, name: 'Zero')
          end
          it "returns 0" do
            @piece_without_sales.revenue.should == 0
          end
        end
      end

    end
  end
end
