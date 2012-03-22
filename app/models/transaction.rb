class Transaction < ActiveRecord::Base
  validates_presence_of :product, :checkout, :no_of_items
  belongs_to :checkout
  belongs_to :product

  def self.find_by_product(product)
     Transaction.where(:product_id => product.id).first
  end
end