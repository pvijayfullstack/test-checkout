class Checkout < ActiveRecord::Base

  has_many :transactions
  has_and_belongs_to_many :pricing_rules

  def total
    total = 0
    for transaction in self.transactions do
      total += transaction.product.price * transaction.no_of_items
    end
    total
  end

end
