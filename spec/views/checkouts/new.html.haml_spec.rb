require 'spec_helper'

describe "checkouts/new" do
  before(:each) do
    assign(:checkout, stub_model(Checkout).as_new_record)
  end

  it "renders new checkout form" do
    render

    assert_select "form", :action => checkouts_path, :method => "post" do
    end
  end
end
