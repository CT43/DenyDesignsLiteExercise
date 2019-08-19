class CreateProductVendorAllocations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_vendor_allocations do |t|
      t.float :allocation_percentage, :default => 1.0
      t.belongs_to :product
      t.belongs_to :vendor
      
      t.timestamps
    end
  end
end
