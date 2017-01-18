class ProductsController < ApplicationController
  skip_before_action :require_login

  def index
    filters = params.slice(:last_week_employee_updated)
    service = ProductListService.new(current_user, filters)

    @products = policy_scope(service.scope)
  end
end
