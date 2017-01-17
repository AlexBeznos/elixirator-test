class Product < ApplicationRecord
  def self.updated_during_last_week
    updated_at = Product.arel_table[:updated_at]

    where(updated_at.gteq(1.week.ago)).
      where(updated_at.lteq(1.day.ago))
  end

  def self.updated_by_employee
    user_join = <<-SQL
      INNER JOIN users
      ON users.id = products.updated_by
    SQL
    joins(user_join).merge(User.employee)
  end

  def self.last_week_employee_updated
    updated_by_employee
      .updated_during_last_week
      .order(updated_at: :desc)
  end
end
