class ProductArchivatesController < ApplicationController
  def destroy
    product = Product.find(params[:product_id])
    authorize product, :destroy?
    product.archivate!

    redirect_to root_path, notice: 'Product archived!'
  end
end
