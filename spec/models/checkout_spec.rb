require 'spec_helper'

describe Checkout do
  it "can be instantiated" do
    Checkout.new.should be_an_instance_of(Checkout)
  end

  it {should have_many(:transactions)}
  it {should have_and_belong_to_many(:pricing_rules)}

  describe "Checkout#total" do
    before :each do
      @product = FactoryGirl.build(:product, :price => 10)
      @pricing_rule = FactoryGirl.build(:pricing_rule, :type => "bulk", :bulk_price => 8)
      @checkout = FactoryGirl.build(:checkout)
      @transaction = FactoryGirl.build(:transaction, :product => @product, :checkout => @checkout)
      @checkout.transactions << @transaction
    end

    it "adds up value of all transactions" do
      @checkout.total.should eq(10)
    end

  end

  describe "Checkout#scan" do
    before :each do
      @item = FactoryGirl.build(:product)
      @checkout = FactoryGirl.build(:checkout)
      @transaction = FactoryGirl.build(:transaction, :product => @item, :checkout => @checkout)
      Transaction.should_receive(:create).and_return(@transaction)
    end

    it "creates a transaction" do
      @checkout.scan(@item).should eq(@transaction)
    end

  end
end
