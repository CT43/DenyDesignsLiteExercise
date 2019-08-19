require 'rails_helper'
require 'pry'

RSpec.describe OrderItem, type: :model do
  before :each do
    @order_call = {
        "order_items_attributes": {
            "0": {
                "sku": "e0ed5374-e48e-401b-ae64-536c75c0dd4f",
                "quantity": "2"
            },
            "1": {
                "sku": "82f0018d-4eab-47d3-bca5-49dcd4c8dc30",
                "quantity": "3"
            }
        }
    }
    @vendor = Vendor.create(name: "vendor test")
    @product = Product.create(name: "product test", sku: SecureRandom.uuid)
    @order = Order.create(order_call: @order_call)
    @order_item = OrderItem.create(sku: "1234", product_id: @product.id, vendor_id: @vendor.id, order_id: @order.id)
  end

  it "is valid with valid attributes" do
    expect(@order_item).to be_valid
  end

  it "is not valid without a vendor" do
    @order_item.vendor = nil
    expect(@order_item).to_not be_valid
  end

  it "is not valid without a product" do
    @order_item.product = nil
    expect(@order_item).to_not be_valid
  end

  it "is not valid without a order" do
    @order_item.order = nil
    expect(@order_item).to_not be_valid
  end

end
