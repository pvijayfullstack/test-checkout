require 'spec_helper'

describe "checkouts/total" do
  before(:each) do
    @checkout = assign(:checkout, stub_model(Checkout))
  end

  it "renders the total" do
    render
  end
end
