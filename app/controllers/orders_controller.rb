class OrdersController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  # def new
  #   @order = Order.new
  #   4.times do
  #     @order.order_items.build
  #   end
  # end

  def create
    @order = Order.new
    @order.order_call = order_params
    @order.save
    @order.errors.messages
    @order.create_order_items
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:sku, :quantity])
  end

end
