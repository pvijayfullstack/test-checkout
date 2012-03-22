class CheckoutHbtmPricingRules < ActiveRecord::Migration
  def change
    create_table :checkouts_pricing_rules, :id => false do |t|
      t.integer :checkout_id
      t.integer :pricing_rule_id
    end
  end
end
