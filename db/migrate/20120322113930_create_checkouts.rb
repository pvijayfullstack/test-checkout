class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|

      t.timestamps
    end

    create_table :transactions do |t|
      t.integer :checkout_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end

    create_table :products  do |t|
      t.string :code
      t.string :name
      t.decimal :price

      t.timestamps
    end

    create_table :pricing_rules  do |t|
      t.string :type   #BULK or BOGOG
      t.integer :product_id
      t.decimal :bulk_price
      t.integer :bulk_threshold

      t.timestamps
    end

  end
end
