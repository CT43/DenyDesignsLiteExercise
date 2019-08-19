require 'rails_helper'

RSpec.describe Order, type: :model do
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
    @order = Order.create(order_call: @order_call)
  end

  it "is valid with valid attributes" do
    expect(@order).to be_valid
  end

  it "is not valid without correct_order_call sku" do
    @order.order_call = {
            "order_items_attributes": {
                "0": {
                    "quantity": "2",
                    "sku": ""
                },
                "1": {
                    "sku": "82f0018d-4eab-47d3-bca5-49dcd4c8dc30",
                    "quantity": "3"
                }
            }
        }

    expect(@order).to_not be_valid
  end

  it "is not valid without correct order_call quantity" do
    @order.order_call = {
            "order_items_attributes": {
                "0": {
                    "quantity": "",
                    "sku": "e0ed5374-e48e-401b-ae64-536c75c0dd4f"
                },
                "1": {
                    "sku": "82f0018d-4eab-47d3-bca5-49dcd4c8dc30",
                    "quantity": "3"
                }
            }
        }

    expect(@order).to_not be_valid
  end

end
