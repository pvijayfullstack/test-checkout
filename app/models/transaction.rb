class Transaction < ActiveRecord::Base
  validates_presence_of :product, :checkout, :no_of_items
  belongs_to :checkout
  belongs_to :product

end