require 'spec_helper'

describe Client do
  describe "#sales_total" do
    context "with sales" do
      before do
        @client = FactoryGirl.create(:client)
        @client.sales << Sale.new(actual_price: 1000)
        @client.sales << Sale.new(actual_price: 400)
      end
      it "returns the sum of #actual_price of the client's sales" do
        @client.sales_total.should == 1400
      end
    end
    context "without sales" do
      before do
        @client = FactoryGirl.create(:client)
      end
      it "should return 0" do
        @client.sales_total.should == 0
      end
    end
  end

  describe "#sales_count" do
    context "with sales" do
      before :each do
        @client = FactoryGirl.create(:client)
        @client.sales << Sale.new(actual_price: 1000)
        @client.sales << Sale.new(actual_price: 400)
      end
      it "returns the number of the client's sales" do
        @client.sales_count.should == 2
      end
    end
    context "without sales" do
      before :each do
        @client = FactoryGirl.create(:client)
      end
      it "returns 0" do
        @client.sales_count.should == 0
      end
    end
  end

  describe "#latest_sale" do
    context "with sales" do
      before :each do
        @client = FactoryGirl.create(:client)
        @client.sales << Sale.new(actual_price: 1000, date: 4.days.ago)
        @client.sales << Sale.new(actual_price: 400,  date: 2.days.ago)
        @client.sales << Sale.new(actual_price: 500,  date: 7.days.ago)
      end
      it "returns the latest sale of this client" do
        @client.latest_sale_date.should == 2.days.ago.to_date
      end
    end
    context "without sales" do
      before :each do
        @client = FactoryGirl.create(:client)
      end
      it "returns nil" do
        @client.latest_sale_date.should be_nil
      end
    end
  end

end
