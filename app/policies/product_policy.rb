class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    user
  end

  def destroy?
    user && (user.admin? || user.management?)
  end
end
