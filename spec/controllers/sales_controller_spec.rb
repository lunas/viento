require 'spec_helper'

describe SalesController do
  describe "POST create" do

    login_user

    before do
      @client = FactoryGirl.create(:client)
      @piece  = FactoryGirl.create(:piece)
    end

    def sale_hash
      { "client_id" => @client.id,
        "piece_id" => @piece.id,
        "client_name_and_city" => @client.name_and_city,
      }
    end

    it "should have a current_user" do
      subject.current_user.should_not be_nil
    end

    context "with minimal valid params" do
      it "creates a new sale" do
        post :create, sale: sale_hash
        response.should redirect_to(clients_path)
        @client.sales.size.should == 1
        Sale.all.size.should == 1
        sale = @client.sales.first
        sale.id.should == @piece.sales.first.id
      end
    end

    context "with date and actual_price" do
      it "creates a new sale using provided actual_price and date" do
        post :create, sale: sale_hash.merge(date: 2.days.ago, actual_price: 999)
        @client.sales.size.should == 1
        Sale.all.size.should == 1
        sale = @client.sales.first
        sale.id.should == @piece.sales.first.id
        sale.date.should == 2.days.ago.to_date
        sale.actual_price.should == 999
      end
    end

    context "with missing client_id" do
      it "doesn't save the sale" do
        Sale.all.size.should == 0 # before
        expect {
          sale = sale_hash
          sale.delete("client_id")
          post :create, sale: sale
        }.to_not change {@client.sales.size}.from 0
        Sale.all.size.should == 0
      end
    end

    context "with missing piece_id" do
      it "doesn't save the sale" do
        Sale.all.size.should == 0 # before
        expect {
          sale = sale_hash
          sale.delete("piece_id")
          post :create, sale: sale
        }.to_not change {@client.sales.size}.from 0
        Sale.all.size.should == 0
      end
    end

    context "with client_name_and_city not matching client.name_and_city" do
      it "doesn't save the sale" do
        Sale.all.size.should == 0 # before
        expect {
          post :create, sale: sale_hash.merge("client_name_and_city" => 'wrong')
        }.to_not change {@client.sales.size}.from 0
        @client.sales.size.should == 0
        Sale.all.size.should == 0
      end
    end


  end
end