class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product_vendor_allocations = ProductVendorAllocation.new
    @vendors = Vendor.all
  end

  def create
    @product = Product.new
    @product.name = product_params[:name]
    @product.sku = SecureRandom.uuid
    @product.save

    redirect_to new_product_vendor_allocation_path( product_id: @product.id, product_name: @product.name)
  end

  def show
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = product_params[:name]
    @product.sku = product_params[:sku]
    @product.save
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.product_vendor_allocations.destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku)
  end

end
