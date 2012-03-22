class Transaction < ActiveRecord::Base
  validates_presence_of :product, :checkout
  belongs_to :checkout
  belongs_to :product
end