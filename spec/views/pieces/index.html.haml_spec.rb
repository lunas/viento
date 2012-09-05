require 'spec_helper'

describe "pieces/index" do
  before(:each) do
    assign(:pieces, [
      stub_model(Piece,
        :name => "Name",
        :collection => "Collection",
        :color => "Color",
        :fabric => 1,
        :count => 2,
        :price => "9.99",
        :costs => "9.99"
      ),
      stub_model(Piece,
        :name => "Name",
        :collection => "Collection",
        :color => "Color",
        :fabric => 1,
        :count => 2,
        :price => "9.99",
        :costs => "9.99"
      )
    ])
  end

  it "renders a list of pieces" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Collection".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
