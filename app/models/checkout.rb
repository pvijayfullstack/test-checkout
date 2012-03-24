class Checkout < ActiveRecord::Base

  has_many :transactions
  has_and_belongs_to_many :pricing_rules

  def total
    total = 0
    for transaction in self.transactions do
      total += transaction.product.price * transaction.no_of_items
    end
    for pricing_rule in self.pricing_rules do
      if pricing_rule.discount_type == "bogof"
        item_count = self.transactions.select{|i| i.product_id == pricing_rule.product_id}.length
        total -= (item_count/2).to_i*pricing_rule.product.price
      else
        item_count = self.transactions.select{|i| i.product_id == pricing_rule.product_id}.length
        if item_count >= pricing_rule.bulk_threshold
          total -= item_count*(pricing_rule.product.price - pricing_rule.bulk_price)
        end
      end
    end
    total
  end

end
