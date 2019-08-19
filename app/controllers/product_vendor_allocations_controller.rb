class ProductVendorAllocationsController < ApplicationController

  def new
    @product_id = params[:product_id]
    @product_name = params[:product_name]
    @pva = ProductVendorAllocation.new
    @vendors = Vendor.all
  end

  def create
    @pva = ProductVendorAllocation.new
    @pva.vendor_id = pva_params[:vendor_id]
    @pva.product_id = pva_params[:product_id]
    @pva.allocation_percentage = pva_params[:product_vendor_allocation][:allocation_percentage]

    pva_exists_check_and_save
  end

  private

  def pva_params
    params.permit(:vendor_id, :product_id, product_vendor_allocation: {})
  end

  def pva_exists_check_and_save
    if ProductVendorAllocation.where("product_id = ? and vendor_id = ?", "#{@pva.product_id}", "#{@pva.vendor_id}").exists?
      @existing_pva = ProductVendorAllocation.where("product_id = ? and vendor_id = ?", "#{@pva.product_id}", "#{@pva.vendor_id}")[0]
      @existing_pva.allocation_percentage = pva_params[:product_vendor_allocation][:allocation_percentage]
      @existing_pva.save
    else
      @pva.save
    end
  end

end
