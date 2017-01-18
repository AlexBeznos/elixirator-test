class UserPolicy < ApplicationPolicy
  def show?
    user && (user.admin? || user == record)
  end
end
