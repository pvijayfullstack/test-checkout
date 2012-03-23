class PricingRule < ActiveRecord::Base

  VALID_TYPES = %w(bogof bulk)

  validates_presence_of :discount_type, :product
  validates_inclusion_of :discount_type, :in => VALID_TYPES

  belongs_to :product
  has_and_belongs_to_many :checkouts

  def description
    if self.discount_type == "bulk"
      "#{product.name} #{discount_type}(#{bulk_threshold}) at #{bulk_price}"
    else
      "#{product.name} #{discount_type}"
    end
  end
end