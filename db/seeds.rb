# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


@ft = Product.create(
  :product_code => 'FR1',
  :name => 'Fruit tea',
  :price => '3.11'
)


@sb = Product.create(
  :product_code => 'SR1',
  :name => 'Strawberries',
  :price => '5.00'
)


Product.create(
  :product_code => 'CF1',
  :name => 'Coffee',
  :price => '11.23'
)

PricingRule.create(
  :discount_type => 'bogof',
  :product => @ft
)

PricingRule.create(
  :discount_type => 'bulk',
  :product => @sb,
  :bulk_threshold => 3,
  :bulk_price => 4.50
)
