require 'spec_helper'

describe "pieces/show" do
  before(:each) do
    @piece = assign(:piece, stub_model(Piece,
      :name => "Name",
      :collection => "Collection",
      :color => "Color",
      :fabric => 1,
      :count => 2,
      :price => "9.99",
      :costs => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Collection/)
    rendered.should match(/Color/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
  end
end
