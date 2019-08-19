class ProductVendorAllocation < ApplicationRecord
  belongs_to :product
  belongs_to :vendor

  validates :allocation_percentage, :product, :vendor, presence: true
  validates :allocation_percentage, numericality: { greater_than_or_equal_to: 0 }
  validates :allocation_percentage, numericality: { less_than_or_equal_to: 100 } 
end
