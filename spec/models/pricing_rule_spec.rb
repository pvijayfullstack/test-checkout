require 'spec_helper'

describe PricingRule do
  it "can be instantiated" do
    PricingRule.new.should be_an_instance_of(PricingRule)
  end

  it {should validate_presence_of(:discount_type)}
  it {should validate_presence_of(:product)}

  it {should belong_to(:product)}
  it {should have_and_belong_to_many(:checkouts)}

  it "should allow valid types" do
    PricingRule::VALID_TYPES.each do |vt|
      should allow_value(vt).for(:discount_type)
    end
  end

  it { should_not allow_value("other").for(:discount_type) }
end