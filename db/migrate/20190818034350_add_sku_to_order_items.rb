class AddSkuToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :sku, :string
  end
end
