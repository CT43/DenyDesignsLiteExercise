require 'rails_helper'

RSpec.describe ProductVendorAllocation, type: :model do
  before :each do
    @product = Product.create(name: "product test", sku: SecureRandom.uuid)
  end

  it "is valid with valid attributes" do
    expect(@product).to be_valid
  end

  it "is not valid without a name" do
    @product.name = nil
    expect(@product).to_not be_valid
  end

  it "is not valid without a sku" do
    @product.sku = nil
    expect(@product).to_not be_valid
  end

  it "is not valid without a unique sku" do
    @product2 = Product.create(name: "product test", sku: SecureRandom.uuid)
    @product.sku = @product2.sku
    expect(@product).to_not be_valid
  end
end
