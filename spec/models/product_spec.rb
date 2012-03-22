require 'spec_helper'

describe Product do
  it "can be instantiated" do
    Product.new.should be_an_instance_of(Product)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:product_code) }
  it { should validate_presence_of(:price) }
  it { should have_many(:transactions)}

end
