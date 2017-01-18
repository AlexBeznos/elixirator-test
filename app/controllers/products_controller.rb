class ProductsController < ApplicationController
  skip_before_action :require_login

  def index
    @products = Product.all
  end
end
