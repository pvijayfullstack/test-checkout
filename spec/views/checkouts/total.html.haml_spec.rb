require 'spec_helper'

describe "checkouts/total" do
  before(:each) do
    @checkout = assign(:checkout, stub_model(Checkout))
  end

  it "renders the total" do
    render
    # TODO tighten up
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
