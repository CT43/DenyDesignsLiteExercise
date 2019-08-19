class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.json :order_call

      t.timestamps
    end
  end
end
