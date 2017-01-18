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

  class Scope < Scope
    def resolve
      if user && user.admin?
        scope.all
      else
        scope.active
      end
    end
  end
end
