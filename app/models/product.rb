class Product < ActiveRecord::Base
  validates_presence_of :name, :code, :price
  has_many :transactions
end