class Checkout < ActiveRecord::Base

  has_many :transactions
  has_and_belongs_to_many :pricing_rules

  def scan(item)
    if self.transactions.select(:product_id => item.id).length > 0     #TODO can be done nicer?
      self.transactions.select(:product_id => item.id).amount.increment!
    else
      @transaction = Transaction.create do |t|
        t.product_id = item.id
        t.checkout_id = self.id
        t.amount = 1
      end
    end
  end

  def total
    total = 0
    for transaction in self.transactions do
      total += transaction.product.price * transaction.amount
    end
    total
  end

end
