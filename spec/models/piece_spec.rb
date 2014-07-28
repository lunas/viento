require 'spec_helper'

describe Piece do

  describe "count_stock and count_sold" do

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

  describe "table_by_" do

    before :each do
      @sputnik34 = FactoryGirl.create(:piece, name: 'Sputnik', collection: "10", size: 34, count_produced: 10)
      @sputnik36 = FactoryGirl.create(:piece, name: 'Sputnik', collection: "10", size: 36, count_produced: 20)
      @chelsea34 = FactoryGirl.create(:piece, name: 'Chelsea', collection: "11", size: 34, count_produced: 30)
      @chelsea36 = FactoryGirl.create(:piece, name: 'Chelsea', collection: "11", size: 36, count_produced: 40)
      @xenia36   = FactoryGirl.create(:piece, name: 'Xenia',   collection: "10", size: 36, count_produced: 50)

      FactoryGirl.create(:sale, piece: @sputnik34, date: '2013-02-01')
      FactoryGirl.create(:sale, piece: @sputnik34, date: '2013-03-01', client: Client.first)
      FactoryGirl.create(:sale, piece: @sputnik36, date: '2013-02-01', client: Client.first)
      FactoryGirl.create(:sale, piece: @sputnik36, date: '2013-03-01', client: Client.first)

      FactoryGirl.create(:sale, piece: @chelsea34, date: '2013-02-01', client: Client.first)
      FactoryGirl.create(:sale, piece: @chelsea34, date: '2013-03-01', client: Client.first)
      FactoryGirl.create(:sale, piece: @chelsea36, date: '2013-02-01', client: Client.first)
      FactoryGirl.create(:sale, piece: @chelsea36, date: '2013-03-01', client: Client.first)

      FactoryGirl.create(:sale, piece: @xenia36,   date: '2013-03-03')

      # test test data:
      Sale.where(piece_id: @chelsea34.id).size.should == 2
      Sale.where(piece_id: @chelsea36.id).size.should == 2
      Sale.where(piece_id: @sputnik34.id).size.should == 2
      Sale.where(piece_id: @sputnik36.id).size.should == 2
      Sale.where(piece_id: @xenia36.id).size.should == 1
      Piece.all.size.should == 5
      Sale.all.size.should  == 9
      Piece.where("name != 'Xenia'").each {|piece| piece.sales_count.should == 2}
      Piece.where(name: 'Xenia').each     {|piece| piece.sales_count.should == 1}
    end

    describe "table_by_size" do
      it "crosstabs pieces by name and size" do
        table = Piece.table_by_size
        table[0].should == ["Name/Groesse", "34", "36", "total"]
        table[1].should == ["Chelsea", [2, 28], [2, 38], [4, 66]]
        table[2].should == ["Sputnik", [2, 8], [2, 18],  [4, 26]]
        table[3].should == ["Xenia", nil, [1, 49], [1, 49]]
        table[4].should == ["total", [4, 36], [5, 105], [9, 141]]
      end
    end

    context "date criteria include all sales" do
      before do
        @from = '2013-01-01'
        @to   = '2013-04-01'
      end
      it "lists the sales per collection and piece" do
        table = Piece.table_by_collection(@from, @to)
        table[0].should == ["Name/Kollektion", "10", "11", "total"]
        table[1].should == ["Chelsea", nil, [4, 66], [4, 66]]
        table[2].should == ["Sputnik", [4, 26], nil, [4, 26]]
        table[3].should == ["Xenia",   [1, 49], nil, [1, 49]]
        table[4].should == ["total",   [5, 75], [4, 66], [9, 141]]
      end
    end

    context "date criteria exclude early sales" do
      before do
        @from = '2013-02-02'
        @to   = '2013-04-01'
      end
      it "lists the sales per collection and piece" do
        table = Piece.table_by_collection(@from, @to)
        table[0].should == ["Name/Kollektion", "10", "11", "total"]
        table[1].should == ["Chelsea", nil, [2, 68], [2, 68] ]
        table[2].should == ["Sputnik", [2, 28], nil, [2, 28] ]
        table[3].should == ["Xenia",   [1, 49], nil, [1, 49] ]
        table[4].should == ["total",   [3, 77], [2, 68], [5, 145] ]
      end
    end

    context "date criteria exclude late sales" do
      before do
        @from = '2013-01-01'
        @to   = '2013-02-22'
      end
      it "lists the sales per collection and piece" do
        table = Piece.table_by_collection(@from, @to)
        table[0].should == ["Name/Kollektion", "10", "11", "total"]
        table[1].should == ["Chelsea", nil, [2, 68], [2, 68] ]
        table[2].should == ["Sputnik", [2, 28], nil, [2, 28] ]
        table[3].should == ["total",   [2, 28], [2, 68], [4, 96] ]
      end
    end

    context "date criteria include only latest sales" do
      before do
        @from = '2013-03-02'
        @to   = '2013-04-04'
      end
      it "lists the sales per collection and piece" do
        table = Piece.table_by_collection(@from, @to)
        table[0].should == ["Name/Kollektion", "10",     "total"]
        table[1].should == ["Xenia",            [1, 49], [1, 49] ]
        table[2].should == ["total",     [1, 49], [1, 49] ]
      end
    end


    context "date criteria exclude all sales" do
      before do
        @from = '2013-03-20'
        @to   = '2013-04-01'
      end
      it "lists the sales per collection and piece" do
        table = Piece.table_by_collection(@from, @to)
        table.should == {}
      end
    end

  end
end
