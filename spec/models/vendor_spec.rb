require 'rails_helper'

RSpec.describe Vendor, type: :model do
  before :each do
    @vendor = Vendor.create(name: "vendor test")
  end

  it "is valid with valid attributes" do
    expect(@vendor).to be_valid
  end

  it "is not valid without a name" do
    @vendor.name = nil
    expect(@vendor).to_not be_valid
  end
end
