class Order < ApplicationRecord
  has_many :order_items
  accepts_nested_attributes_for :order_items
  validates :order_call, presence: true

  validate :order_call_must_contain_order_item_attributes

  def create_order_items #this is what is called in order_controller create
    order_call["order_items_attributes"].each do |index, order_line|
      quantity = order_line["quantity"]
      quantity.to_i.times do
        create_order_item_with_correct_vendor_based_on_allocation_percentage(order_line)
      end
    end
  end

  private

  # the creation of OrderItem is standard witht he exception of assigning the vendor
  # the vendor has to be assigned based on an allocation table, in large enough sample sizes a simple random generator would probably cut it
  # but for consistincy, optimal manufacturing, and smaller samples the randomness is an issue so I assigned the vendors
  # by essentially creating a array/histogram in order_fill_array by querying all the order_items that have been processed since the
  # most recent update to the product's allocation table. Doing it from the most recent update is a must,
  # then with the array/histogram I compare each vendor's allocation_percentage with the actual percentage and
  # whichever vendor has the biggest discrepency is where the order_item gets assigned
  def create_order_item_with_correct_vendor_based_on_allocation_percentage(order_line)
    @order_item = create_and_assign_order_item(order_line)
    lowest_vendor_product_fill_discrepency = [1]
    find_lowest_fill_descrepency(create_order_items_allocation_counter, lowest_vendor_product_fill_discrepency)
    @order_item.vendor_id = lowest_vendor_product_fill_discrepency[1]
    @order_item.save
  end

  def create_and_assign_order_item(order_line)
    @order_item = OrderItem.new
    @order_item.sku = order_line["sku"]
    @order_item.order_id = id
    @product = Product.find_by(sku: "#{@order_item.sku}")
    @order_item.product_id = @product.id
    @order_item
  end

  def create_order_items_allocation_counter
    order_fill_array = []
    pva_last_update = ProductVendorAllocation.where("product_id = #{@order_item.product_id}").order(:updated_at).last.updated_at
    order_items_since_update = OrderItem.where("product_id = ? AND updated_at >= ?", @order_item.product_id, pva_last_update)
    Vendor.all.count.times {order_fill_array << 0}
    order_items_since_update.each { |order_item| order_fill_array[order_item.vendor_id - 1] += 1}
    return order_fill_array
  end

  def find_lowest_fill_descrepency(order_fill_array, lowest_vendor_product_fill_discrepency)
    ProductVendorAllocation.where("product_id = #{@order_item.product_id}").each do |pva|
      count = order_fill_array[pva.vendor_id - 1]
      sum = order_fill_array.sum
      sum += 1 if sum === 0
      current_percentage = count/sum
      allocation_percentage = pva.allocation_percentage / 100
      discrepency = current_percentage - allocation_percentage
      if lowest_vendor_product_fill_discrepency[0] > discrepency
        lowest_vendor_product_fill_discrepency[0] = discrepency
        lowest_vendor_product_fill_discrepency[1] = pva.vendor_id
      end
    end
  end

  def order_call_must_contain_order_item_attributes
    order_call["order_items_attributes"].each do |index, order_line|
      if order_line["sku"] != "" && order_line["quantity"] != ""
      else
        errors.add(:order_call, "order lines must contain sku and quantity")
      end
    end
  end
end
