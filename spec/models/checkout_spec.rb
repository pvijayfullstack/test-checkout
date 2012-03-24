require 'spec_helper'

describe Checkout do
  it "can be instantiated" do
    Checkout.new.should be_an_instance_of(Checkout)
  end

  it {should have_many(:transactions)}
  it {should have_and_belong_to_many(:pricing_rules)}

  describe "Checkout#total" do
    pending "add some examples to (or delete) #{__FILE__}"
    #before :each do   #TODO tighten up this test
    #  @product = FactoryGirl.build(:product, :price => 10)
    #  @pricing_rule = FactoryGirl.build(:pricing_rule, :discount_type => "bulk", :bulk_price => 8)
    #  @checkout = FactoryGirl.build(:checkout)
    #  @transaction = FactoryGirl.build(:transaction, :product => @product, :checkout => @checkout)
    #  @checkout.transactions << @transaction
    #end
    #
    #it "adds up value of all transactions" do
    #  @checkout.total.should eq(10)
    #end
  end

end
