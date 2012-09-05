require 'spec_helper'

describe "pieces/new" do
  before(:each) do
    assign(:piece, stub_model(Piece,
      :name => "MyString",
      :collection => "MyString",
      :color => "MyString",
      :fabric => 1,
      :count => 1,
      :price => "9.99",
      :costs => "9.99"
    ).as_new_record)
  end

  it "renders new piece form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pieces_path, :method => "post" do
      assert_select "input#piece_name", :name => "piece[name]"
      assert_select "input#piece_collection", :name => "piece[collection]"
      assert_select "input#piece_color", :name => "piece[color]"
      assert_select "input#piece_fabric", :name => "piece[fabric]"
      assert_select "input#piece_count", :name => "piece[count]"
      assert_select "input#piece_price", :name => "piece[price]"
      assert_select "input#piece_costs", :name => "piece[costs]"
    end
  end
end
