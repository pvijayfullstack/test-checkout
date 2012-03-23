require 'spec_helper'

describe "checkouts/scan" do
  before(:each) do
    @checkout = FactoryGirl.create(:checkout)
    assign(:checkout, @checkout)

    @product1 = FactoryGirl.build(:product)
    @product2 = FactoryGirl.build(:product)
    assign(:products, [@product1, @product2])

    @transaction = FactoryGirl.build(:transaction)
  end

  it "renders" do
    render
    assert_select "form", :action => transactions_path(@transaction), :method => "post"
  end
end
