class AddVendorToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :vendor, index: true
    remove_column :order_items, :quantity
  end
end
