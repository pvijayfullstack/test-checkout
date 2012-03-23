require 'spec_helper'

describe "checkouts/scan" do
  before(:each) do
    @checkout = assign(:checkout, stub_model(Checkout))
  end

  it "renders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "form", :action => checkouts_path(@checkout), :method => "post" do
  end
end
