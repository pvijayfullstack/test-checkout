class PricingRule < ActiveRecord::Base

  VALID_TYPES = %w(bogof bulk)

  validates_presence_of :type, :product
  validates_inclusion_of :type, :in => VALID_TYPES

  belongs_to :product
  has_and_belongs_to_many :checkouts

end