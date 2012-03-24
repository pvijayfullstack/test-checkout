require 'spec_helper'

describe Checkout do
  it "can be instantiated" do
    Checkout.new.should be_an_instance_of(Checkout)
  end

  it {should have_many(:transactions)}
  it {should have_and_belong_to_many(:pricing_rules)}

  describe "Checkout#total" do
    before :each do
      @product1 = FactoryGirl.build(:product, :price => 3)
      @product2 = FactoryGirl.build(:product, :price => 5)
    end

    it "adds up checkout transactions" do
      @checkout = FactoryGirl.build(:checkout)
      @checkout.transactions << FactoryGirl.build(:transaction, :product => @product1)
      2.times do
        @checkout.transactions << FactoryGirl.build(:transaction, :product => @product2)
      end
      @checkout.total.should eq(@product1.price+(@product2.price*2))
    end

    it "recognised a buy one get one free (bogof) pricing rule" do
      @pricing_rule = FactoryGirl.build(:pricing_rule, :discount_type => "bogof", :product => @product1)
      @checkout = FactoryGirl.build(:checkout, :pricing_rules => [@pricing_rule])
      2.times do
        @checkout.transactions << FactoryGirl.build(:transaction, :product => @product1)
      end
      @checkout.total.should eq(@product1.price)
    end

    it "recognised a bulk pricing rule" do
      @pricing_rule = FactoryGirl.build(:pricing_rule, :discount_type => "bulk", :product => @product1, :bulk_threshold => 3, :bulk_price => 2.5)
      @checkout = FactoryGirl.build(:checkout, :pricing_rules => [@pricing_rule])
      3.times do
        @checkout.transactions << FactoryGirl.build(:transaction, :product => @product1)
      end
      @checkout.total.should eq(@pricing_rule.bulk_price*3)
    end
  end

end
