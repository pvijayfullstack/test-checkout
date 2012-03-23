require 'spec_helper'

describe "checkouts/new" do
  before(:each) do
    assign(:checkout, stub_model(Checkout).as_new_record)

    assign(:pricing_rules, [
      FactoryGirl.build(:pricing_rule),
      FactoryGirl.build(:pricing_rule)
    ])
  end

  it "renders new checkout form" do
    render

    assert_select "form", :action => checkouts_path, :method => "post" do
    end
  end
end
