class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new
    @vendor.name = vendor_params[:name]
    @vendor.save
  end

  def show
  end

  def edit
    @vendor = Vendor.find_by(id: params[:id])
  end

  def update
    @vendor = Vendor.find_by(id: params[:id])
    @vendor.name = vendor_params[:name]
    @vendor.save
    redirect_to vendors_path
  end


  def destroy
    @vendor = Vendor.find_by(id: params[:id])
    @vendor.product_vendor_allocations.destroy
    @vendor.destroy
    redirect_to vendors_path
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name)
  end
end
