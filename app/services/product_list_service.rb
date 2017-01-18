class ProductListService
  def initialize(user, filters)
    @user = user
    @filters = filters
  end

  def scope
    default_scope = Product.includes(:updater)

    if @filters.fetch(:last_week_employee_updated, false)
      return default_scope.last_week_employee_updated
    end

    default_scope.order(user_order)
  end

  private

  def user_order
    @user && @user.admin? ? :price : :title
  end
end
