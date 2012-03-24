require 'spec_helper'

describe Transaction do
  it "can be instantiated" do
    Transaction.new.should be_an_instance_of(Transaction)
  end

  it { should validate_presence_of(:product) }
  it { should validate_presence_of(:checkout) }
  it { should validate_presence_of(:no_of_items) }
  it { should belong_to(:product)}
  it { should belong_to(:checkout)}

  describe "Transaction#find_by_product" do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end