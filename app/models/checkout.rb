class Checkout < ActiveRecord::Base

  has_many :transactions
  has_and_belongs_to_many :pricing_rules

  #def scan(item)
  #  if self.transactions.find_by_product(item).present?
  #    @transaction = self.transactions.find_by_product(item)
  #    @transaction.no_of_items = @transaction.no_of_items+1
  #    @transaction.save!
  #  else
  #    @transaction = Transaction.create do |t|
  #      t.product_id = item.id
  #      t.checkout_id = self.id
  #      t.no_of_items = 1
  #    end
  #  end
  #  return true
  #end

  def total
    total = 0
    for transaction in self.transactions do
      total += transaction.product.price * transaction.no_of_items
    end
    total
  end

end
