class Product < ActiveRecord::Base
  validates_presence_of :name, :product_code, :price
  has_many :transactions
end